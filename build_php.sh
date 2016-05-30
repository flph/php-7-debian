#!/bin/bash
cd "$(dirname "$0")"

# Dependencies
sudo apt-get update
sudo apt-get install -y \
    apache2 \
    apache2-dev \
    build-essential \
    pkg-config \
    git-core \
    autoconf \
    bison \
    libxml2-dev \
    libbz2-dev \
    libmcrypt-dev \
    libicu-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libltdl-dev \
    libjpeg-dev \
    libpng-dev \
    libpspell-dev \
    libreadline-dev \
    libxpm-dev \
    libfreetype6-dev \
    libpq-dev \
    libxslt-dev \
    perl

sudo mkdir /usr/local/php7

git clone https://github.com/php/php-src.git
cd php-src
git checkout PHP-7.0.7
git pull
./buildconf --force

CONFIGURE_STRING="--prefix=/usr/local/php7 \
            --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
	    --with-layout=PHP \
            --with-curl \
            --with-pear \
            --with-zlib \
            --with-mhash \
            --with-pgsql \
            --with-mysqli \
            --with-pdo-mysql \
            --with-pdo-pgsql \
            --with-openssl \
            --with-xmlrpc \
            --with-xsl \
            --with-bz2 \
            --with-gettext \
            --with-readline \
            --with-fpm-user=www-data \
            --with-fpm-group=www-data \
            --with-kerberos \
            --with-gd \
            --with-jpeg-dir \
            --with-png-dir \
            --with-png-dir \
            --with-xpm-dir \
            --with-freetype-dir \
	    --with-apxs2 \
            --enable-gd-native-ttf \
            --enable-fpm \
            --enable-cli \
            --enable-inline-optimization \
            --enable-exif \
            --enable-wddx \
            --enable-zip \
            --enable-bcmath \
            --enable-calendar \
            --enable-ftp \
            --enable-mbstring \
            --enable-soap \
            --enable-sockets \
            --enable-shmop \
            --enable-dba \
            --enable-sysvsem \
            --enable-sysvshm \
            --enable-sysvmsg \
            --enable-intl" 
./configure $CONFIGURE_STRING

make
sudo make install
