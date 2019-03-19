TERMUX_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
TERMUX_PKG_DESCRIPTION="Alpine Linux package management tools"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=2.10.3
TERMUX_PKG_SHA256=f91861ed981d0a2912d5d860a33795ec40d16021ab03f6561a3849b9c0bcf77e
TERMUX_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_DEPENDS="openssl"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_MAKE_ARGS="LUAAPK="
TERMUX_PKG_CONFFILES="etc/apk/repositories"

termux_step_post_make_install() {
    mkdir -p $TERMUX_PREFIX/etc/apk/
    echo $TERMUX_ARCH > $TERMUX_PREFIX/etc/apk/arch

    echo "http://termux.freeioe.org/apk/main" > $TERMUX_PREFIX/etc/apk/repositories
}

termux_step_post_massage() {
    mkdir -p "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/apk/keys"
    mkdir -p "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/apk/protected_paths.d"
    mkdir -p "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib/apk/db/"
    mkdir -p "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/cache/apk"

    ln -sfr \
	"$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/cache/apk" \
	"$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/apk/cache"
}

termux_step_create_debscripts() {
    {
	echo "#!$TERMUX_PREFIX/bin/sh"
	echo "touch $TERMUX_PREFIX/etc/apk/world"
    } > ./postinst
    chmod 755 postinst
}
