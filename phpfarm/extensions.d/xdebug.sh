# compile xdebug
if [ "$V" == "5.1" ] || [ "$V" == "5.2" ] || [ "$V" == "5.3" ]; then
    XDBGVERSION="XDEBUG_2_2_7" # old release for old PHP versions
elif [ "$V" == "5.4" ]; then
    XDBGVERSION="XDEBUG_2_4_1" # old release for old PHP versions
elif [[ $VERSION == *"RC"* ]]; then
    XDBGVERSION="master"       # master for RCs
elif [ "$V" == "5.5" ] || [ "$V" == "5.6" ]; then
    XDBGVERSION="XDEBUG_2_5_5" # 2.5.X release for PHP 5.5 and 5.6
elif [ "$V" == "7.0" ] ; then
    XDBGVERSION="2.7.2"
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
