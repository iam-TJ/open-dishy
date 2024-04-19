server {
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name dishy.starlink.com;
	root /var/www/dishy.starlink.com/;
	index index.html;
	add_header Access-Control-Allow-Origin http://router.starlink.com:9001;
	add_header Vary Origin;
}
server {
	listen 9201 default_server;
	listen [::]:9201 default_server;
	server_name dishy.starlink.com;
	root /var/www/dishy.starlink.com/;
	location / {
		proxy_pass http://192.168.100.1:9201;
		proxy_set_header Origin 'http://dishy.starlink.com';
		proxy_set_header Referrer 'http://dishy.starlink.com/';
	}
}
