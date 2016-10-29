#!/bin/bash

NAME=magento2
docker rm -f $NAME
docker run -id -p 8003:80 -w /var/www/magento2 --name $NAME my_magento2
docker exec -it $NAME /bin/bash
