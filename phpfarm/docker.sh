#!/bin/bash
# this script builds everything for docker


if [ -z "$PHP_FARM_VERSIONS" ]; then
    echo "PHP versions not set! Aborting setup" >&2
    exit 1
fi

export MAKE_OPTIONS="-j$(nproc)"

# fix freetype for older php https://stackoverflow.com/a/26342869
mkdir /usr/include/freetype2/freetype
ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h

# build and symlink to major.minor
for VERSION in $PHP_FARM_VERSIONS
do
    cd /phpfarm/src # make absolutely sure we're in the correct directory

    echo
    echo ">>> Compiling PHP version $VERSION"
    # download the bzip
    ./phpdl.sh $VERSION /phpfarm/src/bzips

    V=$(echo $VERSION | awk -F. '{print $1"."$2}')

    # compile the PHP version
    ./compile.sh $VERSION || exit 1

    # Remove suffixes like "-pear" otherwise links don't work
    VERSION=$(echo $VERSION| sed -e 's/[^0-9\.]//g')

    ln -s "/phpfarm/inst/php-$VERSION/" "/phpfarm/inst/php-$V"
    ln -s "/phpfarm/inst/bin/php-$VERSION" "/phpfarm/inst/bin/php-$V"
    ln -s "/phpfarm/inst/bin/php-cgi-$VERSION" "/phpfarm/inst/bin/php-cgi-$V"
    ln -s "/phpfarm/inst/bin/phpize-$VERSION" "/phpfarm/inst/bin/phpize-$V"
    ln -s "/phpfarm/inst/bin/php-config-$VERSION" "/phpfarm/inst/bin/php-config-$V"

    # install additional extensions
    export VERSION V MAKE_OPTIONS
    for installer in ./extensions.d/*.sh; do
        bash $installer || exit 1
    done

    # enable apache config - compatible with wheezy and jessie
    a2ensite php-$V.conf
done

# print what have installed
ls -l /phpfarm/inst/bin/

# enable rewriting
a2enmod rewrite

# remove defaults
a2dissite 000-default
echo > /etc/apache2/ports.conf

# clean up sources
rm -rf /phpfarm/src
apt-get clean
rm -rf /var/lib/apt/lists/*
