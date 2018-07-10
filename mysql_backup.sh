#!/bin/bash

# Database credentials
user="x"
password="y"
host="localhost"
remote_host="uxy.your-storagebox.de"
db_name="z"
export SSHPASS=xxyy


# Other options
backup_path="/root/_backup/mysql"
date=$(date +"%d-%b-%Y")
remote_path="/backups/a/"

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

# Upload the backup to the remote storage
sshpass -e sftp $remote_host:$remote_path << !
  lcd $backup_path
  cd $remote_path
  put $db_name-$date.sql
  bye
!

# Delete files from local storage older than 30 days
find $backup_path/* -mtime +30 -exec rm {} \;
