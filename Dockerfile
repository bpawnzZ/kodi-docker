FROM ubuntu:focal

ARG KODI_VERSION=19
ARG DEBIAN_FRONTEND=noninteractive

# Install required packages and add PPA
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg \
    && add-apt-repository ppa:team-xbmc/ppa \
    && apt-get update \
    && apt-get -y purge software-properties-common \
    && apt-get -y --purge autoremove \
    && rm -rf /var/lib/apt/lists/*

ARG KODI_EXTRA_PACKAGES=

# Install Kodi and additional packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    kodi \
    kodi-eventclients-kodi-send \
    kodi-game-libretro \
    kodi-inputstream-adaptive \
    kodi-inputstream-rtmp \
    kodi-peripheral-joystick \
    kodi-peripheral-xarcade \
    locales \
    pulseaudio \
    tzdata \
    va-driver-all \
    ${KODI_EXTRA_PACKAGES} \
    && apt-get -y --purge autoremove \
    && rm -rf /var/lib/apt/lists/*

# Setup entry point
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
