!#/bin/bash
echo '----Installing zabbix repo----- '
cd /tmp
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.0+debian13_all.deb
sudo dpkg -i zabbix-release_latest_7.0+debian13_all.deb
sudo apt -y update 

echo '----Installing zabbix packages---- '
sudo apt -y install zabbix-server-pgsql zabbix-frontend-php php8.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent2 zabbix-agent2-plugin-postgresql

echo '+++++++----Setting up database-----++++++++++'
sudo -u postgres createuser zabbix
sudo -u postgres createdb -O zabbix zabbix
#zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
echo "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;" | sudo -u postgres psql zabbix
cat /usr/share/zabbix-sql-scripts/postgresql/timescaledb/schema.sql | sudo -u zabbix psql zabbix
sudo -u postgres psql -c "alter user zabbix with encrypted password 'Z4bb1xD4t4b4s3p4s2';"

echo '----Configuring Zabbix Server----------'
sudo sed -i "s/# DBHost=localhost/DBHost=localhost/" /etc/zabbix/zabbix_server.conf
sudo sed -i "s/# DBPassword=/DBPassword=Z4bb1xD4t4b4s3p4s2/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# StartSNMPTrapper=0/StartSNMPTrapper=1/" /etc/zabbix/zabbix_server.conf
#sudo sed -i "s/# SNMPTrapperFile=\/tmp\/zabbix_traps.tmp/SNMPTrapperFile=\/var\/lib\/zabbix\/snmptraps\/snmptraps.log/" /etc/zabbix/zabbix_server.conf
sudo sed -i "s/upload_max_filesize 2M/upload_max_filesize 8M/g" /etc/zabbix/apache.conf

echo '----Configuring Zabbix Frontend--------'
sudo cat /vagrant/zabbix.conf.php > /tmp/zabbix.conf.php
sudo cp /tmp/zabbix.conf.php /etc/zabbix/web/zabbix.conf.php

sudo systemctl restart apache2

echo '----Starting Zabbix Server-------------'
sudo systemctl start zabbix-server
sudo systemctl enable --now zabbix-server

