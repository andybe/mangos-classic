#!/bin/bash

DATABASE_TYPE=classic-db

# run from the root level in the container

cd /

# this point is only usefull for one time shoot.
# normal database clone exists

if [ ! -d "$DATABASE_TYPE" ]; then

   echo  git clone git://github.com/cmangos/$DATABASE_TYPE.git
   
   cd $DATABASE_TYPE

else 

  cd $DATABASE_TYPE
  # if configuration exist remove it, 
  # because git stroungle us with a commit request
  if [ -f "/$DATABASE_TYPE/InstallFullDB.config" ]; then
     rm /$DATABASE_TYPE/InstallFullDB.config
  fi

  git pull


fi

######################################################
# DATABASE STRUCTUR                                  #
######################################################
echo Create Database structur

mysql -h$MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD < ../mangos/sql/create/db_create_mysql.sql
echo Database structur created

# mangos work remote to the database container
# while we not export the database to external interface, we are save at this point.

TSQL=/tmp/mangos-allow-remote.sql

cat << EOF > $TSQL
GRANT ALL PRIVILEGES ON  classicmangos.* TO 'mangos'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON  classiccharacters.* TO 'mangos'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON  classicrealmd.* TO 'mangos'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo Grant database user remote access inside the container structur

mysql -h$MYSQL_HOST -uroot -p$MYSQL_ROOT_PASSWORD  < $TSQL


rm $TSQL

######################################################
# REALMD BASE DATA                                   #
######################################################

# create the realmd
echo Update realmd database
mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD classicrealmd < mangos/sql/base/realmd.sql

######################################################
# WORLD DATA                                         #
######################################################
cat << EOF > /$DATABASE_TYPE/InstallFullDB.config
DB_HOST="$MYSQL_HOST"
DB_PORT="3306"
DATABASE="classicmangos"
USERNAME="$MYSQL_USER"
PASSWORD="$MYSQL_PASSWORD"
CORE_PATH="../mangos"
MYSQL="mysql"
FORCE_WAIT="YES"
DEV_UPDATES="NO"
AHBOT="NO"
EOF
echo Database configuration written ...

./InstallFullDB.sh
