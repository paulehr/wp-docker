#!/bin/bash 
#---------------------------------
#
# script to backup wordpress DB
#
#---------------------------------

BACKUPDIR=/srv/wp-docker/backup

# connect to DB container and run mysqldump to dump the blog to backup
docker exec wp-db sh -c \
'exec mysqldump --add-drop-table \
-h localhost \
-u"$MYSQL_USER" \
-p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" | gzip > /backup/wp.bak.$(date +%Y%m%d_%H%M%S).sql.gz'

#clean up any backup older then 14 days 
find $BACKUPDIR -mtime +14 -exec rm {} \;

