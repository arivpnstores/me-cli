# MINYAK ENGSEL MOD
CLI client for a certain Indonesian mobile internet service provider.

# How to get API Key
open website https://rentry.co/me-sunset with message. Copy the API key.
```bash
nano .env
```

# TERMUX
```bash
cd && pkg update -y && pkg upgrade -y && pkg install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setup.sh && chmod +x setup.sh && ./setup.sh
```
# RUN TERMUX 
```bash
cd && cd me-cli-sunset && git pull --rebase && python main.py
```
-----------------------------------------------------------------------------------------------------------------------------------------
# VPS
```bash
cd && apt update -y && apt upgrade -y && apt install curl -y && curl -L -o setup.sh https://raw.githubusercontent.com/arivpnstores/me-cli/main/setupVPS.sh && chmod +x setup.sh && ./setup.sh
```
# RUN VPS
```bash
cd && cd me-cli-sunset && source venv/bin/activate && git pull --rebase && python main.py
```

# UPDATE
```bash
git pull --rebase
```
# HAPUS DULU JIKA ERORR
```bash
cd && rm -rf me-cli-sunset
```
