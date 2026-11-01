@echo off
cd /d "%~dp0"
call "E:\amd\Vivado\2024.2\bin\xsim.bat" powerup.wdb -gui -view powerup.wcfg
if errorlevel 1 pause
