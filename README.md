# bash scripts:

 - MySQL_backup.sh - mysqldump a db and uploading to hetzner storage

 - ftp_backup.sh - uploading issabella pbx backup to hetzner storage.
   - open file /var/www/backup/automatic_backup.php
   - add string system('/var/lib/asterisk/agi-bin/ftp_backup.sh '.$sBackupFilename); next to the 33 line
