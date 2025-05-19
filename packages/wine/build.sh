PKG_VER="git-master"
PKG_CATEGORY="Wine"
PKG_PRETTY_NAME="Wine ($PKG_VER)"
BLACKLIST_ARCH=aarch64

GIT_URL="https://gitlab.winehq.org/wine/wine.git"
GIT_COMMIT="master"

OVERRIDE_PREFIX="$(realpath $PREFIX/../wine)"

HOST_BUILD_CONFIGURE_ARGS="--enable-win64 --without-x"
HOST_BUILD_FOLDER="$INIT_DIR/workdir/$package/wine-tools"
HOST_BUILD_MAKE="make -j$(nproc) __tooldeps__ nls/all"

CONFIGURE_ARGS="--enable-archs=i386,x86_64 \
  --host=$TOOLCHAIN_TRIPLE \
  --with-wine-tools=$INIT_DIR/workdir/$package/wine-tools \
  --prefix=$OVERRIDE_PREFIX \
  --without-oss \
  --disable-winemenubuilder \
  --disable-tests \
  --disable-win16 \
  --with-x \
  --x-libraries=$PREFIX/lib \
  --x-includes=$PREFIX/include \
  --with-pulse \
  --with-opengl \
  --with-gstreamer \
  --with-gnutls \
  --with-xinput \
  --with-xinput2 \
  --enable-nls"

pre_build() {
  echo "Preparando ambiente para Wine oficial (WineHQ)..."
}

post_build() {
  echo "Wine oficial compilado e instalado em: $OVERRIDE_PREFIX"
}
