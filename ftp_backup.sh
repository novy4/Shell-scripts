#!/bin/bash

cd /tmp

HOST=uxx.your-storagebox.de #FTP server host or IP address.
USER=uxx #FTP username
PASS=yxx #FTP passsword
localpath="/var/www/backup/"
remotepath="/backups/pbx/"
lfile=$localpath$1
rfile=$remotepath$1

#ftp command with the -inv switches.
# -i turns off interactive prompts.
# -n prevents FTP from attempting to auto-login.
# -v enables verbose and progress.

### uploading new backup file ###
ftp -inv $HOST << EOF
user $USER $PASS
#lcd $1
put $lfile $rfile
bye
EOF

### deleting backup files older 30 days on remote side ###
rm old.log
find /var/www/backup/*.tar -mtime +30 -exec echo {} >> old.log \;

echo "" > /tmp/connect.log

echo "user" $USER $PASS >> /tmp/connect.log
for i in `cat /tmp/old.log`
do
  echo "del" $remotepath${i:16} >> /tmp/connect.log
done
echo "bye" >> /tmp/connect.log

ftp -inv $HOST < /tmp/connect.log

### deleting backup files older 30 days on local side ###
find /var/www/backup/*.tar -mtime +30 -exec rm {} \;
