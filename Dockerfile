FROM debian:bullseye

WORKDIR /app/www/

RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release nginx software-properties-common \
  && curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
  && apt-get update \
  && apt-get install -y php8.3 php8.3-fpm php8.3-mysql \
  && rm -rf /var/lib/apt/lists/*

COPY ./Junia-2025 /app/www/html
RUN chmod -R 755 /app/www/html

COPY ./conf/gambling.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["bash", "/start.sh"]