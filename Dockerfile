FROM fedora:21

CMD /tmp/start.sh

VOLUME /var/www/html

COPY start.sh /tmp/start.sh

RUN rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm && \
    rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/remi-release-21.rpm && \
    yum --enablerepo=remi install -y nginx php-fpm php-common && \
    yum --enablerepo=remi install -y php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongo php-pecl-sqlite php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml && \
    chmod +x /tmp/start.sh

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/wpnocache.conf /etc/nginx/wpnocache.conf
COPY conf/wpsecure.conf /etc/nginx/wpsecure.conf
COPY conf/site.conf /etc/nginx/conf.d/site.conf

EXPOSE 80
