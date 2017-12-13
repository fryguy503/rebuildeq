#this script generates coverage across all packages. 
#It could have been automated to recursively browse directories,
#but I was lazy and just wanted intel.

#!/bin/bash
set -e

go test -coverprofile=pkg1.cover.out -coverpkg=./... .
go test -coverprofile=pkg2.cover.out -coverpkg=./... ./storage
go test -coverprofile=pkg21.cover.out -coverpkg=./... ./storage/mariadb
go test -coverprofile=pkg11.cover.out -coverpkg=./... ./rest
go test -coverprofile=pkg12.cover.out -coverpkg=./... ./nats

echo "mode: set" > coverage.out && cat *.cover.out | grep -v mode: | sort -r | \
awk '{if($1 != last) {print $0;last=$1}}' >> coverage.out

go tool cover -html=coverage.out
go tool cover -func=coverage.out > cover.txt
rm *.out