#!/bin/bash
echo "Shutting down docker-compose... (in case it was running)"
docker-compose down

echo "Building 'build' docker container..."
docker build docker/build/. -t buildeq

echo "Prepping Cmake..."
docker run -v ./:/src -v ./deploy/server:/eqemu buildeq /bin/bash -c "/usr/bin/cmake ~/."

echo "Building binaries..."
docker run -v ./:/src -v ./deploy/server:/eqemu buildeq

echo "Copying binaries..."
cp -R bin/* deploy/server/

echo "Building docker-compose..."
docker-compose build

if [ ! -f /deploy/server/eqemu_config.xml ]; then
   echo "Copying eqemu_config.xml..."
   cp docker/eqemu/eqemu_config.xml deploy/server/
fi


if [ ! -d /deploy/server/shared ]; then
   echo "Making shared directory..."
   mkdir deploy/server/shared
fi

echo "Running shared memory..."
docker-compose run eqemu /eqemu/shared_memory

echo "Build completed. Run start.bat start the environment, inject DB via localhost. When modifications are done, run rebuild.sh from now on. DO NOT re-run build.sh unless it's a big issue."