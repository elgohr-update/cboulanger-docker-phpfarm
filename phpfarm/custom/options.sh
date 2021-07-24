# we need the correct path, is there a better way to find it?
if [ -d "/lib/i386-linux-gnu" ]; then
    LIBPATH="/lib/i386-linux-gnu/"
else
    LIBPATH="/lib/x86_64-linux-gnu/"

    # fix problem with imap http://bit.ly/1WZcTWD
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a
fi
