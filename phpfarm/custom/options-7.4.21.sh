# custom options file for phpfarm

configoptions="\
    --enable-gd-native-ttf \
    --enable-intl \
    --with-ldap \
    --with-ldap-sasl \
    --with-bz2 \
    --with-config-file-scan-dir=/var/www/.php \
    --with-curl \
    --with-kerberos \
    --with-libdir=$LIBPATH \
    --with-mhash \
    --with-openssl \
    --with-mysql \
    --with-mysqli \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-pgsql \
    --with-xsl=/usr \
    --enable-embedded-mysqli"

echo "--- loaded custom/options-7.4.21.sh ---"
echo $configoptions
echo "---------------------------------------"
