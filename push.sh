#!/usr/bin/bash

BAZZITE_TAG=40-20240427
REVISION_ID=7
DC_TAG=dc${BAZZITE_TAG}.${REVISION_ID}
URL=ghcr.io/hhd-dev/bazzite-dc

set -e

sudo podman tag bazzite-dc $URL:$DC_TAG
sudo podman push $URL:$DC_TAG
sudo podman tag bazzite-dc $URL:latest
sudo podman push $URL:latest
sudo podman tag bazzite-dc $URL:stable
sudo podman push $URL:stable