configoptions="$configoptions \
    --enable-gd-native-ttf \
    --enable-intl \
    --with-bz2 \
    --with-config-file-scan-dir=/var/www/.php \
    --with-curl \
    --with-freetype-dir=/usr/include/freetype2/ \
    --with-gd \
    --with-jpeg-dir=/usr/lib \
    --with-kerberos \
    --with-ldap \
    --with-ldap-sasl \
    --with-libdir=$LIBPATH \
    --with-mcrypt \
    --with-mhash \
    --with-mysql \
    --with-mysqli \
    --with-openssl \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-pgsql \
    --with-png-dir=/usr/lib \
    --with-xsl=/usr \
"

echo "--- loaded custom/options-7.2.x.sh ----------"
echo $configoptions
echo "---------------------------------------"
