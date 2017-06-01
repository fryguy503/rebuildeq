@echo off
echo Building 'build' docker container...
docker build docker/build/. -t buildeq

echo Prepping Cmake...
docker run -v %cd%:/src -v %cd%\deploy\server:/eqemu buildeq /bin/bash -c "/usr/bin/cmake ~/."

echo Building binaries...
docker run -v %cd%:/src -v %cd%\deploy\server:/eqemu buildeq

echo Copying binaries...
copy bin\* deploy\server\

echo Building docker-compose...
docker-compose build

if not exist "deploy\server\eqemu_config.xml" echo Copying eqemu_config.xml... && copy "docker\eqemu\eqemu_config.xml" "deploy\server"
if not exist "deploy\server\shared" echo Making shared directory... && mkdir deploy\server\shared

echo Running shared memory...
docker-compose run eqemu /eqemu/shared_memory

echo Build completed. Run docker-compose up to inject DB data, or run the start.sh script to begin the environment.