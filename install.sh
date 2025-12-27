#!/bin/bash

# 检查是否安装了python3
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Please install Python3 first."
    exit 1
fi

# 检查是否安装了virtualenv
if ! python3 -m pip show virtualenv &> /dev/null
then
    echo "Installing virtualenv..."
    python3 -m pip install virtualenv --index-url https://pypi.tuna.tsinghua.edu.cn/simple
fi

# 创建虚拟环境
echo "Creating virtual environment..."
python3 -m virtualenv venv

# 激活虚拟环境并安装依赖
echo "Installing requirements..."
source venv/bin/activate
pip install --upgrade pip --index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple
deactivate

# 创建快捷方式
echo "Creating desktop shortcut..."
OS_TYPE=$(uname -s)
DESKTOP_PATH=""

if [ "$OS_TYPE" = "Darwin" ]; then
    # macOS
    DESKTOP_PATH="$HOME/Desktop/ChartGenius.app"
    cat > "$HOME/ChartGenius" << 'EOF'
#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"
source venv/bin/activate
python DumbDrawPhD.py
deactivate
EOF
    chmod +x "$HOME/ChartGenius"
    echo "Please manually create an app bundle on macOS"
elif [ "$OS_TYPE" = "Linux" ]; then
    # Ubuntu/Linux
    DESKTOP_PATH="$HOME/Desktop/ChartGenius.desktop"
    cat > "$DESKTOP_PATH" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=true
Exec=$PWD/run.sh
Path=$PWD
Name=ChartGenius
Comment=Run ChartGenius Application
Icon=$PWD/icon.png
EOF
    chmod +x "$DESKTOP_PATH"
fi

echo "Installation complete!"