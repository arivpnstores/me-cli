# DOR XL
CLI client for a certain Indonesian mobile internet service provider.

# How to get API Key
Chat telegram bot [@fykxt_bot](https://t.me/fykxt_bot) with message `/viewkey`. Copy the API key.

# Install On TERMUX
```
pkg update -y && pkg upgrade -y && pkg install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setup.sh && chmod +x setup.sh && ./setup.sh
```
# Restart On TERMUX 
```
cd me-cli && python main.py
```
# Install On VPS & LINUX
```
apt update -y && apt upgrade -y && apt install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setupVPS.sh && chmod +x setup.sh && ./setup.sh
```
# Restart On VPS & LINUX 
```
cd me-cli && source venv/bin/activate && python main.py
```
7. Input your API key when prompted

# UPDATE
```
git pull --rebase
```
