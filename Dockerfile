FROM nginx
COPY dishy.starlink.com /var/www/dishy.starlink.com
COPY web-servers/nginx/sites-available/dishy.starlink.com /etc/nginx/conf.d/dishy.starlink.com.conf