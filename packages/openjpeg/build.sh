TERMUX_PKG_HOMEPAGE=http://www.openjpeg.org/
TERMUX_PKG_DESCRIPTION="JPEG 2000 image compression library"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_VERSION=2.3.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_SHA256=3dc787c1bb6023ba846c2a0d9b1f6e179f1cd255172bde9eb75b01f1e6c7d71a
TERMUX_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_STATIC_LIBS=OFF"
# for fast building packages that depend on openjpeg with cmake
TERMUX_PKG_DEVPACKAGE_DEPENDS="openjpeg-tools"

termux_step_pre_configure() {
	# Force symlinks to be overwritten:
	rm -Rf $TERMUX_PREFIX/lib/libopenjp2.so*
}
