#!/bin/bash
set -e

package="wine"
INSTALL_DIR="${INSTALL_DIR:-$PWD/output/pkg/$package}"
INIT_DIR="${INIT_DIR:-$PWD}"
TOOLCHAIN_TRIPLE="${TOOLCHAIN_TRIPLE:-x86_64-linux-gnu}" # alvo x86_64 Linux
PREFIX="$INSTALL_DIR/files/wine"
JOBS=$(nproc)

GIT_URL="https://gitlab.winehq.org/wine/wine.git"
GIT_BRANCH="staging"
GIT_COMMIT=""

pre_build() {
    echo "[wine] Clonando WineHQ..."
    if [ ! -d wine_src ]; then
        git clone --depth 1 --branch $GIT_BRANCH $GIT_URL wine_src
    else
        cd wine_src && git fetch && git checkout $GIT_BRANCH && git pull && cd ..
    fi
}

build_wine() {
    mkdir -p wine_build
    cd wine_build

    echo "[wine] Configurando WineHQ para Windroid x86_64..."
    ../wine_src/configure \
        --host=$TOOLCHAIN_TRIPLE \
        --build=x86_64-linux-gnu \
        --prefix=$PREFIX \
        --enable-win64 \
        --disable-tests \
        --disable-win16 \
        --enable-esync \
        --enable-fsync \
        --with-pulse \
        --with-x \
        --with-opengl \
        --with-gstreamer \
        --with-gnutls \
        --with-xinput \
        --with-xinput2 \
        CFLAGS="-O2" \
        CXXFLAGS="-O2"

    echo "[wine] Compilando WineHQ x86_64..."
    make -j$JOBS
    make install

    cd ..
}

post_build() {
    echo "[wine] Corrigindo permissões para usuário u0_a273..."
    chown -R u0_a273:u0_a273 $PREFIX

    echo "[wine] Empacotando Wine em .rat..."

    cd $INSTALL_DIR/files

    zip -r ../winehq-x86_64-latest.rat wine

    echo "[wine] Build e empacotamento finalizados com sucesso."
}

main() {
    pre_build
    build_wine
    post_build
}

main "$@"
