
echo "Building 'build' docker container..."
docker build docker/build/. -t buildeq

echo "Building binaries..."
docker run -v %cd%:/src -v %cd%/deploy/server:/eqemu buildeq

echo "Building Images..."
docker-compose build

echo "Build completed. Run docker-compose run mariadb to inject DB data, or run the start.sh script to begin the environment."