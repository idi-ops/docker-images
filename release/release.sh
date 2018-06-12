#!/bin/bash

set -euo pipefail

if ! IMAGE_NAME="$(buildkite-agent meta-data get image-name)"; then
  err "Failed to get image name from BuildKite meta-data"
fi

if ! SOURCE_TAG="$(buildkite-agent meta-data get source-tag)"; then
  err "Failed to get source tag from BuildKite meta-data"
fi

if ! TARGET_TAG="$(buildkite-agent meta-data get target-tag)"; then
  err "Failed to get target tag from BuildKite meta-data"
fi

# Pull image to be tagged
docker pull "${IMAGE_NAME}:${SOURCE_TAG}"

# Tag image
docker tag "${IMAGE_NAME}:${SOURCE_TAG}" "${IMAGE_NAME}:${TARGET_TAG}"

# Push new tag
docker push "${IMAGE_NAME}:${TARGET_TAG}"

# Cleanup
docker image rm -f "${IMAGE_NAME}:${SOURCE_TAG}"
docker image rm -f "${IMAGE_NAME}:${TARGET_TAG}"
