# Renice Gamemode (WIP)

Renice Gamemode is a wrapper for [Feral Gamemode](https://github.com/FeralInteractive/gamemode) that monitors all processors used by a game and dynamically renices them to `-20`.

This ensures the game processes get the highest CPU scheduling priority for better performance.

## Usage (with Steam)

Set your game's launch options in Steam to:

```
renice-gamemode %command%
```

## Installation

1. Make the script executable:

```bash
chmod +x renice-gamemode
```

2. Create a symlink to a directory in your `$PATH` (e.g. `/usr/local/bin` or `~/.local/bin`):

```bash
ln -s /path/to/renice-gamemode ~/.local/bin/renice-gamemode
```

Make sure `~/.local/bin` is in your `$PATH`.

## Systemd Service

To run `renice-gamemode-service.sh` on boot via systemd:

1. Create a service unit file `/etc/systemd/system/renice-gamemode.service` with:

```ini
[Unit]
Description=Renice Gamemode Service
After=network.target

[Service]
Type=simple
ExecStart=/path/to/renice-gamemode-service.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

2. Reload systemd and enable the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now renice-gamemode.service
```

This will start the service at boot and keep it running.
