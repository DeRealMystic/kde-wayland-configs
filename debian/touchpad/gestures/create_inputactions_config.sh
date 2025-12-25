#!/usr/bin/env bash
set -e
trap 'echo "Script failed at line $LINENO"; exit 1' ERR

LOGFILE="/var/log/inputactions.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(tee -a "$LOGFILE") 2>&1

CONFIG_SRC="./config.yaml"

if [[ ! -f "$CONFIG_SRC" ]]; then
  echo "❌ $CONFIG_SRC not found in current directory."
  exit 1
fi

usage() {
  echo "Usage:"
  echo "  $0 system          Install to /etc/inputactions/"
  echo "  $0 user            Install to ~/.config/inputactions/"
  echo "  $0 /path/file.yaml Install to a custom path"
  exit 1
}

# No parameter?
[[ -z "$1" ]] && usage

case "$1" in
  system)
    CONFIG_DIR="/etc/inputactions"
    CONFIG_DST="$CONFIG_DIR/config.yaml"
    echo ">>> Installing system-wide: $CONFIG_DST"
    sudo mkdir -p "$CONFIG_DIR"
    if [[ -f "$CONFIG_DST" ]]; then
      echo ">>> Backing up existing config..."
      sudo cp "$CONFIG_DST" "$CONFIG_DST.bak.$(date +%s)"
    fi
    sudo cp "$CONFIG_SRC" "$CONFIG_DST"
    sudo chmod 644 "$CONFIG_DST"
    ;;

  user)
    CONFIG_DIR="$HOME/.config/inputactions"
    CONFIG_DST="$CONFIG_DIR/config.yaml"
    echo ">>> Installing for current user: $CONFIG_DST"
    mkdir -p "$CONFIG_DIR"
    if [[ -f "$CONFIG_DST" ]]; then
      echo ">>> Backing up existing config..."
      cp "$CONFIG_DST" "$CONFIG_DST.bak.$(date +%s)"
    fi
    cp "$CONFIG_SRC" "$CONFIG_DST"
    chmod 644 "$CONFIG_DST"
    ;;

  /*)
    CONFIG_DST="$1"
    CONFIG_DIR="$(dirname "$CONFIG_DST")"
    echo ">>> Installing to custom path: $CONFIG_DST"
    mkdir -p "$CONFIG_DIR"
    if [[ -f "$CONFIG_DST" ]]; then
      echo ">>> Backing up existing config..."
      cp "$CONFIG_DST" "$CONFIG_DST.bak.$(date +%s)"
    fi
    cp "$CONFIG_SRC" "$CONFIG_DST"
    chmod 644 "$CONFIG_DST"
    ;;

  *)
    usage
    ;;
esac

inputactions config reload
echo "Config installed at: $CONFIG_DST"
