@echo off
setlocal

set APPDATA_DIR=%LOCALAPPDATA%\DumbDrawPhD
if not exist "%APPDATA_DIR%" (
    mkdir "%APPDATA_DIR%" 2>nul
)

set ROOT=%~dp0
rem Remove trailing backslash if present
set ROOT=%ROOT:~0,-1%
set ENV=%ROOT%\env

if not exist "%ENV%\Scripts\activate.bat" (
    echo Error: Python virtual environment not found at:
    echo %ENV%\Scripts\activate.bat
    echo Please ensure the environment is properly set up.
    pause
    exit /b 1
)

rem Set environment variable for the application
set DUMBDRAW_DATA_DIR=%APPDATA_DIR%

rem Activate virtual environment
call "%ENV%\Scripts\activate.bat"
if errorlevel 1 (
    echo Failed to activate Python virtual environment
    pause
    exit /b 1
)

rem Run the application
if exist "%ENV%\Scripts\DumbDrawPhD.exe" (
    "%ENV%\Scripts\DumbDrawPhD.exe"
) else (
    echo Error: DumbDrawPhD.exe not found at:
    echo %ENV%\Scripts\DumbDrawPhD.exe
    pause
    exit /b 1
)

endlocal