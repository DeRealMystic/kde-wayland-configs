#!/usr/bin/env bash
set -e
trap 'echo "Script failed at line $LINENO"; exit 1' ERR

LOGFILE="/var/log/inputactions.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(tee -a "$LOGFILE") 2>&1

echo ">>> Installing dependencies..."
sudo apt update
sudo apt install -y libevdev-dev

RULE_FILE="/etc/udev/rules.d/71-touchpad.rules"

echo ">>> Writing $RULE_FILE"
sudo tee "$RULE_FILE" >/dev/null <<'EOF'
# /etc/udev/rules.d/71-touchpad.rules
ENV{ID_INPUT_TOUCHPAD}=="1", TAG+="uaccess"
EOF

echo ">>> Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "udev rule installed"
echo "(Optional) Reboot for changes to take effect (just in case :P)"
