using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using 激光颗粒检测上位机;

internal static class ParserTests
{
    private static int checks;
    private static void Check(bool condition, string message)
    { checks++; if (!condition) throw new Exception(message); }
    private static byte[] Hex(string hex)
    {
        string[] words = hex.Split(new char[] { ' ', '\r', '\n', '\t' }, StringSplitOptions.RemoveEmptyEntries);
        var data = new byte[words.Length];
        for (int i = 0; i < words.Length; i++) data[i] = Convert.ToByte(words[i], 16);
        return data;
    }
    private static List<ParticlePacket> Feed(ParticlePacketParser parser, byte[] data, int offset, int count)
    {
        var packets = new List<ParticlePacket>();
        for (int i = offset; i < offset + count; i++)
        { ParticlePacket packet; if (parser.Feed(data[i], out packet)) packets.Add(packet); }
        return packets;
    }
    private static byte[] Packet(int version, int sequence, int value, int flags)
    {
        var b = new byte[] { 0xA5, 0x5A, (byte)version, (byte)sequence, (byte)value, (byte)flags, 0, 13 };
        b[6] = ParticlePacketParser.Crc8(b, 2, 4); return b;
    }
    private static void ExpectRejected(byte[] bytes)
    {
        var parser = new ParticlePacketParser();
        Check(Feed(parser, bytes, 0, bytes.Length).Count == 0, "Invalid packet accepted");
        byte[] valid = Hex("A5 5A 02 01 01 00 52 0D");
        Check(Feed(parser, valid, 0, valid.Length).Count == 1, "Failed to recover after invalid packet");
    }
    public static void Main(string[] args)
    {
        Console.OutputEncoding = new UTF8Encoding(false);
        byte[] standard = Encoding.ASCII.GetBytes("123456789");
        Check(ParticlePacketParser.Crc8(standard, 0, standard.Length) == 0xF4, "CRC check vector");
        string[] golden = {
            "A5 5A 02 00 00 02 22 0D", "A5 5A 02 01 01 00 52 0D",
            "A5 5A 02 02 02 01 D7 0D", "A5 5A 02 03 03 00 AE 0D", "A5 5A 02 04 04 00 D3 0D" };
        for (int code = 0; code < 5; code++)
        {
            var b = Hex(golden[code]);
            for (int cut = 0; cut <= b.Length; cut++)
            {
                var parser = new ParticlePacketParser();
                var result = Feed(parser, b, 0, cut);
                result.AddRange(Feed(parser, b, cut, b.Length - cut));
                Check(result.Count == 1 && result[0].Result == code, "Split packet mismatch");
                Check(result[0].IsEmpty == (code == 0), "Empty mapping mismatch");
            }
        }
        for (int version = 1; version <= 2; version++)
            for (int seq = 0; seq < 256; seq++)
                for (int code = 0; code < (version == 1 ? 4 : 5); code++)
                {
                    int flags = (seq & 1) | ((version == 2 && code == 0) ? 2 : 0);
                    byte[] b = Packet(version, seq, code, flags);
                    var items = Feed(new ParticlePacketParser(), b, 0, 8);
                    Check(items.Count == 1 && items[0].Result == (version == 1 ? code + 1 : code), "Code/version mapping");
                    if (version == 1)
                    {
                        b = Packet(version, seq, code, flags | 2);
                        items = Feed(new ParticlePacketParser(), b, 0, 8);
                        Check(items.Count == 1 && items[0].Result == 0, "Legacy empty mapping");
                    }
                }
        for (int bit = 0; bit < 64; bit++)
        {
            byte[] b = Hex(golden[3]); b[bit / 8] ^= (byte)(1 << (bit % 8)); ExpectRejected(b);
        }
        ExpectRejected(Packet(2, 0, 5, 0)); ExpectRejected(Packet(2, 0, 0, 0));
        ExpectRejected(Packet(2, 0, 1, 2)); ExpectRejected(Packet(1, 0, 4, 0));
        ExpectRejected(Packet(3, 0, 1, 0)); ExpectRejected(Packet(2, 0, 1, 4));
        var mixed = new List<byte>(new byte[] { 0, 255, 0xA5, 0xA5 });
        foreach (string g in golden) mixed.AddRange(Hex(g));
        Check(Feed(new ParticlePacketParser(), mixed.ToArray(), 0, mixed.Count).Count == 5, "Noise/overlap/coalesced frames");
        byte[] lost = Hex(golden[2]);
        for (int cut = 0; cut < 8; cut++)
        {
            var stream = new List<byte>(lost); stream.RemoveAt(cut); stream.AddRange(Hex(golden[4]));
            var got = Feed(new ParticlePacketParser(), stream.ToArray(), 0, stream.Count);
            Check(got.Count == 1 && got[0].Result == 4, "Dropped-byte recovery");
        }
        var noisy = new ParticlePacketParser();
        for (int i = 0; i < 100000; i++) { ParticlePacket ignored; noisy.Feed((byte)(i % 11), out ignored); }
        Check(Feed(noisy, Hex(golden[1]), 0, 8).Count == 1, "Bounded-noise recovery");
        var tracker = new ParticleSequenceTracker(); int gap;
        Check(tracker.Accept(new ParticlePacket(2, 255, 1, 0), 0, out gap) && gap == 0, "First sequence");
        Check(tracker.Accept(new ParticlePacket(2, 0, 2, 0), 10, out gap) && gap == 0, "Sequence wrap");
        Check(!tracker.Accept(new ParticlePacket(2, 0, 2, 0), 1000, out gap), "Duplicate accepted");
        Check(tracker.Accept(new ParticlePacket(2, 3, 4, 0), 1500, out gap) && gap == 2, "Sequence gap");
        Check(!tracker.Accept(new ParticlePacket(2, 3, 4, 0), 3499, out gap), "Duplicate refreshed deadline");
        Check(tracker.Accept(new ParticlePacket(2, 3, 4, 0), 3500, out gap) && gap == 0, "Timeout resync");
        string formatted = ParticlePacketFormatter.Format(new ParticlePacket(2, 18, 2, 1), 3);
        Check(formatted.Contains("珍珠粉") && formatted.Contains("编号=2") && formatted.Contains("SEQ=018") && formatted.Contains("CRC=OK") && formatted.Contains("跳号估计=3"), "Console format");
        if (args.Length == 2)
        {
            byte[] stm = Hex(File.ReadAllText(args[0])); byte[] pc = Hex(File.ReadAllText(args[1]));
            var a = Feed(new ParticlePacketParser(), stm, 0, stm.Length);
            var b = Feed(new ParticlePacketParser(), pc, 0, pc.Length);
            Check(a.Count == 274 && b.Count == 273, "Actual RTL packet count");
            for (int i = 0; i < b.Count; i++)
                Check(a[i + 1].Sequence == b[i].Sequence && a[i + 1].Result == b[i].Result && a[i + 1].Flags == b[i].Flags, "Actual two-UART disagreement");
            var actualTracker = new ParticleSequenceTracker(); int codes = 0;
            for (int i = 0; i < a.Count; i++)
            {
                Check(actualTracker.Accept(a[i], i * 10, out gap), "Actual RTL duplicate"); codes |= 1 << a[i].Result;
            }
            Check(actualTracker.EstimatedMissing == 23 && codes == 31, "Actual RTL gaps/codes");
            Console.WriteLine("RTL_REPLAY_PASS STM=274 PC=273 gaps=23 all_five_codes=PASS");
        }
        foreach (string g in golden)
        {
            var item = Feed(new ParticlePacketParser(), Hex(g), 0, 8)[0];
            Console.WriteLine(ParticlePacketFormatter.Format(item, 0));
        }
        Console.WriteLine("PARSER_ALL_PASS checks=" + checks);
    }
}
