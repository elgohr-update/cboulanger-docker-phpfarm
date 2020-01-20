echo "--- installing YAZ for php $V ---------------------"

INST_DIR=/phpfarm/inst/php-$V
PHP_CMD=$INST_DIR/bin/php
PEAR_CMD=$INST_DIR/bin/pear
PECL_CMD=$INST_DIR/bin/pecl

PHPYAZVERSION=1.2.3
MAKE_OPTIONS=""

wget https://pecl.php.net/get/yaz-$PHPYAZVERSION.tgz && \
tar -xzvf yaz-$PHPYAZVERSION.tgz && \
cd yaz-$PHPYAZVERSION && \
/phpfarm/inst/bin/phpize-$V && \
./configure --with-php-config=/phpfarm/inst/bin/php-config-$V && \
make $MAKE_OPTIONS && \
cp -v modules/yaz.so /phpfarm/inst/php-$V/lib/ && \
echo "extension=/phpfarm/inst/php-$V/lib/yaz.so" >> /phpfarm/inst/php-$V/etc/php.ini && \
cd .. && \
rm -rf yaz-$PHPYAZVERSION && \
rm -f yaz-$PHPYAZVERSION.tgz || exit 1

# Check if YAZ installation has worked
if $PHP_CMD -i | grep yaz --quiet && echo '<?php exit(function_exists("yaz_connect")?0:1);' | $PHP_CMD ; then echo "YAZ is installed"; else echo "YAZ installation failed"; exit 1; fi;

# install needed PEAR_CMD libraries; not compatible with php 7.4
if ! [ "$V" == "7.4" ] ; then
  $PEAR_CMD install Structures_LinkedList-0.2.2 && \
  $PEAR_CMD install File_MARC || exit 1
fi
