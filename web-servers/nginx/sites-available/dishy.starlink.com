# SPDX-License-Identifier: AGPL-3.0-or-later
server {
	listen 80;
	listen [::]:80;
	server_name dishy.starlink.com;
	root /var/www/dishy.starlink.com/;
	index index.html;
  rewrite ^/statistics /index.html last;
	add_header Access-Control-Allow-Origin http://router.starlink.com:9001;
	add_header Vary Origin;
}
server {
	listen 9201;
	listen [::]:9201;
	server_name dishy.starlink.com;
	root /var/www/dishy.starlink.com/;
	location / {
		proxy_pass http://192.168.100.1:9201;
		proxy_set_header Origin 'http://dishy.starlink.com';
		proxy_set_header Referrer 'http://dishy.starlink.com/';
	}
}
