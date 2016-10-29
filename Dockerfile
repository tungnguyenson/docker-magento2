FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
        vim telnet wget curl git

### Install Apache and PHP
RUN apt-get install -y apache2 && a2enmod rewrite

RUN apt-get install -y --allow-unauthenticated php7.0 libapache2-mod-php7.0 php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-intl php7.0-xsl php7.0-mbstring php7.0-zip php7.0-bcmath php7.0-iconv
COPY conf/php.ini /etc/php/7.0/apache2/
ADD conf/apache2/ /etc/apache2/

#CMD service apache2 start

### Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer

### Install MySQL
COPY files/db/mysql_setup.sh /tmp/
RUN /tmp/mysql_setup.sh

### Source code
RUN cd /var/www && \
	curl -L https://github.com/magento/magento2/archive/2.1.2.tar.gz -o magento2.tgz && \
	tar -xzf magento2.tgz && \
	mv magento2-2.1.2 magento2 && \
	rm -f magento2.tgz

#RUN cd /var/www/magento2 && bin/magento sampledata:deploy

### Set file permissions
#WORKDIR /var/www/magento2
RUN cd /var/www/magento2 && composer install

ADD files/mage_setup /tmp/mage_setup
RUN cd /tmp/mage_setup && ./setup.sh

### Process management
RUN apt-get install -y supervisor
ADD conf/supervisor/ /etc/supervisor/conf.d/

### Clean-up
# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

EXPOSE 22 80
#CMD ["/usr/bin/supervisord", "-c /etc/supervisor/supervisord.conf"]
#CMD ["/usr/bin/supervisord"]

