!#/bin/bash
echo '----Installing timescaledb repo----- '
sudo apt install -y gnupg unzip apt-transport-https
echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg
sudo apt -y update

echo '----Installing postgresql repo----- '
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y

echo '----Installing postgresql and timescaledb----- '
sudo apt -y install postgresql-18 postgresql-client-18 timescaledb-2-postgresql-18='2.25*'
sudo timescaledb-tune --quiet --yes
sudo sed -i "s/max_connections = 25/max_connections = 125/" /etc/postgresql/18/main/postgresql.conf
sudo systemctl restart postgresql
