#!/bin/bash
echo '----Installing zabbix packages---- '
sudo apt-get -y install snmp perl libxml-simple-perl libsnmp-perl
curl -sL -o ~/bin/mib2zabbix https://raw.githubusercontent.com/cavaliercoder/mib2zabbix/master/mib2zabbix.pl
chmod +x ~/bin/mib2zabbix 