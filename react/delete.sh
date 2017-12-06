#!/bin/bash
set -e
echo "Shutting down docker-compose instance..."
docker-compose down
echo "Removing any docker-compose instances"
docker-compose rm react
#echo "Removing any dangling/exited docker instances"
#docker rm $(docker ps -q -f 'status=exited')
#docker rmi $(docker images -q -f "dangling=true")
#docker volume rm $(docker volume ls -qf dangling=true)
echo "Complete!"