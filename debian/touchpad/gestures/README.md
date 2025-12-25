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

(dependencies here)[]

- ### Build & install 
(installation here)[]

- ### Enable libevdev backend (optional)

> [!TIP]
> Use the libevdev backend. It exposes more touchpad data than libinput and is required for reliable 3/4 finger taps and pressure-based gestures.

(udev rules here)[]

- ### Enable plugin
[plugin here)[]

# Configuration

## Configuration paths
- `~/.config/inputactions/config-debug.yaml` (debug builds only)
- `/etc/inputactions/config.yaml`
- `~/.config/inputactions/config.yaml` (created if does not exist)

```bash
sudo mkdir /etc/inputactions && sudo nano /etc/inputactions/config.yaml
```

- My configuration file
```yaml
touchpad:
  gestures:
    # go back / global
    - type: swipe
      fingers: 2
      direction: left

      actions:
        - on: begin
          input:
            - keyboard: [ leftalt+left ]

    # go forward / global
    - type: swipe
      fingers: 2
      direction: right

      actions:
        - on: begin
          input:
            - keyboard: [ leftalt+right ]

    # volume up&down / global
    - type: swipe
      fingers: 3
      direction: up_down

      actions:
        - on: update
          interval: -20
          input:
            - keyboard: [ leftshift+volumeup ]

        - on: update
          interval: 20
          input:
            - keyboard: [ leftshift+volumedown ]

    # previous track / global
    - type: swipe
      fingers: 3
      direction: left

      actions:
        - on: begin
          input:
            - keyboard: [ previoussong ]

    # next track / global
    - type: swipe
      fingers: 3
      direction: right

      actions:
        - on: begin
          input:
            - keyboard: [ nextsong ]

    # play/pause current media / global
    - type: tap
      fingers: 4

      actions:
        - on: begin
          input:
            - keyboard: [ playpause ]

    # mute / global
    - type: swipe
      fingers: 4
      direction: down

      actions:
        - on: begin
          input:
            - keyboard: [ mute ]

    # maximize window / global
    - type: swipe
      fingers: 4
      direction: up

      actions:
        - on: begin
          plasma_shortcut: kwin,Window Maximize

    # minimize window / global
    - type: pinch
      fingers: 3
      direction: in

      actions:
        - on: begin
          plasma_shortcut: kwin,Window Minimize

    # close window / global
    - type: pinch
      fingers: 4
      direction: in

      actions:
        - on: begin
          plasma_shortcut: kwin,Window Close
```
