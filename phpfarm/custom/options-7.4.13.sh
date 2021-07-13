# custom options file for phpfarm

configoptions=$(echo "$configoptions" |sed 's/--enable-wddx//')
configoptions=$(echo "$configoptions" |sed 's/--enable-zip//')
configoptions=$(echo "$configoptions" |sed 's/--enable-gd-native-ttf//')
configoptions=$(echo "$configoptions" |sed 's/--with-gd//')
configoptions=$(echo "$configoptions" |sed 's/--with-jpeg-dir=/usr/lib //')
configoptions=$(echo "$configoptions" |sed 's/--with-mcrypt//')
configoptions=$(echo "$configoptions" |sed 's/--with-mysql / /')
configoptions=$(echo "$configoptions" |sed 's/--with-phar//')
configoptions=$(echo "$configoptions" |sed 's/--with-png-dir=/usr/lib//')
configoptions=$(echo "$configoptions" |sed 's/--with-freetype-dir=/usr/include/freetype2\//')

echo "--- loaded custom/options-8.0.0.sh ---"
echo $configoptions
echo "---------------------------------------"
