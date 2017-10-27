# NATS self notes
for CPP integration - building from source

    git clone https://github.com/nats-io/cnats
    cmake . -DNATS_BUILD_WITH_TLS=OFF (We don't need TLS)
    opened nats.sln for windows install.
    right click -> Build, on INSTALL Project, built all eventually.
    go to src, Debug, find nats.dll/nats.lib, copy to rebuildeq root/dependencies/nats_x64/lib
    copy src to root/dependencies/nats_x64/include
    cmake was edited to include nats_x64 files above into the eqemu solution

    You can spin up the instance using docker-compose run nats. It won't expose ports unless you spin up a linking object i've found, so docker-compose run web will spin up mariadb and nats.. you can verify if the port is exposed using docker ps and seeing if it's binding to 0.0.0.0 e.g.:

D:\code\go\src\github.com\xackery\rebuildeq>docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
ff36fd143d65        rebuildeq_web            "docker-php-entryp..."   2 hours ago         Up 2 hours          80/tcp                                                                   rebuildeq_web_run_5
07066c47ee40        nats:latest              "/gnatsd -c gnatsd..."   2 hours ago         Up 2 hours          0.0.0.0:4222->4222/tcp, 0.0.0.0:6222->6222/tcp, 0.0.0.0:8222->8222/tcp   rebuildeq_nats_1
6dfedcf0bab5        bitnami/mariadb:latest   "/app-entrypoint.s..."   2 weeks ago         Up 8 hours          0.0.0.0:3306->3306/tcp                                                   rebuildeq_mariadb_1
