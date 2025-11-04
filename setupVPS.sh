#!/bin/bash
set -e

# Hapus override exim jika ada
if grep -q Debian-exim /var/lib/dpkg/statoverride; then
    dpkg-statoverride --remove /usr/lib/exim4 2>/dev/null || true
    sed -i '/Debian-exim/d' /var/lib/dpkg/statoverride
    dpkg --configure -a
fi

# Update system
apt update -y && apt upgrade -y

# Pasang dependensi dasar
apt install -y git curl wget build-essential \
    libssl-dev zlib1g-dev libncurses5-dev libnss3-dev \
    libreadline-dev libffi-dev libsqlite3-dev \
    software-properties-common ca-certificates gnupg lsb-release

# Clone repository
cd ~
if [ ! -d "me-cli" ]; then
    git clone https://github.com/purplemashu/me-cli
else
    cd me-cli && git pull --rebase
fi
cd me-cli

# Hapus paket lama pillow
apt remove -y python3-pil python3-pil.imagetk 2>/dev/null || true
apt install -y python3 python3-pip python3-pillow

# Tambahkan repo deadsnakes jika tersedia
if ! grep -q "deadsnakes" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    add-apt-repository ppa:deadsnakes/ppa -y || true
    apt update -y
fi

# Coba install Python 3.11 dari repo
if ! apt install -y python3.11 python3.11-venv python3.11-dev; then
    echo "⚠️ Repo tidak menyediakan Python 3.11 — akan di-compile manual"
    cd /usr/src
    wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
    tar -xzf Python-3.11.9.tgz
    cd Python-3.11.9
    ./configure --enable-optimizations
    make -j$(nproc)
    make altinstall
    cd ~/me-cli
fi

# Buat virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip, wheel, setuptools
pip install --upgrade pip setuptools wheel

# Install dependencies
pip install -r requirements.txt

# Jalankan program
python3 main.py
