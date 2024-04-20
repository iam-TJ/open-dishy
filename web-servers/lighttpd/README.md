# lighttpd with reverse proxy

Version 1.4.* causes the Starlink User Terminal to return HTTP 500 Server Error due to including X-Forwarded* headers in the proxied request. There is no way to disable, or override, those headers except using some external process such as a netfilter_queue process that modifies the payload.
