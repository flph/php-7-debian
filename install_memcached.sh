#!/bin/bash
cd "$(dirname "$0")"

sudo apt-get update
sudo apt-get install -y \
    libmemcached-dev \
    libmemcached11 

git clone https://github.com/php-memcached-dev/php-memcached
cd php-memcached
git checkout -b master origin/master
make clean
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
sudo make install
