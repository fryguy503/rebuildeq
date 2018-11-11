FROM php:5.6-apache
MAINTAINER Xackery <xackery@gmail.com>

RUN a2enmod rewrite
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Define default command.
#CMD ["/bin/bash"]
