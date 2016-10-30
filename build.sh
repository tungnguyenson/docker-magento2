#!/bin/sh
BASE_DIR=$(dirname $0)
docker build $@ -t my_magento2c $BASE_DIR
