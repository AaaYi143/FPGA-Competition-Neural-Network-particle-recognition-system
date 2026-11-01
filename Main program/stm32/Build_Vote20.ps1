$ErrorActionPreference='Stop'
Set-Location $PSScriptRoot
$tool='C:/Users/cyka1/AppData/Local/stm32cube/bundles/gnu-tools-for-stm32/14.3.1+st.2/bin'
if (!(Test-Path "$tool/arm-none-eabi-gcc.exe")) { throw 'Install GNU Tools for STM32 14.3.1 or update tool path in Build_Vote20.ps1' }
$env:PATH="$tool;$env:PATH"
& make -j2 BUILD_DIR=build_vote20 all *> verification/arm_build.log
if($LASTEXITCODE -ne 0) {Get-Content verification/arm_build.log -Tail 60;throw 'STM32 build failed'}
& arm-none-eabi-size -A build_vote20/F103RC_Particle_Display.elf | Set-Content verification/memory_sections.txt
New-Item -ItemType Directory -Force -Path output | Out-Null
foreach($extension in 'hex','bin','elf') {Copy-Item "build_vote20/F103RC_Particle_Display.$extension" "output/STM32_PARTICLE_VOTE20.$extension" -Force}
Get-Content verification/arm_build.log -Tail 5
