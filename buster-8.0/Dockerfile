#Created at Sat 24 Apr 2021 05:00:20 PM UTC
FROM php:8.0-apache-buster
MAINTAINER Mahyuddin Susanto <udienz@gmail.com>

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
	libjpeg-dev libfreetype6-dev \
	libpng-dev libbz2-dev libcurl4-gnutls-dev libxml2-dev \
	libenchant-dev libsnmp-dev libgmp-dev libicu-dev \
	libc-client-dev libkrb5-dev libmagickwand-dev  ghostscript \
	libgdsii-dev libldap2-dev libmcrypt-dev unzip libiodbc2-dev \
	libxml2-dev libxmlrpc-epi-dev libxslt1-dev libxmltok1-dev \
	freetds-dev libpq-dev libsqlite3-dev libpspell-dev  \
	libedit-dev librecode-dev libtidy-dev wget \
	; \
	rm -rf /var/lib/apt/lists/*
	 
RUN mkdir /opt/oracle ;\
    cd /opt/oracle; \
    wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-sdk-linux.x64-21.1.0.0.0.zip -O /opt/oracle/instantclient-sdk-linux.x64-21.1.0.0.0.zip; \
    wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-21.1.0.0.0.zip -O /opt/oracle/instantclient-basic-linux.x64-21.1.0.0.0.zip


# Install Oracle Instantclient
RUN  unzip /opt/oracle/instantclient-basic-linux.x64-21.1.0.0.0.zip -d /opt/oracle ;\
     unzip /opt/oracle/instantclient-sdk-linux.x64-21.1.0.0.0.zip -d /opt/oracle ;\
     rm -rf /opt/oracle/*.zip
    
ENV LD_LIBRARY_PATH  /opt/oracle/instantclient_21_1:${LD_LIBRARY_PATH}
# Install Oracle extensions
RUN set -ex; \
		docker-php-ext-configure oci8 --with-oci8=instantclient,/opt/oracle/instantclient_21_1/;\ 
    docker-php-ext-install -j$(nproc) oci8 ;\ 
		docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/opt/oracle/instantclient_21_1,12.1 ;\
    docker-php-ext-install -j$(nproc) pdo_oci; \
    ldconfig

RUN set -ex ;\
	 ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/libsybdb.so; \
	 docker-php-ext-install -j$(nproc) pdo_dblib

RUN set -ex ;\
	docker-php-ext-install -j$(nproc) bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo ftp \
	gettext gmp hash iconv imap gd \
	intl json ldap mbstring mcrypt mysqli opcache pcntl pdo pdo_dblib pdo_mysql \
	pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode session shmop simplexml \
	snmp soap sockets sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlrpc xsl zip
RUN set -ex; \
	\
	apt-get update; \
	apt-get remove -y \
	libjpeg-dev libfreetype6-dev \
	libpng-dev libbz2-dev libcurl4-gnutls-dev libxml2-dev \
	libenchant-dev libsnmp-dev libgmp-dev libicu-dev \
	libc-client-dev libkrb5-dev libmagickwand-dev  ghostscript \
	libgdsii-dev libldap2-dev libmcrypt-dev unzip libiodbc2-dev \
	libxml2-dev libxmlrpc-epi-dev libxslt1-dev libxmltok1-dev \
	freetds-dev libpq-dev libsqlite3-dev libpspell-dev  \
	libedit-dev librecode-dev libtidy-dev \
	; \
	apt-get autoclean ; \
	apt-get autoremove -y; \
	rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite expires

VOLUME /var/www/html

CMD ["apache2-foreground"]

