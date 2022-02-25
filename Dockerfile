FROM nginx:alpine

LABEL maintainer="realJoshByrnes on Github"

COPY ./config/openrc-gammu-smsd /etc/init.d/gammu-smsd

RUN /sbin/apk update && /sbin/apk add --no-cache \
  # Install Gammu-SMSD, PHP8, MariaDB-Client & OpenRC
    gammu-smsd php8 php8-fpm php8-mysqli php8-mbstring \
    php8-session php8-ctype openrc mariadb-client tzdata \
    composer php8-intl \
  # Set default timezone to Australia/Sydney
  && cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime \
  && echo "Australia/Sydney" >  /etc/timezone \
  && apk del tzdata \
  # Create required directories
  && /bin/busybox mkdir -p /run/openrc /var/www /var/log/gammu \
  # Configure OpenRC
  && /bin/busybox touch /run/openrc/softlevel \
  # Get Kalkun and add to /var/www
  && /bin/busybox wget -qO- https://github.com/kalkun-sms/Kalkun/tarball/devel | \
     /bin/busybox tar x -zvf - -C /var/www --strip-components=1 \
  # Create www user
  && /bin/busybox adduser -D -g 'www' www \
  && /bin/busybox sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|;listen.group\s*=\s*nobody|listen.group = www|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|user\s*=\s*nobody|user = www|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|group\s*=\s*nobody|group = www|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|;chdir\s*=\s/var/www|chdir = /var/www|g" /etc/php8/php-fpm.d/www.conf \
  && /bin/busybox sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php8/php-fpm.conf \
  && cd /var/www/ \
  && composer install --no-dev

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/gammurc /etc/gammurc
COPY ./config/kalkun-daemon.php /var/www/scripts/daemon.php
COPY ./config/kalkun-daemon.sh /var/www/scripts/daemon.sh
COPY ./config/kalkun-database.php /var/www/application/config/database.php

# Set permissions
RUN /bin/busybox chown -R www:www /var/www \
  && /bin/busybox chown -R www:www /usr/share/nginx \
  && /bin/busybox chmod +x /etc/init.d/gammu-smsd \
  && /bin/busybox chmod +x /var/www/scripts/daemon.sh \
  # Set auto-start
  && /sbin/rc-update add gammu-smsd default \
  && /sbin/rc-update add php-fpm8 default \
  && /sbin/rc-update add nginx default

CMD ["openrc", "default"]
