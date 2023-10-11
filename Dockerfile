FROM debian:bookworm-slim
LABEL maintainer="rshmyrev <rshmyrev@gmail.com>"

# Install required deps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      libegl1 \
      libgl1 \
      libpulse0 \
 && rm -rf /var/lib/apt/lists/*

# Install Brave-browser
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
 && update-ca-certificates \
 && curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
      https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | tee /etc/apt/sources.list.d/brave-browser-release.list \
 && apt-get update && apt-get install -y --no-install-recommends \
      brave-browser \
 && apt-get purge -y \
      curl \
 && apt-get autopurge -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/*

# Create a user
RUN adduser user

VOLUME ["/home/user"]
USER user
WORKDIR /home/user
ENTRYPOINT ["/usr/bin/brave-browser", "--no-sandbox", "--disable-dev-shm-usage"]
