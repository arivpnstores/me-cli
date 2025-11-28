#!/bin/bash
set -e

echo "🔍 Mengecek versi Ubuntu..."
UBU_VERSION=$(lsb_release -rs)
echo "➡️ Ubuntu versi: $UBU_VERSION"

# Update & Upgrade
apt update -y && apt upgrade -y

# Install dependencies dasar
apt install -y git software-properties-common build-essential \
  zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
  libreadline-dev libffi-dev libsqlite3-dev wget

# Clone repo jika belum ada
if [ ! -d "me-cli-sunset" ]; then
  git clone https://github.com/purplemashu/me-cli-sunset
fi
cd me-cli-sunset

# -------------------------------
# Compile Python 3.11 dari source
# -------------------------------
echo "🐍 Download Python 3.11..."
cd /usr/src
wget https://www.python.org/ftp/python/3.11.7/Python-3.11.7.tgz
tar xzf Python-3.11.7.tgz
cd Python-3.11.7

echo "⚙️ Compile Python 3.11..."
./configure --enable-optimizations
make -j$(nproc)
make altinstall

# Cek versi Python 3.11
python3.11 --version

# Kembali ke folder me-cli
cd ~/me-cli-sunset

# Buat virtual environment
echo "📦 Membuat virtual environment..."
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip & install requirements
pip install --upgrade pip

# Jika ada versi requests==2.32.5 di requirements.txt, ganti dulu
sed -i 's/requests==2.32.5/requests==2.32.4/' requirements.txt

pip install -r requirements.txt

nano .env

# Jalankan main.py
echo "▶️ Menjalankan main.py ..."
python3.11 main.py
