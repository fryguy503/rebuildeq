# first run, use the command make initial
default: help
check-not-prod:
#	echo $(ENV)
	#ifdef ENV
	#ifeq ($(ENV),"PROD")
#		$(error ENV is set to PROD, aborting)#
#	endif

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
api:
	cd ../ && go run go/api/cmd/api/main.go
dev-server: dev-services ## Start development services and eqemu environment
	@if [ ! -f $(shell pwd)/server/eqemu_config.xml ]; then echo "Copying deploy/server/eqemu_config.xml..."; cp $(shell pwd)/docker/eqemu/eqemu_config.xml $(shell pwd)/server/; fi;
	@if [ ! -f $(shell pwd)/web/application/config/database.php ]; then echo "Copying deploy/web/applicaton/config/database.php..."; cp $(shell pwd)/docker/web/database.php  $(shell pwd)/web/application/config/; fi;
	@if [ ! -d $(shell pwd)/web/application/cache ]; then echo "Making deploy/web/application/cache..."; mkdir $(shell pwd)/web/application/cache; fi;
	@if [ ! -d $(shell pwd)/web/application/logs ]; then echo "Making deploy/web/application/logs..."; mkdir $(shell pwd)/web/application/logs; fi;
	-docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" --name shared -it eqemu /eqemu/shared_memory
dev-services: ## Start just services
	-docker-compose down
	-docker-compose up
	docker-compose down
prod-server-stop: ## Restart zone and world processes
	-@docker rm shared 2>/dev/null || true
	-@docker kill zone1 2>/dev/null || true
	-@docker rm zone1 2>/dev/null || true
	-@docker kill zone2 2>/dev/null || true
	-@docker rm zone2 2>/dev/null || true
	-@docker kill zone3 2>/dev/null || true
	-@docker rm zone3 2>/dev/null || true
	-@docker kill zone4 2>/dev/null || true
	-@docker rm zone4 2>/dev/null || true
	-@docker kill zone5 2>/dev/null || true
	-@docker rm zone5 2>/dev/null || true
	-@docker kill world 2>/dev/null || true
	-@docker rm world 2>/dev/null || true
prod-server-start:
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" --name shared -it eqemu /eqemu/shared_memory
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" -p 7001:7001/udp --name zone1 -it eqemu /eqemu/zone ecommons:7001
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" -p 7002:7002/udp --name zone2 -it eqemu /eqemu/zone ecommons:7002
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" -p 7003:7003/udp --name zone3 -it eqemu /eqemu/zone ecommons:7003
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" -p 7004:7004/udp --name zone4 -it eqemu /eqemu/zone ecommons:7004
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" -p 7005:7005/udp --name zone5 -it eqemu /eqemu/zone ecommons:7005
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default" --name world -it eqemu /eqemu/world
check-config: ## Check and create config files
	@if [ ! -f $(shell pwd)/server/eqemu_config.xml ]; then echo "Copying deploy/server/eqemu_config.xml..."; cp $(shell pwd)/docker/eqemu/eqemu_config.xml $(shell pwd)/server/; fi;
	@if [ ! -f $(shell pwd)/web/application/config/database.php ]; then echo "Copying deploy/web/applicaton/config/database.php..."; cp $(shell pwd)/docker/web/database.php  $(shell pwd)/web/application/config/; fi;
	@if [ ! -d $(shell pwd)/web/application/cache ]; then echo "Making deploy/web/application/cache..."; mkdir $(shell pwd)/web/application/cache; fi;
	@if [ ! -d $(shell pwd)/web/application/logs ]; then echo "Making deploy/web/application/logs..."; mkdir $(shell pwd)/web/application/logs; fi;
prod-server: check-config prod-server-stop prod-server-start ## Start production services and eqemu environment
dev-build: check-not-prod ## Build binaries
	docker build docker/build -t buildeq
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "/usr/bin/cmake ~/."
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "make"
prod-images: ## Builds production docker images
	docker build docker/eqemu -t eqemu
