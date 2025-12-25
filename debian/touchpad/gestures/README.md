For configuring touchpad gestures, there is this amazing tool: InputActions

Extensively documented (rare sight in development these days) and easy to configure

# Installation

- Dependencies

```bash
sudo apt install git cmake g++ extra-cmake-modules qt6-tools-dev kwin-wayland kwin-dev libkf6configwidgets-dev gettext libkf6kcmutils-dev libyaml-cpp-dev libxkbcommon-dev pkg-config libevdev-dev libdrm-dev libcli11-dev
```

```bash
git clone https://github.com/taj-ny/InputActions
cd InputActions
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DINPUTACTIONS_BUILD_KWIN=ON -DINPUTACTIONS_BUILD_CTL=ON
make -j$(nproc)
sudo make install
```
