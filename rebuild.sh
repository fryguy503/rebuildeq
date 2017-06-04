#!/bin/bash
set -e

echo "Building binaries..."
docker run -v ./:/src -v ./deploy/server:/eqemu buildeq

echo "Copying binaries..."
cp -R bin/* deploy/server/