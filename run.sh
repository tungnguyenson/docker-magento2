#!/bin/bash

NAME=magento2c
docker rm -f $NAME
docker run -id -p 8004:80 -w /var/www/magento2 --name $NAME my_magento2c
docker exec -it $NAME /bin/bash
