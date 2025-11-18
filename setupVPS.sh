#!/bin/bash
set -e

echo "🔍 Mengecek versi Ubuntu..."
UBU_VERSION=$(lsb_release -rs)

echo "➡️ Ubuntu versi: $UBU_VERSION"

apt update -y && apt upgrade -y

# Install essential packages
apt install -y git software-properties-common

# Clone jika belum ada
if [ ! -d "me-cli" ]; then
  git clone https://github.com/purplemashu/me-cli
fi

cd me-cli

# -------------------------------
#   BAGIAN UBUNTU 20.04
# -------------------------------
if [[ "$UBU_VERSION" == "20.04" ]]; then
  echo "🟦 Detected Ubuntu 20.04 → install Python 3.11 via PPA..."

  add-apt-repository ppa:deadsnakes/ppa -y
  apt update -y

  apt install -y python3.11 python3.11-venv python3.11-dev python3-pil python3-pil.imagetk

# -------------------------------
#   BAGIAN UBUNTU 24.04 / 22.04
# -------------------------------
else
  echo "🟩 Detected Ubuntu 22.04 atau 24.04 → Python 3.11 sudah tersedia!"

  apt install -y python3.11 python3.11-venv python3.11-dev python3-pil python3-pil.imagetk
fi

# Cek versi Python
python3.11 --version

# Setup Virtual Environment
echo "📦 Membuat virtual environment..."
python3.11 -m venv venv

echo "🚀 Mengaktifkan virtual environment..."
source venv/bin/activate

echo "⬆️ Upgrade pip..."
pip install --upgrade pip

echo "📥 Install requirements..."
pip install -r requirements.txt

echo "▶️ Menjalankan main.py ..."
python main.py
