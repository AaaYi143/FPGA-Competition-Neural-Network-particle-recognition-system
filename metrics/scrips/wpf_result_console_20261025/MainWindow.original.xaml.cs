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

            try
            {
                while (!token.IsCancellationRequested)
                {
                    try
                    {
                        int count = await port.BaseStream.ReadAsync(buffer.AsMemory(), token);

                        if (count > 0)
                        {
                            string hex = Convert.ToHexString(buffer.AsSpan(0, count));

                            Console.WriteLine($"[{DateTime.Now:HH:mm:ss.fff}] RX: {hex}");
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
