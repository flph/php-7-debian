#!/bin/bash
cd "$(dirname "$0")"

# Create a dir for storing PHP module conf
mkdir /usr/local/php7/etc/conf.d

# Symlink php-fpm to php7-fpm
ln -s /usr/local/php7/sbin/php-fpm /usr/local/php7/sbin/php7-fpm

# Add config files
cp php-src/php.ini-production /usr/local/php7/lib/php.ini
cp conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf
cp conf/modules.ini /usr/local/php7/etc/conf.d/modules.ini

# Add the init script
cp conf/php7-fpm.init /etc/init.d/php7-fpm
chmod +x /etc/init.d/php7-fpm
update-rc.d php7-fpm defaults
ln -s /usr/local/php7/bin/php /usr/bin/php
service php7-fpm start

#apache stuff
a2dismod mpm_event
a2dismod mpm_worker
a2enmod mpm_prefork
a2enmod php7
a2enmod rewrite

#handle php with apache
cat >/etc/apache2/conf-available/php7.conf <<ENDOFCONTENT
#PHP7
<FilesMatch \.php$>
SetHandler application/x-httpd-php
</FilesMatch>
ENDOFCONTENT

a2enconf php7
service apache2 restart
