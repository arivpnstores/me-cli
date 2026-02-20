#!/usr/bin/env bash
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install python-pillow -y
git clone https://github.com/purplemashu/me-cli-sunset
cd me-cli-sunset
pkg install wget -y
wget -O decoy_data/decoy-default-balance.json https://raw.githubusercontent.com/arivpnstores/me-cli/main/decoy-default-balance.json
bash setup.sh
python main.py
