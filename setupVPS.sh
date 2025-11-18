#!/bin/bash

set -e

# Detect Ubuntu version
UBUNTU_VER=$(lsb_release -rs)
echo "🧠 Detected Ubuntu version: $UBUNTU_VER"

echo "🔁 Updating system..."
apt update -y && apt upgrade -y

echo "📦 Installing required tools..."
apt install -y git software-properties-common python3-pil python3-pil.imagetk

# Clone me-cli repo
if [ ! -d "me-cli" ]; then
  echo "📥 Cloning me-cli repository..."
  git clone https://github.com/purplemashu/me-cli
fi
cd me-cli

# Setup Python based on Ubuntu version
if [[ "$UBUNTU_VER" == "20.04" ]]; then
  echo "🐍 Installing Python 3.11 for Ubuntu 20.04..."
  add-apt-repository ppa:deadsnakes/ppa -y
  apt update -y
  apt install -y python3.11 python3.11-venv python3.11-dev
elif [[ "$UBUNTU_VER" == "24.04" ]]; then
  echo "🐍 Installing Python 3.11 for Ubuntu 24.04..."
  apt install -y python3.11 python3.11-venv python3-pip python3-dev
else
  echo "⚠️ This script only supports Ubuntu 20.04 and 24.04!"
  exit 1
fi

# Create virtual environment
echo "🔧 Creating virtual environment..."
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install dependencies
echo "📦 Installing Python requirements..."
pip install --upgrade pip
pip install -r requirements.txt

# Run the main program
echo "🚀 Running me-cli..."
python main.py
