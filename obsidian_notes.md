# Kodi Docker Repository

## Overview
This repository provides a Dockerized version of Kodi, allowing for easy deployment and management of the media center application.

### Repository Link
- [bpawnzZ/kodi-docker](https://github.com/bpawnzZ/kodi-docker)

## Key Files
- **Dockerfile**: Instructions for building the Kodi Docker image.
- **Dockerfile.nvidia**: Specialized Dockerfile for NVIDIA support.
- **docker-compose.yml**: Defines services and volumes for deployment.
- **entrypoint.sh**: Entry point script for starting Kodi.
- **pulseaudio.client.conf**: Configuration for PulseAudio client.

## Deployment Steps
1. Clone the repository.
2. Build the Docker image.
3. Set the KODI_DATA environment variable.
4. Run the container using Docker Compose.

## Configuration
- Set up PulseAudio socket for audio support.

## Conclusion
This repository simplifies the process of running Kodi in a Docker container, providing flexibility and ease of use.
