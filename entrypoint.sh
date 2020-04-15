#!/bin/bash

set -euo pipefail

# Follows fedora entrypoint/cmd behavior (no defaults in Dockerfile)
if [[ -z "$*" ]]; then
  echo "No command specified"
  exit 1
fi

# All parameters are mandatory
if [[ -n "${USER-}" && -n "${USER_ID-}" && -n "${USER_GID-}" ]]; then

  groupadd --gid "${USER_GID}" "${USER}" && \
  useradd --uid "${USER_ID}" --gid "${USER_GID}" --create-home --shell /bin/bash "${USER}"

  # Use chroot to avoid issues with TTY in su/sudo. Also set $HOME or npm will try to use ~root/.npm
  HOME=/home/${USER} chroot --userspec="${USER}:${USER}" --skip-chdir / "$@"

else

  exec xvfb-run "$@"

fi
