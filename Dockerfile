FROM ubuntu:latest

RUN apt-get update -y && \
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

RUN apt-get install apache2 -y

RUN apt-get install php libapache2-mod-php  -y
    
RUN apt-get -y install graphviz aspell ghostscript clamav php7.4-pspell php7.4-curl php7.4-gd php7.4-intl \
    php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-ldap php7.4-zip php7.4-soap php7.4-mbstring

ADD moodle-latest-39.tgz /var/www/html/

RUN mkdir /var/www/html/moodledata

RUN chown -R www-data:www-data /var/www/html/moodle/ && \
    chmod -R 755 /var/www/html/moodle/ && \
    chown www-data /var/www/html/moodledata

COPY moodle.conf /etc/apache2/sites-available/

RUN a2enmod rewrite && \
    a2ensite moodle.conf && \
    a2dissite 000-default.conf

RUN service apache2 restart

EXPOSE 80

CMD ["apachectl","-D","FOREGROUND"]

