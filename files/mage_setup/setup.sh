#!/bin/bash
service mysql start
mysql -u root -pmage < setup.sql

cd /var/www
git clone https://github.com/magento/magento2-sample-data.git sample-data
cd sample-data/dev/tools
php -f build-sample-data.php -- --ce-source="/var/www/magento2"

cd /var/www/magento2
bin/magento setup:install --base-url=http://magento2.demoby.me/ --db-host=localhost --db-name=magento2 --db-user=mage --db-password=mage --admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=VND --timezone=Asia/Ho_Chi_Minh --use-rewrites=1 --backend-frontname=admin

bin/magento deploy:mode:set developer
bin/magento indexer:reindex
bin/magento cache:clean full_page

chown -R www-data:www-data ../magento2
chown -R www-data:www-data ../sample-data

find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; && chmod u+x bin/magento

