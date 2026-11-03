# 当前交付：仅修改 ReadSerialAsync

依据用户最新限制，MainWindow.xaml.cs 已恢复原始构造函数、字段、using、事件和串口配置，只替换 ReadSerialAsync 的方法体。没有新增类、结构、接口或其他方法。

解析状态、固定8字节缓冲、CRC8、新旧版本兼容、序号过滤与类别名称输出均在该方法内部。SW6打开，电脑串口保持原配置115200/8E1。

MainWindow.original.xaml.cs为用户原版。method_only_verification.json记录方法外字节完全一致；ReadSerialAsync.only.txt提供仅方法文本。

此前tests和verification.json是上一轮扩展实现的历史验证，不能作为当前限定修改版本的运行验证；当前已进行修改范围和源文件复制一致性检查，没有进行实板串口测试。
