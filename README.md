phpfarm for docker
==================

This is a fork of https://github.com/splitbrain/docker-phpfarm  adapted
for the build of https://github.com/cboulanger/bibliograph. It only
builds > Versions 7.x. and adds PEAR and the PHP-YAZ extension.

The build file creates a [phpfarm](https://github.com/fpoirotte/phpfarm)
setup. The resulting docker image will run Apache on
different ports with different PHP versions accessed via
FCGI. The different PHP CLI binaries are accessible as well.

Port | PHP Version | Binary
-----|-------------|-----------------------
8071 | 7.1.25      | php-7.1
8072 | 7.2.13      | php-7.2
8073 | 7.3.0       | php-7.3 
8080 | 8.0.0       | php-8.0 


Building the image
------------------

After cloning the git repository, simply run the following command:

    docker build -t cboulanger/docker-phpfarm:latest .
   
This will setup a Debian base system, install phpfarm, download and
compile the different PHP versions, extensions and setup Apache. 
This will take a while. See the next section for a faster alternative.

Downloading the image
---------------------

Simply downloading the ready made image from Docker Hub
is probably the fastest way. Just run one of these:

    docker pull cboulanger/docker-phpfarm


Running the container
---------------------

The following will run the container and map all ports to their respective
ports on the local machine. The current working directory (`$PWD`)
will be used as the document root for the Apache server and the server
itself will run with the same user id as your current user (`$UID`).

    docker run --rm -t -i -e APACHE_UID=$UID -v $PWD:/var/www:rw \
      -p 8070:8070 -p 8071:8071 -p 8072:8072 -p 8073:8073 -p 8074:8074 -p 8080:8080 \
      cboulanger/docker-phpfarm

You can access the Apache/PHP via localhost. Eg. `http://localhost:8073`
for the PHP 7.3 version. 

Above command will also remove the container again when the
process is aborted with CTRL-C (thanks to the `--rm` option).
While running, the Apache and PHP error log is shown on STDOUT.

An alternative is to not isolate the container's network at all
from the local machine. This makes it possible for the container to
access all the services you're running locally, eg. a database. It
will also automatically make all the exposed ports available locally
(but you can't remap them, so they need to be available, eg. not
used by anything else). To do so use the `--network host` switch:

    docker run --rm -t -i -e APACHE_UID=$UID -v $PWD:/var/www:rw \
       --network host cboulanger/docker-phpfarm

You can also access the PHP binaries within the container directly.
Refer to the table above for the correct names. The following
command will run PHP 5.3 on your current working directory.

    docker run --rm -t -i -v $PWD:/var/www:rw cboulanger/docker-phpfarm php-7.3 --version

Alternatively you can also run an interactive shell inside
the container with your current working directory mounted.

    docker run --rm -t -i -v $PWD:/var/www:rw cboulanger/docker-phpfarm /bin/bash

Loading custom php.ini settings
-------------------------------

All PHP versions are compiled with the config-file-scan-dir pointing
to ``/var/www/.php/``. When mounting your own project as a volume to
``/var/www/`` you can easily place custom ``.ini`` files in your project's
``.php/`` directory and they should be automatically be picked up by PHP.

XDebug debugging, profiling and tracing
---------------------------------------

XDebug is enabled in all of the PHP versions. It is preconfigured for immeadiate use.

Profiling and tracing can be triggered through the `XDEBUG_PROFILE`
and `XDEBUG_TRACE` Post/Get/Ccookie setting - no special trigger
value has been set, so any value will trigger. Output files are placed
into the volume you mounted to `/var/www/` with an `xdebug.` prefix.

Remote debugging is triggered through the `XDEBUG_SESSION` cookie.
It uses the `remote_connect_back` setting, so it expects a debugger
on port `9000` (the default) on the IP that requested the page.

Of course you can always reconfigure xdebug through a custom ini file as described above.

Supported PHP extensions
------------------------

Here's a list of the extensions available in each of the PHP
versions available in the Jessie image. It should cover all the
default extensions plus a few popular ones and xdebug for debugging.

Extension    |    ---  | PHP 7.1 | PHP 7.2 | PHP 7.3 | PHP 8.0
------------:|:-------:|:-------:|:-------:|:-------:|:-------:
bcmath       |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
bz2          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
calendar     |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
cgi-fcgi     |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
ctype        |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
curl         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
date         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
dom          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
ereg         |         |         |         |         |
exif         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
fileinfo     |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
filter       |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
ftp          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
gd           |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
gettext      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
hash         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
iconv        |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
imap         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
intl         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
json         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
ldap         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
libxml       |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
mbstring     |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
mcrypt       |    ✓    |    ✓    |         |         |
mhash        |         |         |         |         |
mysql        |         |         |         |         |
mysqli       |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
mysqlnd      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
openssl      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pcntl        |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pcre         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pdo          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pdo_mysql    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pdo_pgsql    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pdo_sqlite   |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
pgsql        |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
phar         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
posix        |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
reflection   |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
session      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
simplexml    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
soap         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
sockets      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
spl          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
sqlite       |         |         |         |         |
sqlite3      |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
standard     |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
tokenizer    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
wddx         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
xdebug       |    ✓    |    ✓    |    ✓    |    ✓    |
xml          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
xmlreader    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
xmlwriter    |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
xsl          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
yaz          |    ✓    |    ✓    |    ✓    |    ✓    |    ?
zip          |    ✓    |    ✓    |    ✓    |    ✓    |    ✓
zlib         |    ✓    |    ✓    |    ✓    |    ✓    |    ✓

