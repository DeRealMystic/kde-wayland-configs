#!/usr/bin/env bash
set -e
trap 'echo "Script failed at line $LINENO"; exit 1' ERR

LOGFILE="/var/log/inputactions.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(tee -a "$LOGFILE") 2>&1

echo ">>> Installing dependencies..."
sudo apt update
sudo apt install -y \
  git cmake g++ extra-cmake-modules qt6-tools-dev kwin-wayland kwin-dev \
  libkf6configwidgets-dev gettext libkf6kcmutils-dev libyaml-cpp-dev \
  libxkbcommon-dev pkg-config libevdev-dev libdrm-dev libcli11-dev

echo ">>> Cloning InputActions..."
git clone https://github.com/taj-ny/InputActions || true
cd InputActions

echo ">>> Building..."
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
         -DINPUTACTIONS_BUILD_KWIN=ON \
         -DINPUTACTIONS_BUILD_CTL=ON

make -j"$(nproc)"

echo ">>> Installing..."
sudo make install

echo "InputActions installed"
