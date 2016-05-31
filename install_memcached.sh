#!/bin/bash
cd "$(dirname "$0")"

sudo apt-get update
sudo apt-get install -y \
    libmemcached-dev \
    libmemcached11 

git clone https://github.com/php-memcached-dev/php-memcached
cd php-memcached
git checkout -b php7 origin/php7
/usr/local/php7/bin/phpize
./configure --with-php-config=/usr/local/php7/bin/php-config
make
sudo make install
