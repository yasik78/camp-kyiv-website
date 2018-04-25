#!/bin/bash
sudo true

cp settings.sh ci/scripts

CURRENT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# include file with settings
. "$CURRENT_PATH"/settings.sh

cd ci
echo "version: '2.0'

services:
  mariadb:
    image: wodby/drupal-mariadb:1.0.0
    environment:
      MYSQL_RANDOM_ROOT_PASSWORD: 1
      MYSQL_DATABASE: $DATABASE_NAME
      MYSQL_USER: $DATABASE_USER_NAME
      MYSQL_PASSWORD: $DATABASE_PASSWORD
    volumes:
      - ~/.docker-runtime/$PROJECT_NAME/mariadb:/var/lib/mysql

  php:
    image: wodby/drupal-php:$PHP_VERSION-1.0.0 # Allowed: 7.0, 5.6.
    environment:
      PHP_SITE_NAME: dev
      PHP_HOST_NAME: localhost:8000
      PHP_SENDMAIL_PATH: /usr/sbin/sendmail -t -i -S mailhog:1025
      PHP_XDEBUG_ENABLED: 1
      PHP_XDEBUG_AUTOSTART: 1
      #PHP_XDEBUG_REMOTE_CONNECT_BACK: 0         # This is needed to respect remote.host setting bellow
      #PHP_XDEBUG_REMOTE_HOST: \"10.254.254.254\"  # You will also need to 'sudo ifconfig lo0 alias 10.254.254.254'
    volumes:
      - ../$DOCROOT/:/var/www/html
      - ./dump:/tmp/db

  nginx:
    image: wodby/drupal-nginx:1.10-1.1.0
    environment:
      NGINX_SERVER_NAME: localhost
      NGINX_UPSTREAM_NAME: php
      DRUPAL_VERSION: 8 # Allowed: 7, 8.
    volumes_from:
      - php
    ports:
      - 8000:80

  pma:
    image: phpmyadmin/phpmyadmin
    environment:
      PMA_HOST: mariadb
      PMA_USER: $DATABASE_USER_NAME
      PMA_PASSWORD: $DATABASE_PASSWORD
      PHP_UPLOAD_MAX_FILESIZE: 1G
      PHP_MAX_INPUT_VARS: 1G
    ports:
     - 8001:80

  mailhog:
    image: mailhog/mailhog
    ports:
      - 8002:8025

    ">'docker-compose.yml'

# add project name to the etc/.project-name
echo "$PROJECT_NAME">etc/.project-name

cd ..

echo "#####################################################"
echo "#       INJECTING DOCKER INTO YOUR PROJECT...       #"
echo "#####################################################"
if [ ! -d "$DOCROOT/scripts" ]
  then mkdir $DOCROOT/scripts
fi

cp -r ci/scripts/* $DOCROOT/scripts
cp -r ci/scripts/ $DOCROOT/scripts
cp ci/interfaces/* $DOCROOT
cp ci/etc/.* $DOCROOT

echo "#####################################################"
echo "#        PREPARING FILES FOR INSTALLATION...        #"
echo "#####################################################"

cp $DOCROOT/sites/default/default.settings.php ci/settings/settings.php
cp $DOCROOT/sites/example.settings.local.php ci/settings/settings.local.php

cp $DOCROOT/sites/default/default.settings.php $DOCROOT/sites/default/settings.php
chmod 777 -R $DOCROOT/sites/default/

# create sites/default/files if not exists
if [ ! -d "$DOCROOT/sites/default/files" ]
  then
    mkdir $DOCROOT/sites/default/files
    chmod 777 -R $DOCROOT/sites/default/files
fi

# create config storage dir if not exists
if [ ! -d "$CONFIG_STORAGE_DIR" ]
  then
    mkdir $DOCROOT/sites/default/config
    mkdir $CONFIG_STORAGE_DIR
    chmod 777 -R $CONFIG_STORAGE_DIR
fi

#create hash_salt.txt
echo "$(date +"%Y%m%d%H%M%S")1" > $DOCROOT/sites/default/hash_salt.txt


echo "#####################################################"
echo "#            STARTING DOCKER CONTAINERS...          #"
echo "#####################################################"
cd $DOCROOT

# add permissions for scripts-interfaces
chmod 777 -R ./scripts
chmod 777 cex.sh cim.sh flush.sh start.sh stop.sh updb.sh

# TODO: remove this stop.sh it could be unusefull
sh stop.sh
./scripts/docker-start-and-quite

# TODO: make settings for site installation process
# TODO: place all global variables into drush si command
# TODO: move code from all autsourced files in to this file (?)
echo "#####################################################"
echo "#            DEBUGING DRUSH SITE-INSTALL...         #"
echo "#####################################################"
# TODO: check if it possible to add settings for confign folder during the installation proccess
./scripts/docker-drush-si

sudo chmod -R 777 sites/default
# TODO: add global variables for config folders
#create folders for configs
sudo chmod -R 777 sites/default
sudo chmod -R 777 ../ci/dump
cd ..

echo "#####################################################"
echo "#              COPYING SETTINGS FILES...            #"
echo "#####################################################"

# add stage settings to settings.php
echo "\$databases['default']['default'] = array (
  'database' => '$STAGE_DATABASE_NAME',
  'username' => '$STAGE_DATABASE_USER',
  'password' => '$STAGE_DATABASE_PASSWORD',
  'prefix' => '',
  'host' => '$STAGE_DATABASE_HOST',
  'port' => '',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);


  \$settings['install_profile'] = '$INSTALATION_PROFILE_NAME';
  \$config_directories['sync'] = '$CONFIG_STORAGE_DIR';
  \$settings['hash_salt'] = "$(date +"%Y%m%d%H%M%S")1";

   if (file_exists(\$app_root . '/' . \$site_path . '/settings.local.php')) {
   include \$app_root . '/' . \$site_path . '/settings.local.php';
}
">>ci/settings/settings.php

if [ -f "$DOCROOT/sites/default/settings.local.php" ]
  then
    cp $DOCROOT/sites/default/settings.local.php ci/settings/settings.local.php
    sudo rm $DOCROOT/sites/default/settings.local.php
fi

# add settings to settings.local.php
echo "\$databases['default']['default'] = array (
  'database' => '$DATABASE_NAME',
  'username' => '$DATABASE_USER_NAME',
  'password' => '$DATABASE_PASSWORD',
  'prefix' => '',
  'host' => '$DATABASE_HOST',
  'port' => '',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);">>ci/settings/settings.local.php

# replace existing settings files

sudo cp ci/settings/settings.php "$DOCROOT/sites/default/settings.php"
sudo cp ci/settings/settings.local.php "$DOCROOT/sites/default/settings.local.php"

sudo chmod 777 "$DOCROOT/sites/default/settings.php"
sudo chmod 777 "$DOCROOT/sites/default/settings.local.php"

sudo chmod 777 -R "$DOCROOT/sites/default/config/staging"

#echo "#####################################################"
#echo "#           REMOVING INSTALLATION SOURCE            #"
#echo "#####################################################"
#
#sudo rm scripts/docker-drush-si
#sudo rm scripts/docker-start-and-quite
#
#cd ..
#sudo rm -rf ci/etc
#sudo rm -rf ci/settings
#sudo rm -rf ci/interfaces
#sudo rm -rf ci/scripts
#sudo rm -rf draft
#sudo rm settings.sh
#sudo rm README.md
#
#espeak 'congratulations, you have installed drupal'
#notify-send "Drupal 8 installation" "done" -i gtk-info
#
##removes itself
#rm -- "$0"
