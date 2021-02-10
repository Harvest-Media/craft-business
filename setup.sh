#!/bin/bash

if [ $# -eq 0 ]
  then
    printf "\n\nPlease include the desired database name as the first parameter. Exiting.\n\n"
    exit 1
fi

FILE=~/.my.cnf
if test -f "$FILE"; then
    printf "\n$FILE exists.  Proceeding.\n\n"
else
  printf "\nNo ~/.my.cnf exists, creating one with an empty password.\n\n"
  printf "[client]\npassword=\"\"\n" > $FILE
  printf "\n"
fi

printf "Creating the $1 database\n\n"
mysql -u root -e "CREATE DATABASE $1;"

printf "\n\nImporting Seed Database\n\n"
mysql -u root $1 < seeddb.sql

printf "\n\nCopying .env.example to .env"
cp .env.example .env

printf "\n\nAdding Database name '$1' to .env file.\n\n"
sed -i "" "s/DB_DATABASE=\"\"/DB_DATABASE=\"$1\"/" .env

printf "\n\n.env Database is now: "
grep -F "DATABASE" .env

printf "\n\n"
printf "Removing .gitignore and copying over the new one.\n\n"

rm .gitignore
mv .gitignore.project .gitignore

printf "\n\nGenerating a security key.\n\n"
./craft setup/security-key

printf "\n\n"

printf "Next Steps:\n----------------\n"
printf "1. Change Directory to the public directory\n"
printf "2. Run 'valet link'\n"
printf "3. Update the environment URLs in the .env file.\n"
printf "4. Log into the craftcms CP. \n\tThe Default Username is dev@harvestmedia.com
\n\tThe Default password is CoffeeIsAwesome\n\n"
