#!/bin/bash
########################################################################
# User configuration section.
########################################################################
PROJECT_NAME='dc2017'

# php version you'd like to use. Only 5.6 and 7.0 allowed
PHP_VERSION=5.6

########################################################################
# Advanced configuration section.
########################################################################
# stage index. for example: stage01 has index 01 and stage02 has index 02
STAGE_INDEX=02
#enter name of the folder, where drupal's files are located
DOCROOT='docroot'
# folder where configs will be stored
CONFIG_STORAGE_DIR="sites/default/config/staging"
# profile name
INSTALATION_PROFILE_NAME='standard'

# database settings
DATABASE_NAME=$PROJECT_NAME"_db"
DATABASE_USER_NAME=$PROJECT_NAME"_db"
DATABASE_PASSWORD=$PROJECT_NAME"_db"
# localhost or mariadb at most cases
DATABASE_HOST='mariadb'
DATABASE_PORT=3306

####################################
# site settings.
####################################
ADMIN_ACCOUNT_NAME='webmaster'
ADMIN_ACCOUNT_PASSWORD='deweb'
SITE_EMAIL='webmaster@deweb.com.ua'
SITE_NAME=$PROJECT_NAME

####################################
# docker settings.
####################################
# TODO: decide what to do with docke engine installation
# if docker engine is installed on you machine = set value to 1, otherwise - set 0
IS_DOCKER_ENGINE_INSTALLED=1

####################################
#  Settings for DEV-STAGE sync
####################################

# Password for webmaster on dev environment.
# lets use project name by default
WEBMASTER_PASS=$PROJECT_NAME

#absolute path to site root on stage-server (without last /)
#example: /home/stage/public_html
STAGE_PATH_TO_DOCROOT="/home/stage$STAGE_INDEX/public_html"

#full adress of STAGE site
#example: http://www.example.com
#example when using HTTP Basic Authentication: http://myusername:letme%26in@example.com
STAGE_SITE_ADRESS="http://deweb:deweb@$STAGE_INDEX.d8.stage.deweb.com.ua"

#other remote host parameters
#will connect like: ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_SERVER
STAGE_REMOTE_USER="stage$STAGE_INDEX"
STAGE_REMOTE_SERVER="$STAGE_INDEX.d8.stage.deweb.com.ua"
STAGE_REMOTE_PORT="2022"

#stage db settings
STAGE_DATABASE_NAME=$STAGE_REMOTE_USER"_db"
STAGE_DATABASE_USER=$STAGE_REMOTE_USER"_user"
STAGE_DATABASE_PASSWORD='Pek3rUrafrUh'
STAGE_DATABASE_HOST='localhost'
STAGE_DATABASE_PORT=3306
####################################
#  Settings for STAGE-PROD sync
####################################

#absolute path to site root on prod-server (without last /)
#example: /home/prod/public_html
PROD_PATH_TO_DOCROOT=""

#other remote host parameters
#will connect like: ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_SERVER
PROD_REMOTE_USER=""
PROD_REMOTE_SERVER=""
PROD_REMOTE_PORT="22"

# TODO: move it to another place in file (?) and think about naming for variables
####################################
# Environment variables
####################################
CURRENT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )
DATE_TIME=`date "+%Y-%m-%d_%H-%M-%S"`
CURRENT_USER=$(whoami)
