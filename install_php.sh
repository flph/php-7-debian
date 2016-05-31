#!/bin/bash
cd "$(dirname "$0")"

# Create a dir for storing PHP module conf
mkdir /usr/local/php5/etc/conf.d

# Symlink php-fpm to php5-fpm
ln -s /usr/local/php5/sbin/php-fpm /usr/local/php5/sbin/php5-fpm

# Add config files
cp php-src/php.ini-production /usr/local/php5/lib/php.ini
mkdir /usr/local/php5/etc/php-fpm.d
cp conf/www.conf /usr/local/php5/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php5/etc/php-fpm.conf
cp conf/modules.ini /usr/local/php5/etc/conf.d/modules.ini

# Add the init script
cp conf/php5-fpm.init /etc/init.d/php5-fpm
chmod +x /etc/init.d/php5-fpm
update-rc.d php5-fpm defaults
rm /usr/bin/php && ln -s /usr/local/php5/bin/php /usr/bin/php
service php5-fpm start

#apache stuff
a2dismod mpm_event
a2dismod mpm_worker
a2enmod mpm_prefork
a2enmod php5
a2enmod rewrite
a2dismod php7
a2disconf php7

#handle php with apache
cat >/etc/apache2/conf-available/php5.conf <<ENDOFCONTENT
#PHP5
<FilesMatch \.php$>
SetHandler application/x-httpd-php
</FilesMatch>
ENDOFCONTENT

a2enconf php5
service apache2 restart
