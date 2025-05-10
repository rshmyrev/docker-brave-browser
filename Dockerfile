FROM debian:testing-slim
LABEL maintainer="rshmyrev <rshmyrev@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

# Install required deps and Brave-browser
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      dbus-x11 \
      fonts-lato \
      fonts-quicksand \
      fonts-symbola \
      libegl1 \
      libgl1 \
      libpulse0 \
      xdg-utils \
 && update-ca-certificates \
 && curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
      https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | tee /etc/apt/sources.list.d/brave-browser-release.list \
 && apt-get update && apt-get install -y --no-install-recommends brave-browser \
 && apt-get purge -y curl \
 && apt-get autopurge -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Create a user
RUN useradd user

VOLUME ["/home/user"]
USER user
WORKDIR /home/user
ENTRYPOINT ["/usr/bin/brave-browser", "--no-sandbox", "--disable-dev-shm-usage"]
