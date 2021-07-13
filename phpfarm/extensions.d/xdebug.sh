# compile xdebug
if [ "$V" == "8.0" ]; then
    XDBGVERSION="3.0.4"
else
    XDBGVERSION="2.9.1"
fi

echo ">>> Compiling xdebug $XDBGVERSION for PHP $V"

wget https://github.com/xdebug/xdebug/archive/$XDBGVERSION.tar.gz && \
tar -xzvf $XDBGVERSION.tar.gz && \
cd xdebug-$XDBGVERSION && \
phpize-$V && \
./configure --enable-xdebug --with-php-config=/phpfarm/inst/bin/php-config-$V && \
make $MAKE_OPTIONS && \
cp -v modules/xdebug.so /phpfarm/inst/php-$V/lib/ && \
echo "zend_extension_debug = /phpfarm/inst/php-$V/lib/xdebug.so" >> /phpfarm/inst/php-$V/etc/php.ini && \
echo "zend_extension = /phpfarm/inst/php-$V/lib/xdebug.so" >> /phpfarm/inst/php-$V/etc/php.ini && \
cd .. && \
rm -rf xdebug-$XDBGVERSION && \
rm -f $XDBGVERSION.tar.gz && \
cat xdebug.ini >> /phpfarm/inst/php-$V/etc/php.ini
