configoptions="\
    --enable-calendar \
    --enable-embedded-mysqli \
    --enable-gd \
    --enable-gd-native-ttf \
    --enable-intl \
    --enable-mbstring \
    --with-bz2 \
    --with-config-file-scan-dir=/var/www/.php \
    --with-curl \
    --with-gettext \
    --with-kerberos \
    --with-ldap \
    --with-ldap-sasl \
    --with-libdir=$LIBPATH \
    --with-mhash \
    --with-mysql \
    --with-mysqli \
    --with-openssl \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-pgsql \
    --with-xsl=/usr \
    --with-zip \
"

echo "--- loaded custom/options-7.4.21.sh ---"
echo $configoptions
echo "---------------------------------------"
