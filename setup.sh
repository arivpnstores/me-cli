#!/usr/bin/env bash
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install python-pillow -y
git clone https://github.com/purplemashu/me-cli-sunset
cd me-cli-sunset
wget -O decoy_data/decoy-default-balance.json https://raw.githubusercontent.com/arivpnstores/me-cli/refs/heads/main/decoy-default-balance.json
wget -O hot_data/hot.json https://raw.githubusercontent.com/arivpnstores/me-cli/refs/heads/main/hot.json
wget -O hot_data/hot2.json https://raw.githubusercontent.com/arivpnstores/me-cli/refs/heads/main/hot2.json
bash setup.sh
python main.py
