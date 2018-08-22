FROM ubuntu:18.10

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
#libwtdbomysql-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y libstdc++6 build-essential gcc-5 g++-5 libtool cmake curl debconf-utils git git-core libio-stringy-perl liblua5.1 liblua5.1-dev libluabind-dev libmysql++ libperl-dev libperl5i-perl libsodium-dev libmysqlclient-dev lua5.1 minizip make mariadb-client nano open-vm-tools unzip uuid-dev zlibc wget libjson-perl && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

ENV HOME /src
WORKDIR /src

RUN wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium-dev_1.0.11-1~bpo8+1_amd64.deb -O /src/libsodium-dev.deb \
	&& wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium18_1.0.11-1~bpo8+1_amd64.deb -O /src/libsodium18.deb \
	&& dpkg -i /src/libsodium*.deb \
	&& rm -f /src/libsodium-dev.deb \
	&& rm -f /src/libsodium18.deb

# Define default command.
CMD ["make"]