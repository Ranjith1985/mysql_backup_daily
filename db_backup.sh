#! /bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/Data1/Backpup_117/DB/$TIMESTAMP"
MYSQL_USER='backup'
#MYSQL=/usr/bin/mysql
MYSQL_PASSWORD='n@s@dm!n'
#MYSQLDUMP=/usr/bin/mysqldump
MYSQL_HOST=10.10.10.117
mkdir -p "$BACKUP_DIR"

echo "Starting MySQL Backup";

databases=`mysql --user=$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  #mysqldump --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db  > "$BACKUP_DIR/mysql/$db.sql"
  mysqldump --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD  -h $MYSQL_HOST --databases $db | gzip > "$BACKUP_DIR/$db.sql.gz"
done
