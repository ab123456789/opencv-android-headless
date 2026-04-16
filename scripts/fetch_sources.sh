#!/usr/bin/env bash
set -euo pipefail

: "${OPENCV_REF:=4.10.0}"
: "${WORKDIR:=$(pwd)}"

cd "$WORKDIR"

if [ ! -d opencv ]; then
  git clone --depth 1 --branch "$OPENCV_REF" https://github.com/opencv/opencv.git
fi

if [ ! -d opencv_contrib ]; then
  git clone --depth 1 --branch "$OPENCV_REF" https://github.com/opencv/opencv_contrib.git
fi

echo "OpenCV source prepared at: $WORKDIR"
