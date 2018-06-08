#!/bin/sh -eu

DOCKER_IMAGE="$(buildkite-agent meta-data get docker-image)"
SOURCE_TAG="$(buildkite-agent meta-data get source-tag)"
TARGET_TAG="$(buildkite-agent meta-data get target-tag)"


# Pull image to be tagged
docker pull "${DOCKER_IMAGE}:${SOURCE_TAG}"

# Tag image
docker tag "${DOCKER_IMAGE}:${SOURCE_TAG}" "${DOCKER_IMAGE}:${TARGE_TAG}"

# Push new tag
docker push "${DOCKER_IMAGE:${TARGET_TAG}"
