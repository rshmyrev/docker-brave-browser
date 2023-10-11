# Brave-browser Docker

## Configuration

The [Brave-browser](https://brave.com/) Docker container can be configured using environment variables and volumes.

### Environment Variables

- `DISPLAY`: X11 display server connection string (e.g., `unix$DISPLAY`).
- `PULSE_SERVER`: path to PulseAudio server (e.g. `unix:$XDG_RUNTIME_DIR/pulse/native`).

### Volumes

- `/tmp/.X11-unix:/tmp/.X11-unix:ro`: X11 socket for display forwarding.
- `$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse:ro`: PulseAudio.
- `/run/dbus:/run/dbus:ro`: D-Bus.
- `brave-browser_home:/home/user`: home directory.
- `$HOME/Downloads:/downloads`: Downloads directory.

## Usage

### Docker run

```bash
docker run -d \
  --name brave-browser \
  -e DISPLAY=unix${DISPLAY} \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
  --device /dev/dri:/dev/dri \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse:ro \
  -v /run/dbus:/run/dbus:ro \
  -v brave-browser_home:/home/user \
  -v ${HOME}/Downloads:/home/user/Downloads \
  rshmyrev/brave-browser
```

### Docker compose

```bash
docker compose up -d
```
