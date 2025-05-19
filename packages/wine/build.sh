#!/bin/bash

# Wine Proton compilável e empacotável para Windroid RootFS como .rat

PKG_VER="proton-9.0"
PKG_CATEGORY="Wine"
PKG_PRETTY_NAME="Wine Proton (Valve)"
BLACKLIST_ARCH=aarch64

GIT_URL="https://github.com/ValveSoftware/wine.git"
GIT_COMMIT="proton-9.0"

OVERRIDE_PREFIX="$INSTALL_DIR/files/wine"

HOST_BUILD_FOLDER="$INIT_DIR/workdir/$package/wine-tools"
HOST_BUILD_CONFIGURE_ARGS="--enable-win64 --without-x"
HOST_BUILD_MAKE="make -j$(nproc) __tooldeps__ nls/all"

CONFIGURE_ARGS="--enable-archs=i386,x86_64 \
  --host=$TOOLCHAIN_TRIPLE \
  --with-wine-tools=$INIT_DIR/workdir/$package/wine-tools \
  --prefix=$OVERRIDE_PREFIX \
  --disable-tests \
  --disable-winemenubuilder \
  --disable-win16 \
  --without-oss \
  --with-x \
  --x-libraries=$PREFIX/lib \
  --x-includes=$PREFIX/include \
  --with-pulse \
  --with-opengl \
  --with-gstreamer \
  --with-gnutls \
  --enable-esync \
  --enable-fsync \
  --with-xinput \
  --with-xinput2 \
  --enable-nls"

pre_build() {
  echo "Iniciando build do Wine Proton para Windroid RootFS (.rat)..."
}

post_build() {
  echo "Wine Proton instalado corretamente em: $OVERRIDE_PREFIX"
}
