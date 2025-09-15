FROM nginx AS junia-nginx
VOLUME /home/tibo/Junia-2025:/var/www/html
RUN rm /etc/nginx/cond.d/default.conf
RUN   

