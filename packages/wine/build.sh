#!/bin/bash
# Windroid package build script para WineHQ padrão
# Arquitetura de destino: x86_64

package="wine"
version="10.1-9-esync-xinput"
arch="x86_64"
category="Wine"

GIT_URL="https://gitlab.winehq.org/wine/wine.git"
GIT_TAG="wine-10.1"

package_wine() {
    echo "[wine] Iniciando build do WineHQ $version"

    # Diretórios esperados pelo Windroid
    BUILD_DIR="${BUILD_DIR:-$PWD/build/$package}"
    SRC_DIR="${BUILD_DIR}/src"
    INSTALL_DIR="${BUILD_DIR}/install/files/wine"
    mkdir -p "$SRC_DIR" "$INSTALL_DIR"

    JOBS=$(nproc)
    export TOOLCHAIN_TRIPLE="x86_64-linux-gnu"

    # Clonar WineHQ
    if [ ! -d "$SRC_DIR/wine" ]; then
        echo "[wine] Clonando repositório WineHQ..."
        git clone --depth 1 --branch "$GIT_TAG" "$GIT_URL" "$SRC_DIR/wine"
    fi

    # Criar diretório de build
    BUILD_WINE_DIR="$SRC_DIR/wine_build"
    mkdir -p "$BUILD_WINE_DIR"
    cd "$BUILD_WINE_DIR"

    echo "[wine] Configurando build WineHQ..."
    "$SRC_DIR/wine/configure" \
        --host="$TOOLCHAIN_TRIPLE" \
        --build=x86_64-linux-gnu \
        --prefix=/system/wine \
        --enable-win64 \
        --disable-tests \
        --disable-win16 \
        --with-pulse \
        --with-x \
        --with-opengl \
        --with-gstreamer \
        --with-gnutls \
        --with-xinput \
        --with-xinput2 \
        CFLAGS="-O2" \
        CXXFLAGS="-O2"

    echo "[wine] Compilando WineHQ..."
    make -j"$JOBS"

    echo "[wine] Instalando WineHQ em $INSTALL_DIR"
    make install DESTDIR="$INSTALL_DIR"

    echo "[wine] Corrigindo permissões..."
    chown -R u0_a273:u0_a273 "$INSTALL_DIR"

    echo "[wine] Build finalizado com sucesso."
}
