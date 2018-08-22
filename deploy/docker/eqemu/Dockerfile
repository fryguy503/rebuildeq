FROM ubuntu:18.10

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8


RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive  apt-get install -y liblua5.1 libmysql++ libperl5i-perl lua5.1 zlibc wget mariadb-client wget

ENV HOME /eqemu
WORKDIR /eqemu


RUN wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium-dev_1.0.11-1~bpo8+1_amd64.deb -O /eqemu/libsodium-dev.deb \
	&& wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium18_1.0.11-1~bpo8+1_amd64.deb -O /eqemu/libsodium18.deb \
	&& dpkg -i /eqemu/libsodium*.deb \
	&& rm -f /eqemu/libsodium-dev.deb \
	&& rm -f /eqemu/libsodium18.deb

