#!/bin/bash
sudo apt install ubuntu-dev-tools
reverse-depends -b scons
/sbin/ldconfig -p|  grep stdc++||  true
readelf -Ws /lib/x86_64-linux-gnu/libcrypto.so.1.0.0|  grep '^\([[:space:]]\+[^[:space:]]\+\)\{6\}[[:space:]]\+[[:digit:]]\+'|  grep EVP_cast5_cbc
nm -C -D /lib/x86_64-linux-gnu/libcrypto.so.1.0.0|  grep EVP_cast5_cbc
nm -C -D ./x86Linux/misc-OLD/lib/libcrypto.so.6|  grep EVP_cast5_cbc
nm -C -D ./x86Linux/openssl-0.9.8-OLD/lib/libcrypto.so.0.9.8|  grep EVP_cast5_cbc
nm --demangle --dynamic --defined-only --extern-only /lib/x86_64-linux-gnu/libcrypto.so.1.0.0|  grep EVP_cast5_cbc
objdump -x /lib/x86_64-linux-gnu/libcrypto.so.1.0.0|  grep RPATH
readelf -d /lib/x86_64-linux-gnu/libcrypto.so.1.0.0|  head -20
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:3rdparties/x86Linux/misc-OLD/lib
ld -L3rdparties/x86Linux/misc-OLD/lib -lssl --verbose
ldd -u -r target/lib/x86Linux/debug64/shared/libmain_library.so
ldd -u -r target/bin/x86Linux/run_app
readelf -d target/bin/x86Linux/run_app|  head -20
readelf --debug-dump target/bin/x86Linux/run_app|  less
readelf --debug-dump=loc target/bin/x86Linux/run_app|  less
ldd --version
openssl version -a
yum whatprovides */libcrypto.so.10
ldconfig -p|  grep libssl
apt-cache policy libcppunit-dev
ecit 0
