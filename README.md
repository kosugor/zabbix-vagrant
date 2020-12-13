# Vagrant Zabbix

## What is Vagrant?

Vagrant is a tool that uses Oracle's VirtualBox to dynamically build configurable, lightweight, and portable virtual machines. Vagrant supports the use of either Puppet or Chef for managing the configuration. Much more information is available on the [Vagrant web site](http://www.vagrantup.com).

## What is this project?

This is the Vagrant configuration used in my box for [Zabbix](https://www.zabbix.com/) at VagrantCloud in isaqueprofeta/zabbix for VirtualBox provider. They start out with Zabbix Server 5.2, Apache and PostgreSQL 12 with TimescaleDB. The Operating System is CentOS 8.

## How do I install Vagrant?

The host OS used in testing these examples was Ubuntu-based 18.04, but any OS should work as long as VirtualBox can be installed. The VirtualBox version used is 6.1 and Vagrant version is v2.2.14.

- Download VirtualBox 6.1: https://www.virtualbox.org/wiki/Downloads
- Download Vagrant 2.2.14: https://www.vagrantup.com/downloads

## How do I run?

Two options:

1. Using the VagrantCloud box: From an empty directory, Create a Vagrantfile and put in it the contents:

```
Vagrant.configure("2") do |config|
  config.vm.box = "isaqueprofeta/zabbix"
  config.vm.box_version = "5.2.12"
  config.vm.network "forwarded_port", guest: 80 , host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 5432 , host: 5432, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 10050 , host: 10050, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 10051 , host: 10051, host_ip: "127.0.0.1"
end
```

Save, exit, and then type:

```
vagrant init isaqueprofeta/zabbix
vagrant up
```

2. Build ground up from Centos8: Clone this repo and inside it, run vagrant up.

## How do I work?

0. Zabbix Frontend is forwarded from TCP/80 of guest to TCP/8080 on the host, so just go for http://localhost:8080 (User: Admin, Pass:zabbix), and you should be fine

1. Ports 5432, 10050 and 10051 are directly mapped from the guest to the host to use it as appliance and make it easier to connect to the agents and to make queries using SQL.

2. Zabbix Database Password: Z4bb1xD4t4b4s3

## Quick reference:

1. How to stop/turn off:

```
vagrant halt
```

1. How to clean/delete all data:

```
vagrant destroy
vagrant box prune isaqueprofeta/zabbix
```

2. Create a snapshot for tests:

```
vagrant snapshot create MySnapshot
```

2. Recover the snapshot:

```
vagrant snapshot restore MySnapshot
```