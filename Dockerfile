FROM ubuntu:14.04
MAINTAINER Boggart <github.com/Boggart>
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Nginx-PHP Installation
RUN apt-get update
RUN apt-get install -y nano curl wget software-properties-common
RUN add-apt-repository -y ppa:ondrej/php5
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y php5-cli php5-mysql php5-pgsql php5-sqlite php5-curl\
		       php5-gd php5-mcrypt php5-intl php5-imap php5-tidy php5-fpm supervisor nginx \
               && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ADD Nginx and php-fpm config
ADD build/nginx.conf /etc/nginx/sites-available/default
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && echo "<?php phpinfo(); ?>" > /var/www/phpinfo.php

# ADD supervisord config
ADD build/supervisord.conf /etc/supervisord.conf

ADD build/run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 80

#Start supervisord
CMD ["/run.sh"]