$ErrorActionPreference='Stop'
$work=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$python=Join-Path $PSScriptRoot '.venv/Scripts/python.exe'
$script=Join-Path $PSScriptRoot 'flash_vote20.py'
if(!(Test-Path -LiteralPath $python)){throw 'Missing isolated pyOCD environment: tools/stm32_flash/.venv'}
$run=Join-Path $work ('reports/stm32_flash_vote20_'+(Get-Date -Format 'yyyyMMdd_HHmmss'))
if(Test-Path -LiteralPath $run){throw 'Backup directory already exists; try again after one second.'}
New-Item -ItemType Directory -Path $run | Out-Null
Write-Host 'STM32 vote20: Fire CMSIS-DAP / SWD. Close other debug sessions first.'
foreach($phase in @('inspect','flash','status')){
 $logName=if($phase -eq 'flash'){'program_and_verify.log'}else{$phase+'.log'}
 & $python $script $phase --protocol swd --run $run 2>&1 | Tee-Object -FilePath (Join-Path $run $logName)
 if($LASTEXITCODE){throw ('Stopped at '+$phase+'. Inspect '+$run+'. No later phase was run.')}
}
& $python (Join-Path $PSScriptRoot 'record_vote20_flash.py') --run $run
if($LASTEXITCODE){throw 'Flash completed but receipt check failed; retain the logs.'}
Write-Host ('Completed. Original backup and full readback: '+$run)
