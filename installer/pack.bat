@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo ========================================
echo Starting installation process...
echo ========================================

:: 激活 conda 环境
echo Activating conda environment py39...
call conda activate py39
if errorlevel 1 (
    echo ERROR: Failed to activate conda environment py39
    pause
    exit /b 1
)
echo Conda environment activated successfully.

:: 返回上级目录
echo Changing to parent directory...
cd ..
if errorlevel 1 (
    echo ERROR: Failed to change directory
    pause
    exit /b 1
)
echo Current directory: %cd%

:: 卸载并重新安装包
echo Uninstalling old DumbyDraw...
pip uninstall DumbyDraw -y

echo Installing DumbyDraw...
pip install .
if errorlevel 1 (
    echo ERROR: Failed to install DumbyDraw
    pause
    exit /b 1
)
echo DumbyDraw installed successfully.

:: 进入 installer 目录
echo Entering installer directory...
cd installer
if errorlevel 1 (
    echo ERROR: Failed to enter installer directory
    pause
    exit /b 1
)
echo Current directory: %cd%

:: 删除旧的打包文件
if exist DumbyDraw_env.tar.gz (
    echo Deleting old environment package...
    del /f /q DumbyDraw_env.tar.gz
    echo Old package deleted.
)

:: 打包 conda 环境
echo ========================================
echo Starting conda pack process...
echo This may take several minutes...
echo ========================================

call conda pack -n py39 -o DumbyDraw_env.tar.gz --ignore-missing-files
set PACK_RESULT=%errorlevel%
echo conda pack exit code: !PACK_RESULT!

if !PACK_RESULT! neq 0 (
    echo ERROR: Failed to pack conda environment
    echo Check if:
    echo 1. Environment 'py39' exists
    echo 2. You have write permissions
    echo 3. Enough disk space is available
    pause
    exit /b 1
)
echo Environment packed successfully: DumbyDraw_env.tar.gz

:: 删除旧的安装程序
if exist DumbyDraw_Setup.exe (
    echo Deleting old setup file...
    del /f /q DumbyDraw_Setup.exe
)

:: 使用 NSIS 创建安装程序
echo ========================================
echo Creating installer with NSIS...
echo ========================================

if exist "C:\Program Files (x86)\NSIS\makensis.exe" (
    echo Found NSIS at default location
    "C:\Program Files (x86)\NSIS\makensis.exe" install.nsi
    if errorlevel 1 (
        echo ERROR: NSIS compilation failed
        pause
        exit /b 1
    )
    echo Installer created successfully.
) else (
    echo ERROR: NSIS not found at default location
    echo Please ensure NSIS is installed or update the path
    pause
    exit /b 1
)

:: 清理临时文件
if exist DumbyDraw_env.tar.gz (
    echo Cleaning up temporary files...
    del /f /q DumbyDraw_env.tar.gz
)

echo ========================================
echo All operations completed successfully!
echo ========================================
pause
