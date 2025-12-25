 Thanks to a [reddit post](https://www.reddit.com/r/kde/comments/1jgtx66/best_touchpad_gesture_customizer_for_kde_plasma), found this amazing tool for configuring gestures on KDE (Wayland) when moving over from touche on gnome

# [InputActions](https://github.com/taj-ny/InputActions)
InputActions is a powerful gesture engine for KDE that lets you bind touchpad gestures to
keyboard shortcuts, media keys, and native Plasma window actions.

Unlike most gesture tools based on **libinput**, InputActions can read:

- per-finger position  
- pressure values  
- click state

I personally found this way better than touche due to:
- Extensively documented (rare sight in development these days)
- Extremely easy to configure

## Installation

- ### Install dependencies
https://github.com/DeRealMystic/kde-wayland-configs/blob/1b9639c4cd5ae20acd9dae400a0369e683614267/debian/touchpad/gestures/install_inputactions.sh#L10-L14

- ### Build & install 
https://github.com/DeRealMystic/kde-wayland-configs/blob/1b9639c4cd5ae20acd9dae400a0369e683614267/debian/touchpad/gestures/install_inputactions.sh#L16-L29

- ### Enable libevdev backend (optional)

> [!TIP]
> Use the libevdev backend. It exposes more touchpad data than libinput and is required for reliable 3/4 finger taps and pressure-based gestures.

https://github.com/DeRealMystic/kde-wayland-configs/blob/1b9639c4cd5ae20acd9dae400a0369e683614267/debian/touchpad/gestures/additional_setup_libevdev.sh#L9-L23

- ### Enable plugin
https://github.com/DeRealMystic/kde-wayland-configs/blob/1b9639c4cd5ae20acd9dae400a0369e683614267/debian/touchpad/gestures/enable_kwin_gestures.sh#L10-L12

# Configuration

- `~/.config/inputactions/config-debug.yaml` (debug builds only)
- `/etc/inputactions/config.yaml` (System-wide configuration file)
- `~/.config/inputactions/config.yaml` (User-specific configuration file)

```bash
# System-wide configuration file
sudo mkdir -p /etc/inputactions
```

> [!CAUTION]
> Remember to backup the original file if this isn't your first time configuring

- Write your own configuration file
```bash
sudo nano /etc/inputactions/config.yaml
```

or 
- Move my configuration file
```bash
sudo cp ./config.yaml /etc/inputactions/config.yaml
```

## Useful links for configuration
- [Triggers](https://wiki.inputactions.org/main/trigger.html#trigger)
- [Keyboard Scan Codes](https://wiki.inputactions.org/main/misc/keyboard-scancodes.html)
