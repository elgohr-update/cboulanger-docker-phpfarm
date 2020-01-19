# we need the correct path, is there a better way to find it?
if [ -d "/lib/i386-linux-gnu" ]; then
    LIBPATH="/lib/i386-linux-gnu/"
else
    LIBPATH="/lib/x86_64-linux-gnu/"

    # fix problem with imap http://bit.ly/1WZcTWD
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a
fi

# Removed IMAP extension because it is incompatible with YAZ
configoptions="$configoptions \
    --enable-gd-native-ttf \
    --enable-intl \
    --with-ldap \
    --with-ldap-sasl \
    --with-bz2 \
    --with-config-file-scan-dir=/var/www/.php \
    --with-curl \
    --with-gd \
    --with-jpeg-dir=/usr/lib \
    --with-kerberos \
    --with-libdir=$LIBPATH \
    --with-mcrypt \
    --with-mhash \
    --with-mysql=/usr \
    --with-mysqli=/usr/bin/mysql_config \
    --with-openssl \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-phar \
    --with-png-dir=/usr/lib \
    --with-pgsql \
    --with-xsl=/usr \
    --with-freetype-dir=/usr/include/freetype2/ \
"

echo "--- loaded custom/options.sh ----------"
echo $configoptions
echo "---------------------------------------"
