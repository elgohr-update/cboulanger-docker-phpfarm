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
    --with-openssl \
    --with-mysql \
    --with-mysqli \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-png-dir=/usr/lib \
    --with-pgsql \
    --with-xsl=/usr \
    --with-freetype-dir=/usr/include/freetype2/ \
"

echo "--- loaded custom/options-7.2.x.sh ----------"
echo $configoptions
echo "---------------------------------------"
