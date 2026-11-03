$ErrorActionPreference='Stop'
$source=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'MainWindow.xaml.cs') -Raw -Encoding UTF8
$start=$source.IndexOf('    // BEGIN PARTICLE_PROTOCOL')
$end=$source.IndexOf('    // END PARTICLE_PROTOCOL')
if($start -lt 0 -or $end -le $start){throw 'Protocol section missing'}
$protocol="using System;`nnamespace 激光颗粒检测上位机`n{`n"+$source.Substring($start,$end-$start)+"}`n"
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'tests/ProtocolUnderTest.cs'),$protocol,[Text.UTF8Encoding]::new($false))
$csc='C:/Windows/Microsoft.NET/Framework64/v4.0.30319/csc.exe'
$wpf='C:\Windows\Microsoft.NET\Framework64\v4.0.30319\WPF'
Push-Location (Join-Path $PSScriptRoot 'tests')
try {
 & $csc /nologo /codepage:65001 /langversion:5 /target:library /out:MainWindow.compilecheck.dll ('/reference:'+$wpf+'\PresentationFramework.dll') ('/reference:'+$wpf+'\PresentationCore.dll') ('/reference:'+$wpf+'\WindowsBase.dll') /reference:System.Xaml.dll '..\MainWindow.xaml.cs' WpfCompileStub.cs
 if($LASTEXITCODE){throw 'WPF code compilation failed'}
 & $csc /nologo /codepage:65001 /langversion:5 /checked+ /out:ParserTests.exe ProtocolUnderTest.cs ParserTests.cs
 if($LASTEXITCODE){throw 'Parser compilation failed'}
 & ./ParserTests.exe fixtures/stm_uart_bytes.txt fixtures/pc_uart_bytes.txt 2>&1 | Tee-Object test_results.log
 if($LASTEXITCODE){throw 'Parser tests failed'}
} finally {Pop-Location}
