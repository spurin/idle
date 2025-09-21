#!/usr/bin/env bash

docker buildx create --name build_cross --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000 || true
docker buildx use build_cross

docker buildx build \
  --platform linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 -t spurin/idle:latest . --push
