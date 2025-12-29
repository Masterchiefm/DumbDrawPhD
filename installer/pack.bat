
chcp 65001 > nul

call conda activate py39
if errorlevel 1 (
    echo Failed to activate conda environment py39
    pause
    exit /b 1
)

cd ..
if errorlevel 1 (
    echo Failed to change directory
    pause
    exit /b 1
)

pip uninstall DumbyDraw -y
pip install .
if errorlevel 1 (
    echo Failed to install DumbyDraw
    pause
    exit /b 1
)


cd installer
if errorlevel 1 (
    echo Failed to enter installer directory
    pause
    exit /b 1
)

if exist DumbyDraw_env.tar.gz (
    del /f /q DumbyDraw_env.tar.gz
)

conda pack -n py39 -o DumbyDraw_env.tar.gz --ignore-missing-files
if errorlevel 1 (
    echo Failed to pack conda environment
    pause
    exit /b 1
)

if exist DumbyDraw_Setup.exe (
    del /f /q DumbyDraw_Setup.exe
)

if exist "C:\Program Files (x86)\NSIS\makensis.exe" (
    "C:\Program Files (x86)\NSIS\makensis.exe" install.nsi
) else (
    echo NSIS not found at default location
    echo Please ensure NSIS is installed or update the path
    pause
    exit /b 1
)

if exist DumbyDraw_env.tar.gz (
    del /f /q DumbyDraw_env.tar.gz
)

echo All operations completed successfully
pause