using System.IO;
using System.IO.Ports;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace 激光颗粒检测上位机
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool AllocConsole();

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool FreeConsole();

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr GetStdHandle(int nStdHandle);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool SetStdHandle(int nStdHandle, IntPtr handle);

        private const int STD_INPUT_HANDLE = -10;
        private const int STD_OUTPUT_HANDLE = -11;
        private const int STD_ERROR_HANDLE = -12;

        public MainWindow()
        {
            InitializeComponent();

            AllocConsole();

            var stdin = GetStdHandle(STD_INPUT_HANDLE);
            var stdout = GetStdHandle(STD_OUTPUT_HANDLE);
            var stderr = GetStdHandle(STD_ERROR_HANDLE);

            SetStdHandle(STD_INPUT_HANDLE, stdin);
            SetStdHandle(STD_OUTPUT_HANDLE, stdout);
            SetStdHandle(STD_ERROR_HANDLE, stderr);

            Console.SetIn(new StreamReader(Console.OpenStandardInput(), Console.InputEncoding));

            Console.SetOut(
                new StreamWriter(Console.OpenStandardOutput(), Console.OutputEncoding)
                {
                    AutoFlush = true,
                }
            );

            Console.SetError(
                new StreamWriter(Console.OpenStandardError(), Console.OutputEncoding)
                {
                    AutoFlush = true,
                }
            );
        }

        private void RefreshPorts()
        {
            string? selected = comBox.SelectedItem as string;

            comBox.ItemsSource = SerialPort.GetPortNames();

            if (selected != null && comBox.Items.Contains(selected))
            {
                comBox.SelectedItem = selected;
            }
            else if (comBox.Items.Count > 0)
            {
                comBox.SelectedIndex = 0;
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            RefreshPorts();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            RefreshPorts();
        }

        private SerialPort? _serialPort;
        private CancellationTokenSource? _readCts;

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            if (_serialPort?.IsOpen == true)
                return;

            if (comBox.SelectedItem is not string portName)
            {
                Console.WriteLine("请先选择串口！");
                return;
            }

            try
            {
                _serialPort = new SerialPort(portName, 115200)
                {
                    BaudRate = 115200,
                    DataBits = 8,
                    Parity = Parity.Even,
                    StopBits = StopBits.One,
                    Handshake = Handshake.None,
                    ReadTimeout = 500,
                    WriteTimeout = 500,
                };

                _serialPort.Open();

                Console.WriteLine($"串口已打开：{portName}");

                _readCts = new CancellationTokenSource();
                _ = ReadSerialAsync(_serialPort, _readCts.Token);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"打开串口失败：{ex.Message}");
                _serialPort?.Dispose();
                _serialPort = null;
            }
        }

        private async Task ReadSerialAsync(SerialPort port, CancellationToken token)
        {
            byte[] buffer = new byte[1024];
            byte[] frame = new byte[8];
            int frameLength = 0;
            int lastSequence = -1;
            long lastResultTime = 0;
            var clock = System.Diagnostics.Stopwatch.StartNew();

            try
            {
                while (!token.IsCancellationRequested)
                {
                    try
                    {
                        int count = await port.BaseStream.ReadAsync(buffer.AsMemory(), token);

                        for (int i = 0; i < count; i++)
                        {
                            // 接收次数不等于数据包数量，跨多次读取保留这8字节窗口。
                            frame[frameLength++] = buffer[i];
                            if (frameLength < 8)
                                continue;

                            byte version = frame[2];
                            byte value = frame[4];
                            byte flags = frame[5];
                            bool valid = frame[0] == 0xA5 && frame[1] == 0x5A
                                && frame[7] == 0x0D && (flags & 0xFC) == 0;

                            // CRC8：多项式07，初始00，覆盖字节2～5。
                            byte crc = 0;
                            for (int j = 2; j <= 5; j++)
                            {
                                crc ^= frame[j];
                                for (int bit = 0; bit < 8; bit++)
                                    crc = unchecked((byte)((crc & 0x80) != 0
                                        ? (crc << 1) ^ 0x07 : crc << 1));
                            }
                            valid = valid && crc == frame[6];

                            if (version == 2)
                                valid = valid && value <= 4
                                    && ((value == 0) == ((flags & 0x02) != 0));
                            else if (version == 1)
                                valid = valid && value < 4;
                            else
                                valid = false;

                            if (!valid)
                            {
                                // 坏包或噪声只滑动一个字节，继续寻找包头。
                                Array.Copy(frame, 1, frame, 0, 7);
                                frameLength = 7;
                                continue;
                            }

                            frameLength = 0;
                            int sequence = frame[3];
                            long now = clock.ElapsedMilliseconds;
                            if (lastSequence >= 0 && now - lastResultTime >= 2000)
                                lastSequence = -1;
                            if (sequence == lastSequence)
                                continue;

                            int skipped = lastSequence < 0 ? 0
                                : (sequence - lastSequence - 1 + 256) & 0xFF;
                            lastSequence = sequence;
                            lastResultTime = now;

                            // v2：0空载、1～4颗粒；v1：原0～3加一，空载标志优先。
                            int result = (flags & 0x02) != 0 ? 0
                                : (version == 1 ? value + 1 : value);
                            string name;
                            switch (result)
                            {
                                case 0: name = "无颗粒"; break;
                                case 1: name = "小米"; break;
                                case 2: name = "珍珠粉"; break;
                                case 3: name = "细盐"; break;
                                case 4: name = "白砂糖"; break;
                                default: continue;
                            }

                            string background = (flags & 1) != 0 ? "开" : "关";
                            string gap = skipped > 0 ? $" | 跳号估计={skipped}" : "";
                            Console.WriteLine(
                                $"[{DateTime.Now:HH:mm:ss.fff}] 分类结果：{name} | 编号={result}"
                                + $" | SEQ={sequence:D3} | 协议=v{version} | 背景扣除={background} | CRC=OK{gap}");
                        }
                    }
                    catch (OperationCanceledException)
                    {
                        break;
                    }
                    catch (IOException ex)
                    {
                        if (!token.IsCancellationRequested)
                            Console.WriteLine($"串口读取错误：{ex.Message}");

                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                if (!token.IsCancellationRequested)
                    Console.WriteLine($"读取异常：{ex.Message}");
            }
        }
    }
}
