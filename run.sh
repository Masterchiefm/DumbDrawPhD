#!/bin/bash

# 激活虚拟环境并运行应用
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"
source venv/bin/activate
python ChartGenuins.py
deactivate