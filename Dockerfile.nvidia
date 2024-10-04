# Dockerfile to create NVIDIA driver base image with Kodi
FROM debian:stable

# Install NVIDIA driver
RUN apt-get update && \
    apt-get install --no-install-recommends -y kmod xz-utils wget ca-certificates binutils || exit 1 ; \
    Nvidiaversion="$(head -n1 </proc/driver/nvidia/version | awk '{ print $8 }')" ; \
    Driverurl="https://http.download.nvidia.com/XFree86/Linux-x86_64/$Nvidiaversion/NVIDIA-Linux-x86_64-$Nvidiaversion.run" ; \
    wget $Driverurl -O /tmp/NVIDIA-installer.run || exit 1 ; \
    Nvidiaoptions='--accept-license --no-runlevel-check --no-questions --no-backup --ui=none --no-kernel-module --no-nouveau-check' ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--install-libglvnd'        && Nvidiaoptions="$Nvidiaoptions --install-libglvnd" ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--no-nvidia-modprobe'      && Nvidiaoptions="$Nvidiaoptions --no-nvidia-modprobe" ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--no-kernel-module-source' && Nvidiaoptions="$Nvidiaoptions --no-kernel-module-source" ; \
    sh /tmp/NVIDIA-installer.run $Nvidiaoptions || { echo 'ERROR: Installation of NVIDIA driver failed.' >&2 ; exit 1 ; } ; \
    rm /tmp/NVIDIA-installer.run ; \
    apt-get remove -y kmod xz-utils wget ca-certificates binutils ; \
    apt-get autoremove -y ; apt-get clean -y

# Install Kodi and dependencies
ARG KODI_VERSION=19
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg 

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
