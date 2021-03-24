#!/bin/bash

# ######################################################################################
# Make sure this isn't the project repo. This file should not be run in the project repo.
# ######################################################################################
FILE=.project.repo
if test -f "$FILE"; then
    printf "\n$FILE exists.  Exiting.  This should not be run in the project repo.\n\n"
    exit 1
fi

# ######################################################################################
# Make sure that mysql, mysqlshow, and valet are installed and in the PATH
# ######################################################################################

# Check to make sure mysql is installed and available
if ! [ -x "$(command -v mysql)" ]; then
  echo 'Error: mysql is not installed and/or not in your PATH.' >&2
  exit 1
fi

# Check to make sure mysqlshow is installed and available
if ! [ -x "$(command -v mysqlshow)" ]; then
  echo 'Error: mysqlshow is not installed and/or not in your PATH.' >&2
  exit 1
fi

# Check to make sure valet is installed and available
if ! [ -x "$(command -v valet)" ]; then
  echo 'Error: valet is not installed and/or not in your PATH.' >&2
  exit 1
fi

# ######################################################################################
# Make sure the mysql config file exists.  If not, create it.
# ######################################################################################
FILE=~/.my.cnf
if test -f "$FILE"; then
    printf "\n$FILE exists.  Proceeding.\n\n"
else
  printf "\nNo ~/.my.cnf exists, creating one with an empty password.\n\n"
  printf "[client]\npassword=\"\"\n" > $FILE
  printf "\n"
fi

# ######################################################################################
# Make sure the parameters exist and then validate them
# ######################################################################################

# Make sure the first parameter is included: Database Name
if [ -z "$1" ]
  then
    printf "\nPlease include the desired database name as the first parameter. Exiting.\n\n"
    exit 1
fi

# make sure the database doesn't already exist
RESULT=`mysqlshow -u root $1 2>/dev/null | grep -v Wildcard | grep -o $1`
if [ "$RESULT" == "$1" ]; then
    printf "\nThe database $1 already exists. Exiting.\n\n"
    exit 1
fi

# Make sure the second parameter is included: Site Name
if [ -z "$2" ]
  then
    printf "\nPlease include the desired SITE NAME as the second parameter. Exiting.\n\n"
    exit 1
fi

printf "\nYour Website name is going to be: $2\n\n"
read -r -p "Is this correct? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        ;;
    *)
        exit 0
        ;;
esac

# Make sure the third parameter is included: Local Dev Address (don't include the .test)
if [ -z "$3" ]
  then
    printf "\nPlease include the desired LOCAL DEV ADDRESS (don't include .test) as the third parameter. Exiting.\n\n"
    exit 1
fi

printf "\nYour local dev address is going to be: http://$3.test\n\n"
read -r -p "Is this correct? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        ;;
    *)
        exit 0
        ;;
esac

# ######################################################################################
# Create the database & import the seed database
# ######################################################################################
printf "Creating the $1 database\n\n"
mysql -u root -e "CREATE DATABASE $1;"

printf "\n\nImporting Seed Database\n\n"
mysql -u root $1 < seeddb.sql

# ######################################################################################
# Create the .env file & populate it
# ######################################################################################
printf "\n\nCopying .env.example to .env"
cp .env.example .env

# handling the DB_DATABASE
printf "\n\nAdding Database name '$1' to .env file.\n\n"
sed -i "" "s/DB_DATABASE=\"\"/DB_DATABASE=\"$1\"/" .env

printf "\n\n.env Database is now: "
grep -F "DATABASE" .env

# handling the EN_US_SITE_NAME
printf "\n\nAdding site name '$2' to .env file.\n\n"
sed -i "" "s/EN_US_SITE_NAME=\"\"/EN_US_SITE_NAME=\"$2\"/" .env

printf "\n\n.env Site name is now: "
grep -F "EN_US_SITE_NAME" .env

# handling the EN_US_SITE_URL
printf "\n\nAdding local dev address 'http://$3.test' to .env file.\n\n"
sed -i "" "s/EN_US_SITE_URL=\"\"/EN_US_SITE_URL=\"http:\/\/$3.test\"/" .env
sed -i "" "s/BROWSERSYNC_PROXY_URL=\"\"/BROWSERSYNC_PROXY_URL=\"http:\/\/$3.test\"/" .env

printf "\n\n.env local dev address is now: "
grep -F "EN_US_SITE_URL" .env

# generate security key
printf "\n\nGenerating a security key.\n\n"
./craft setup/security-key


# ######################################################################################
# Attempt to run valet link
# ######################################################################################
printf "\n\nAttempting to run Valet Link $3"
(
  cd ./public
  valet link $3
)

# ######################################################################################
# Copying over the new gitignore
# ######################################################################################
printf "\n\n"
printf "Removing .gitignore and copying over the new one.\n\n"

rm .gitignore
mv .gitignore.project .gitignore

# ######################################################################################
# Initialize the git repo
# ######################################################################################
printf "\n\n"
printf "Initializing the Git Repo.\n\n"

git init

# ######################################################################################
# Next Step Message
# ######################################################################################
printf "\n\n"
printf "Next Log into the craftcms CP. \n\tThe Default Username is dev@harvestmedia.com
\n\tThe Default password is CoffeeIsAwesome\n\n"
