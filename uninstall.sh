#!/bin/bash

# 删除虚拟环境
echo "Removing virtual environment..."
rm -rf venv

# 删除快捷方式
echo "Removing desktop shortcuts..."
OS_TYPE=$(uname -s)

if [ "$OS_TYPE" = "Darwin" ]; then
    rm -f "$HOME/ChartGenius"
    echo "Please manually remove the app bundle on macOS"
elif [ "$OS_TYPE" = "Linux" ]; then
    rm -f "$HOME/Desktop/ChartGenius.desktop"
fi

echo "Uninstallation complete!"