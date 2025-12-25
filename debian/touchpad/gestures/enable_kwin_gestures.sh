#!/usr/bin/env bash
set -e
trap 'echo "Script failed at line $LINENO"; exit 1' ERR

LOGFILE="/var/log/inputactions.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(tee -a "$LOGFILE") 2>&1

echo ">>> Enabling kwin_gestures plugin..."
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect kwin_gestures || true

echo "Plugin loaded (log out/in if it doesn’t start)"
