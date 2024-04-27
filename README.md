# DIY dishy.starlink.com

Reimplement the web interface and functionality removed from Starlink User Terminals in early 2024.

## Overview

Use a stand-alone local web-server to provide the web-based "dishy" interface; only making generic Remote Procedure Calls (gRPC) to the User Terminal (U.T.). This project contains the files to be served and specimen configurations for several popular web servers. In the future it may add modified, improved, or themed alternatives. 

This guide is tailored towards GNU/Linux and BSD Unix based operating systems. Contributions with instructions for other operating systems, web-servers, and DNS servers are welcome (especially for openwrt), as are modifications and clean-ups of the code (can we lose the apparently unrequired CSS classes in almost every `DIV` element of `index.html` ? )

## Installation

### 0. Prerequisites

  1. web-server host must have direct route to 192.168.100.1 (the U.T.)
  2. firewall must allow connections to/from TCP port 9201 on the U.T.

### 1. Web server

Included are simple configuration files for popular web servers. These should be installed and enabled according to the web-server's documentation. Server-specific instructions may be found in README.md files in the sub-directories here. Currently included: nginx apache2 lighttpd (fails - see ./web-servers/lighttpd/README.md)

The files in this repository under ./dishy.starlink.com/ should be copied into the web-server's usual serving base. On Debian based operating systems this would mean copying the directory and all its contents to `/var/www/` using `cp -a dishy.starlink.com /var/www/` - the configurations provided here all use `/var/www/dishy.starlink.com/` as the 'root' directory of the virtual server and set the default index to be `index.html`.

In most cases the web-server user account must be given access to the files: `chown -R www-data:www-data /var/www/dishy.starlink.com`

### 2. Hostnames

To avoid hard-coded IP addresses in the Javascript code as was the case with the Starlink implementation we need to locally map:

  router.starlink.com (the Wifi router - optional)
  dishy.starlink.com  (the web server)

In most cases router.starlink.com should point to 192.168.1.1

Because local networks have a myriad of ways to configure local DNS names it is beyond the scope of this document to provide specific instructions. A simple configuration on the local host only would be to add these entries to `/etc/hosts` (on GNU/Linux and MacOS). If the web server is on 10.0.0.1 we might have:
```
192.168.1.1 router.starlink.com
10.0.0.1 dishy.starlink.com
```

### 3. Usage

On a client that can correctly resolve the hostname dishy.starlink.com to the IP address of the web-server simply visit:

http://dishy.starlink.com

Currently although the STATISTICS link is greyed out (see issue #1) visting the URL directly now works via web-server URL rewriting:

http://dishy.starlink.com/statistics

The NETWORK and SPEED (test) functionality depends on the Starlink Wifi router being reachable from the browser.

## How it Works

Originally the User Terminal (a.k.a. dishy.starlink.com on 192.168.100.1) served a large HTML file and associated fonts, images, and Javascript. In early 2024 the content of the HTML file was mostly removed, leaving only a Starlink logo. Investigations showed that the supporting Javascript, fonts, and images were still available and/or being served. The original HTML was recovered from a saved web page from 2023. The page included embedded fonts and images which have been extracted. All are stored in the ./assets/ directory.

The HTML and Javascript was originally minified to save space. That has been reversed so the code can be read and edited easily - these files have "mod" in their names and are served by default to aid investigations in the browser developer tools.

There are two Javascript files: api.bundle.web.js and app.bundle.web.js. This repository contains two copies of each file; the saved 2023 and latest 2024 versions. It turns out app.bundle.web.js hasn't changed; api.bundle.web.js doubled in size but - strangely - when deminified (using Firefox developer tools to Pretty-print it) the files are almost identical in both size and content - excepting different variable names due to minification. So far investigations into the doubling of size have failed to determine the cause.

Originally app.bundle.web.js had hard-coded IP addresses; these have been replaced with hostnames (192.168.100.1 -> dishy.starlink.com, 192.168.1.1 -> router.starlink.com) so no code edits are required to make them work - provided those hostnames are defined and will resolve locally.

To enable easy testing of different combinations of the Javascript files without editing the code the original names are now symbolic links that point to the particular version of the files.

The web-server has to proxy requests to 192.168.100.1 TCP port 9201 (the User Terminal) to allow generic Remote Procedure Call (gRPC) queries from the browser to be accepted by the U.T. This is due to how the HTML rewrites its own location to http://dishy.starlink.com/ and the modified Javascript using hostname not IP address combined with the U.T. refusing requests if the Origin and Referer are not dishy.starlink.com (it thinks that is its name but that has to be hijacked to make the separate server work).

