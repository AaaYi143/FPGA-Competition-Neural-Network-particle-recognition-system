@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build_Vote20.ps1"
if errorlevel 1 echo Build failed. See verification\arm_build.log.
pause
