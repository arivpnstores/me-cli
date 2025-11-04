# MINYAK ENGSEL
CLI client for a certain Indonesian mobile internet service provider.

# How to get API Key
Chat telegram bot [@fykxt_bot](https://t.me/fykxt_bot) with message /viewkey. Copy the API key.

# Install On TERMUX
```bash
cd && pkg update -y && pkg upgrade -y && pkg install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setup.sh && chmod +x setup.sh && ./setup.sh
```
# Restart On TERMUX 
```bash
cd && cd me-cli && git pull --rebase && python main.py
```
# Install On VPS & LINUX
```bash
cd && apt update -y && apt upgrade -y && apt install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setupVPS.sh && chmod +x setup.sh && ./setup.sh
```
# Restart On VPS & LINUX 
```bash
cd && cd me-cli && source venv/bin/activate && git pull --rebase && python main.py
```
7. Input your API key when prompted

# UPDATE
```bash
git pull --rebase
```
# HAPUS DULU JIKA ERORR
```bash
cd && rm -rf me-cli
```
