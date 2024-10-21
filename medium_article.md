# Deploying Kodi in a Docker Container: A Comprehensive Guide

## Introduction:
In this article, we will explore how to deploy Kodi, a powerful media center application, in a Docker container. This approach offers flexibility and portability, allowing you to run Kodi on various systems without the hassle of traditional installation methods.

## Repository Overview:
The repository [bpawnzZ/kodi-docker](https://github.com/bpawnzZ/kodi-docker) contains everything you need to get started with Kodi in Docker. It includes Dockerfiles for both standard and NVIDIA-enabled builds, a Docker Compose file for easy deployment, and an entrypoint script to manage the Kodi application.

## Key Features:
- **Dockerfile**: Build a Kodi Docker image with customizable versions.
- **Dockerfile.nvidia**: Specialized Dockerfile for NVIDIA support, enabling hardware acceleration.
- **docker-compose.yml**: Simplifies deployment with defined services, networks, and volumes.
- **entrypoint.sh**: Manages the startup and shutdown of the Kodi application.
- **pulseaudio.client.conf**: Configuration for optimal audio performance.

## Deployment Instructions:
1. Clone the repository:
   ```bash
   git clone https://github.com/bpawnzZ/kodi-docker.git
   cd kodi-docker
   ```

2. Build the Docker image:
   ```bash
   docker buildx build -t bpawnzZ/kodi:tag .
   ```

3. For NVIDIA support, use the NVIDIA Dockerfile:
   ```bash
   docker buildx build -f Dockerfile.nvidia -t bpawnzZ/kodi-nvidia:tag .
   ```

4. Set the KODI_DATA environment variable:
   ```bash
   export KODI_DATA=/path/to/your/kodi/data
   ```

5. Run the container using Docker Compose:
   ```bash
   docker-compose up -d
   ```

## Configuration:
To enable audio support, create a PulseAudio socket:
```bash
pactl load-module module-native-protocol-unix socket=/path/to/your/pulseaudio.socket
```

## Conclusion:
With this setup, you can enjoy Kodi's powerful features in a Docker container, making it easier to manage and deploy. For more information, check out the [repository](https://github.com/bpawnzZ/kodi-docker).
