PKG_VER=0.9.11
SRC_URL=https://xorg.freedesktop.org/releases/individual/lib/libXrender-$PKG_VER.tar.xz
CONFIGURE_ARGS="--host=$TOOLCHAIN_TRIPLE host_alias=$TOOLCHAIN_TRIPLE --enable-malloc0returnsnull"
