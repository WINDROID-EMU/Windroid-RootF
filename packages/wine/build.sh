PKG_VER="proton-experimental"
PKG_CATEGORY="Wine"
PKG_PRETTY_NAME="Wine (Proton)"
BLACKLIST_ARCH=aarch64

GIT_URL="https://github.com/ValveSoftware/wine.git"
GIT_COMMIT="proton-9.0"  # ou use uma tag exata como wine-valve-8.0

OVERRIDE_PREFIX="$(realpath $PREFIX/../wine)"

HOST_BUILD_CONFIGURE_ARGS="--enable-win64 --without-x"
HOST_BUILD_FOLDER="$INIT_DIR/workdir/$package/wine-tools"
HOST_BUILD_MAKE="make -j$(nproc) __tooldeps__ nls/all"

CONFIGURE_ARGS="--enable-archs=i386,x86_64 \
  --host=$TOOLCHAIN_TRIPLE \
  --with-wine-tools=$INIT_DIR/workdir/$package/wine-tools \
  --prefix=$OVERRIDE_PREFIX \
  --without-oss \
  --disable-tests \
  --disable-winemenubuilder \
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
  --enable-nls \
  --enable-esync \
  --enable-fsync"

pre_build() {
  echo "Preparando build do Wine Proton (Valve)..."

  # Opcional: aplicar patches Proton aqui se necessário
  # patch -p1 < "$INIT_DIR/patches/proton/wine-proton-fixes.patch"
}

post_build() {
  echo "Wine Proton compilado com sucesso."
}
