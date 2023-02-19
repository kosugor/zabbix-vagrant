#!/bin/bash
echo '----Installing zabbix packages---- '
sudo apt-get -q update
sudo apt-get -y install apache2 php php-mysql php-mysqlnd php-ldap php-bcmath php-mbstring php-gd php-pdo php-xml libapache2-mod-php
sudo apt-get -y install mariadb-server mariadb-client
sudo apt-get -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent zabbix-get zabbix-sender