#!/usr/bin/env bash
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install python-pillow -y
git clone https://github.com/purplemashu/me-cli-sunset
cd me-cli-sunset
pip install -r requirements.txt
nano .env
python main.py
