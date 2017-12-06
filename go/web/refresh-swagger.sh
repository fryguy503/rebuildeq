# build swagger files
echo "Buidling swagger files.."
rm -rf swagger/*
cd ../../swagger/swagger-codegen/
rm -rf out/sdk/go/go/*
cp ../rebuildeq.yml .
./run-in-docker.sh generate -i rebuildeq.yml -l go-server -o /gen/out/sdk/go/ -Dpackagename=rebuildeq
cp -r out/sdk/go/go/* ../../go/web/swagger
cd ../../go/web/swagger
find . -type f -name '*.go' -exec sed -i '' s/package/'package swagger'/ {} +
