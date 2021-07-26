#!/bin/bash

set -e

VERSION=$(echo $1 | sed -e "s/-pear//")
DIR=$2
OUT="$DIR/php-$VERSION.tar.bz2"
EXT="$DIR/../php-$VERSION"

# print a message to STDERR and die
die() {
    echo $1 >&2
    exit 1
}

# check parameters
[ -z "$VERSION" ] && die "no version given"
[ -z "$DIR" ] && die "no output directory given"

# create output directory
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR" || die "failed to create output directory"
fi
if [ ! -d "$EXT" ]; then
    mkdir -p "$EXT" || die "failed to create extraction directory"
fi

# construct URL
URL="https://www.php.net/distributions/php-$VERSION.tar.bz2"

# do nothing if file exists
[ -f "$OUT" ] && exit 0

# download
echo "Downloading $URL -> $OUT..."
curl -L --silent --show-error --fail -o "$OUT" "$URL" || die "failed to download"
echo "Extracting to $EXT ..."
tar -xvf "$OUT" -C "$EXT" --strip-components 1
