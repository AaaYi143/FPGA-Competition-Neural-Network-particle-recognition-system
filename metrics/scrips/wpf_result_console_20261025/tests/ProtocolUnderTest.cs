using System;
namespace 激光颗粒检测上位机
{
    // BEGIN PARTICLE_PROTOCOL -- no WPF/serial dependencies; tested offline.
    internal sealed class ParticlePacket
    {
        public byte Version { get; private set; }
        public byte Sequence { get; private set; }
        public byte Result { get; private set; }
        public byte Flags { get; private set; }
        public bool IsEmpty { get { return Result == 0; } }
        public bool BackgroundEnabled { get { return (Flags & 1) != 0; } }
        public string Name
        {
            get
            {
                switch (Result)
                {
                    case 0: return "无颗粒";
                    case 1: return "小米";
                    case 2: return "珍珠粉";
                    case 3: return "细盐";
                    case 4: return "白砂糖";
                    default: return "非法编号";
                }
            }
        }
        public ParticlePacket(byte version, byte sequence, byte result, byte flags)
        { Version = version; Sequence = sequence; Result = result; Flags = flags; }
    }

    internal sealed class ParticlePacketParser
    {
        // Bounded sliding window handles split/coalesced packets, leading noise,
        // lost bytes and overlapping A5 headers without growing a List forever.
        private readonly byte[] _window = new byte[8];
        private int _length;
        public long ValidPackets { get; private set; }
        public long RejectedPackets { get; private set; }

        public bool Feed(byte value, out ParticlePacket packet)
        {
            packet = null;
            _window[_length++] = value;
            if (_length < 8) return false;
            if (_window[0] == 0xA5 && _window[1] == 0x5A)
            {
                byte version = _window[2], result = _window[4], flags = _window[5];
                bool valid = (flags & 0xFC) == 0 && _window[7] == 0x0D
                    && Crc8(_window, 2, 4) == _window[6];
                if (version == 2)
                    valid = valid && result <= 4 && ((result == 0) == ((flags & 2) != 0));
                else if (version == 1)
                    valid = valid && result < 4;
                else valid = false;
                if (valid)
                {
                    byte normalized = (flags & 2) != 0 ? (byte)0 : (version == 1 ? (byte)(result + 1) : result);
                    packet = new ParticlePacket(version, _window[3], normalized, flags);
                    _length = 0;
                    ValidPackets++;
                    return true;
                }
                RejectedPackets++;
            }
            Array.Copy(_window, 1, _window, 0, 7);
            _length = 7;
            return false;
        }

        // CRC-8/SMBUS (ATM): poly 07, init 00, no reflection/final XOR.
        // Packet checksum covers VERSION, SEQ, RESULT/CLASS, FLAGS only.
        internal static byte Crc8(byte[] bytes, int offset, int count)
        {
            byte crc = 0;
            for (int i = offset; i < offset + count; i++)
            {
                crc ^= bytes[i];
                for (int bit = 0; bit < 8; bit++)
                    crc = unchecked((byte)((crc & 0x80) != 0 ? (crc << 1) ^ 0x07 : crc << 1));
            }
            return crc;
        }
    }

    internal sealed class ParticleSequenceTracker
    {
        private bool _haveSequence;
        private byte _lastSequence;
        private long _lastFreshMilliseconds;
        public long Duplicates { get; private set; }
        public long EstimatedMissing { get; private set; }

        public bool Accept(ParticlePacket packet, long nowMilliseconds, out int gap)
        {
            gap = 0;
            // After 2s without a fresh packet, accept a restarted FPGA sequence.
            if (_haveSequence && nowMilliseconds - _lastFreshMilliseconds >= 2000)
                _haveSequence = false;
            if (_haveSequence && packet.Sequence == _lastSequence)
            { Duplicates++; return false; }
            if (_haveSequence) gap = (packet.Sequence - _lastSequence - 1 + 256) & 0xFF;
            EstimatedMissing += gap;
            _haveSequence = true;
            _lastSequence = packet.Sequence;
            _lastFreshMilliseconds = nowMilliseconds;
            return true;
        }
    }

    internal static class ParticlePacketFormatter
    {
        public static string Format(ParticlePacket packet, int gap)
        {
            string suffix = gap > 0 ? string.Format(" | 跳号估计={0}", gap) : string.Empty;
            return string.Format("分类结果：{0} | 编号={1} | SEQ={2:D3} | 协议=v{3} | 背景扣除={4} | CRC=OK{5}",
                packet.Name, packet.Result, packet.Sequence, packet.Version,
                packet.BackgroundEnabled ? "开" : "关", suffix);
        }
    }
}