dev-images: check-not-prod ## Builds dev environment docker images needed to run dockerized eqemu
	docker build docker/build -t buildeq
	docker build docker/eqemu -t eqemu
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium-dev_1.0.11-1~bpo8+1_amd64.deb -O /eqemu/libsodium-dev.deb"
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium18_1.0.11-1~bpo8+1_amd64.deb -O /eqemu/libsodium18.deb"
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "dpkg -i /eqemu/libsodium*.deb"
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "rm -f /eqemu/libsodium-dev.deb"
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "rm -f /eqemu/libsodium18.deb"
image-purge: ## Purge containers and images made by this system.
	docker rm $(shell docker ps -a -q)
	docker rmi rebuildeq_web buildeq
dev-cmake: check-not-prod ## Runs cmake inside build image to prepare for build
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "/usr/bin/cmake ~/."
dev-clean: check-not-prod ## Cleans the build files using build image
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu buildeq /bin/bash -c "make clean"
prod-services: ## Runs docker-compose up, starting database, nats, and web server
	cd ..
	-docker-compose down
	-docker-compose up
	docker-compose down
dev-world: check-not-prod ## Starts world binary using eqemu image
	cd ..
	-docker run -v $(shell pwd)/../deploy/server:/eqemu -p 5998:5998/udp -p 5999:5999/udp -p 9000:9000/udp -p 9000:9000 --name world --network="rebuildeq_default" -it eqemu /eqemu/world
	docker rm world
dev-zone1: check-not-prod ## Starts a single zone binary on port  7001
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default"  -p 7002:7002/udp -it eqemu /eqemu/zone ecommons:7001
dev-zone2:check-not-prod  ## Starts zone binary using eqemu image on port 7001
	docker run -v $(shell pwd)/../deploy/server:/eqemu --network="rebuildeq_default"  -p 7002:7002/udp -it eqemu /eqemu/zone ecommons:7002
dev-proto: check-not-prod ## Removes proto compiled files and generates new ones based on proto folder
	rm -rf ../common/*.pb.*
	rm -rf ../go/eqproto/*
	protoc --cpp_out=../common --go_out=../go/eqproto -I ../proto ../proto/message.proto ../proto/rebuildeq.proto
dev-discordeq: check-not-prod ## Run discordeq in developer mode
	cd ../go/discordnats
	go run main.go
dev-buildeqbash: check-not-prod ## Run buildeq container and attach bash
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu -it buildeq /bin/bash
dev-eqemubash: check-not-prod ## Run eqemu container and attach bash
	docker run -v $(shell pwd)/../:/src -v $(shell pwd)/../deploy/server:/eqemu -it eqemu /bin/bash
dev-hugo: check-not-prod ## Run a hugo dev environment, watching for local changes
	cd ../web && $(MAKE) hugo-dev
dev-web-build: check-not-prod ## Builds ts, hugo, and hugogen files, prepare for web
	cd ../web && $(MAKE) web-dev
dev-hugogen-build: check-not-prod # runs the hugogen go script
	cd ../web && $(MAKE) hugogen-build
dev-clean-build: check-not-prod ## cleans all web stuff
	cd ../web && $(MAKE) clean-build
dev-js-build: check-not-prod ## builds javascript file, works great with hugo-dev for local testing
	cd ../web && $(MAKE) js-build
dev-ts-build: check-not-prod ## runs tsc to verify any typescript errors
	cd ../web && $(MAKE) ts-build
dev-hugo-build: check-not-prod ## runs hugo to build hugo files
	cd ../web && $(MAKE) hugo-build
dev-web-deploy: check-not-prod ## runs web-build then firebase deploys
	cd ../web && $(MAKE) deploy
dev-mariadb: check-not-prod ##start mariadb as a docker instance
	docker-compose run --service-ports mariadb
