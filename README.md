# Brave Browser Docker Image

## Table of Contents

- [Description](#description)
- [Configuration](#configuration)
    - [Environment Variables](#environment-variables)
    - [Volumes](#volumes)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Running the Container](#running-the-container)
    - [Docker Run](#docker-run)
    - [Docker Compose](#docker-compose)
- [License](#license)

## Description

This project provides a Dockerized version of the [Brave browser](https://brave.com/), allowing you to run Brave in an isolated container environment.

## Configuration

### Environment Variables

- `DISPLAY`: X11 display server connection string.
- `PULSE_SERVER`: Path to PulseAudio server.

### Volumes

- `/tmp/.X11-unix:/tmp/.X11-unix:ro`: X11 socket.
- `$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse:ro`: PulseAudio.
- `brave-browser_home:/home/user`: Home directory.
- `$HOME/Downloads:/home/user/Downloads`: Downloads directory.

## Getting Started

### Prerequisites

- Docker installed on your machine.
- Docker Compose for orchestrating containers (optional).

### Installation

Clone the repository and build the Docker image:

```bash
git clone https://github.com/rshmyrev/docker-brave-browser.git
cd docker-brave-browser
docker build -t rshmyrev/brave-browser .
```

## Running the Container

### Docker Run

Run the Brave browser using Docker:

```bash
docker run -d \
  --name brave-browser \
  -e DISPLAY=${DISPLAY} \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
  --device /dev/dri:/dev/dri \
  --cap-drop=ALL \
  --security-opt no-new-privileges=true \
  --shm-size=1g \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse:ro \
  -v brave-browser_home:/home/user \
  -v ${HOME}/Downloads:/home/user/Downloads \
  rshmyrev/brave-browser
```

### Docker Compose

Start the container using Docker Compose:

```bash
docker compose up -d
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
