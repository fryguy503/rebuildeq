#!/bin/bash
set -e

# build swagger files
echo "Buidling server swagger files.."
rm -rf server/*
cd ../../swagger/swagger-codegen/
rm -rf out/sdk/go/go/*
cp ../rebuildeq.yml .
./run-in-docker.sh generate -i rebuildeq.yml -l go-server -o /gen/out/sdk/go/ -Dpackagename=server
cp -r out/sdk/go/go/* ../../go/swagger/server
cd ../../go/swagger/server
find . -type f -name '*.go' -exec sed -i '' s/package/'package server'/ {} +
cd ..

echo "Buidling client swagger files.."
rm -rf client/*
cd ../../swagger/swagger-codegen/
rm -rf out/sdk/go/*
cp ../rebuildeq.yml .
./run-in-docker.sh generate -i rebuildeq.yml -l go -o /gen/out/sdk/go/ -Dpackagename=client
cp -r out/sdk/go/* ../../go/swagger/client
cd ../../go/swagger/client
find . -type f -name '*.go' -exec sed -i '' s/'package swagger'/'package client'/ {} +
cd ..


echo "Completed."
#find . -type f -name '*.go' -exec sed -i '' s/package/'package swagger'/ {} +
