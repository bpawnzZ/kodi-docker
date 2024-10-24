#!/usr/bin/env bash

# bpawnzZ/docker-kodi - Dockerized Kodi with audio and video.
#
# Copyright 2018-2021 - Eric Hough (eric@tubepress.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This script is the entry point for the Kodi container and it has two jobs:
#
# 1. start Kodi by calling kodi-standalone (configurable via environment
#    variable KODI_COMMAND).
#
# 2. cleanly stop Kodi when the container terminates, waiting up to 10
#    seconds (configurable via environment variable KODI_QUIT_TIMEOUT)
#    before itself exiting.

readonly ENV_VAR_KODI_COMMAND="KODI_COMMAND"
readonly ENV_VAR_KODI_QUIT_TIMEOUT="KODI_QUIT_TIMEOUT"

log () {

  echo "---> $1"
}

die () {

  log "$1"
  exit "$2"
}

get_kodi_pid () {

  pidof kodi.bin
}

stop_kodi () {

  if [[ -z $(get_kodi_pid) ]]; then
    die "Kodi does not appear to be running. Exiting." 0
  fi

  local timer=0
  local -r timeout="${!ENV_VAR_KODI_QUIT_TIMEOUT:-10}"
  local remaining

  log "asking Kodi to quit"
  kodi-send --action="Quit"

  while [[ $timer -lt $timeout && -n $(get_kodi_pid) ]]; do
    remaining=$((timeout - timer))
    log "waiting for Kodi to terminate ($remaining seconds until timeout)"
    timer=$((timer+1))
    sleep 1
  done

  if [[ -z $(get_kodi_pid) ]]; then
    die 'Kodi terminated successfully' 0
  fi

  log "WARNING: timeout of $timeout second(s) reached"
}

start_kodi () {

  local -r command="${!ENV_VAR_KODI_COMMAND:-kodi}"
  local -r standalone_arg="${KODI_STANDALONE_ARG:-}--standalone"

  # gracefully stop Kodi whenever this script is terminated for any reason
  trap stop_kodi EXIT

  log "starting $command with argument: $standalone_arg"

  $command $standalone_arg
}

start_kodi

