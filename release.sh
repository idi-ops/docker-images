#!/bin/sh -eux

DOCKER_IMAGE="$(buildkite-agent meta-data get docker-image)"
SOURCE_TAG="$(buildkite-agent meta-data get source-tag)"
TARGET_TAG="$(buildkite-agent meta-data get target-tag)"


# Pull image to be tagged
docker pull "${DOCKER_IMAGE}:${SOURCE_TAG}"

# Tag image
docker tag "${DOCKER_IMAGE}:${SOURCE_TAG}" "${DOCKER_IMAGE}:${TARGET_TAG}"

# Push new tag
docker push "${DOCKER_IMAGE}:${TARGET_TAG}"

# Cleanup
docker image rm -f "${DOCKER_IMAGE}:${SOURCE_TAG}"
docker image rm -f "${DOCKER_IMAGE}:${TARGET_TAG}"
