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
    software-properties-common ca-certificates gnupg lsb-release \
    python3 python3-pip python3.8-venv python3.8-dev python3-pillow

# Clone repository
cd ~
if [ ! -d "me-cli" ]; then
    git clone https://github.com/purplemashu/me-cli
else
    cd me-cli && git pull --rebase
fi
cd me-cli

# Cek Python 3.11, compile manual kalau tidak ada
if ! command -v python3.11 >/dev/null 2>&1; then
    echo "⚠️ Python 3.11 tidak ditemukan, compile manual..."
    apt install -y build-essential libssl-dev zlib1g-dev \
        libncurses5-dev libnss3-dev libreadline-dev libffi-dev libsqlite3-dev wget
    cd /usr/src
    wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
    tar -xzf Python-3.11.9.tgz
    cd Python-3.11.9
    ./configure --enable-optimizations
    make -j$(nproc)
    make altinstall
    cd ~/me-cli
fi

# Buat virtual environment dengan Python 3.11 fallback ke 3.8
if command -v python3.11 >/dev/null 2>&1; then
    python3.11 -m venv venv
else
    python3 -m venv venv
fi

source venv/bin/activate

# Pakai pip resmi PyPI supaya requests==2.32.5 bisa didapat
pip config set global.index-url https://pypi.org/simple
pip install --upgrade pip setuptools wheel

# Install dependencies
pip install -r requirements.txt || echo "⚠️ Beberapa package gagal, install manual bila perlu"

# Jalankan program
python3 main.py
