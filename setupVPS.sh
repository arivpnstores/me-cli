#!/bin/bash
set -e

echo "🔍 Mengecek versi Ubuntu..."
UBU_VERSION=$(lsb_release -rs)
echo "➡️ Ubuntu versi: $UBU_VERSION"

# Update
apt update -y

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

wget -O decoy_data/decoy-default-balance.json https://raw.githubusercontent.com/arivpnstores/me-cli/main/decoy-default-balance.json

cat > .env << 'EOF'
BASE_API_URL="https://api.myxl.xlaxiata.co.id"
BASE_CIAM_URL="https://gede.ciam.xlaxiata.co.id"
BASIC_AUTH="OWZjOTdlZDEtNmEzMC00OGQ1LTk1MTYtNjBjNTNjZTNhMTM1OllEV21GNExKajlYSUt3UW56eTJlMmxiMHRKUWIyOW8z"
AX_FP_KEY="18b4d589826af50241177961590e6693"
UA="myXL / 8.9.0(1202); com.android.vending; (samsung; SM-N935F; SDK 33; Android 13)"
API_KEY="vT8tINqHaOxXbGE7eOWAhA=="
ENCRYPTED_FIELD_KEY="5dccbf08920a5527"

XDATA_KEY="5dccbf08920a5527b99e222789c34bb7"
AX_API_SIG_KEY="18b4d589826af50241177961590e6693"
X_API_BASE_SECRET="mU1Y4n1vBjf3M7tMnRkFU08mVyUJHed8B5En3EAniu1mXLixeuASmBmKnkyzVziOye7rG5nIekMdthensbQMcOJ6SLnrkGyfXALD7mrBC6vuWv6G01pmD3XlU5rT7Tzx"
CIRCLE_MSISDN_KEY="5dccbf08920a5527"
EOF


#pip install -r requirements.txt
bash setup.sh 
# Jalankan main.py
echo "▶️ Menjalankan main.py ..."
python3.11 main.py
