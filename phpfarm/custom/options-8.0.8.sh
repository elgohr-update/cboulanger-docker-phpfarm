configoptions="\
    --enable-bcmath \
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
    --with-zlib \
"

echo "--- loaded custom/options-8.0.0.sh ---"
echo $configoptions
echo "---------------------------------------"
