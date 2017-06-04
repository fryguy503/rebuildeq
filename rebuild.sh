#!/bin/bash

# Rebuilds binaries to copy them over. It is recommended ending the processes before this runs, 
# e.g. turn off zone/world binaries.
# RUN THIS after the first and only run of build.sh
set -e

echo "Building binaries..."
docker run -v ./:/src -v ./deploy/server:/eqemu buildeq

echo "Copying binaries..."
cp -R bin/* deploy/server/