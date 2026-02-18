#!/usr/bin/env bash
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install python-pillow -y
git clone https://github.com/arivpnstores/me-cli-sunset
cd me-cli-sunset
pip install -r requirements.txt
bash setup.sh
python main.py
