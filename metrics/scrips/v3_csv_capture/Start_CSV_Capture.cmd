@echo off
setlocal
set "CAPTURE_PYTHON=%~dp0..\..\learning\nn_fpga\.venv\Scripts\python.exe"
if not exist "%CAPTURE_PYTHON%" (
    echo Python environment not found: %CAPTURE_PYTHON%
    pause
    exit /b 1
)
"%CAPTURE_PYTHON%" "%~dp0capture.py"
if errorlevel 1 pause
