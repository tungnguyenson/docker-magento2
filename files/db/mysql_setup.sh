#!/bin/bash
debconf-set-selections <<< 'mysql-server mysql-server/root_password password mage'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password mage'

apt-get install -y mysql-server mysql-client

#service mysql start
#mysql -u root -pmage < mage_setup.sql
