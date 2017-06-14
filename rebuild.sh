#!/bin/bash

# Rebuilds binaries to copy them over. It is recommended ending the processes before this runs, 
# e.g. turn off zone/world binaries.
# RUN THIS after the first and only run of build.sh
set -e

if [ ! -f deploy/server/eqemu_config.xml ]; then
   echo "Copying eqemu_config.xml..."
   cp docker/eqemu/eqemu_config.xml deploy/server/
fi

if [ ! -f deploy/web/application/config/database.php ]; then
   echo "Copying database.php..."
   cp docker/web/database.php deploy/web/application/config/
fi

if [ ! -d deploy/server/shared ]; then
   echo "Making shared directory..."
   mkdir deploy/server/shared
fi

if [ ! -d deploy/web/application/cache ]; then
   echo "Making web cache directory..."
   mkdir deploy/web/application/cache
fi

if [ ! -d deploy/web/application/logs ]; then
   echo "Making web logs directory..."
   mkdir deploy/web/application/logs
fi

echo "Building binaries..."
docker run -v $PWD:/src -v $PWD/deploy/server:/eqemu buildeq

echo "Copying binaries..."
cp -R bin/* deploy/server/
