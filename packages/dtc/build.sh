TERMUX_PKG_HOMEPAGE=https://git.kernel.org/pub/scm/utils/dtc/dtc
TERMUX_PKG_DESCRIPTION="Device Tree Compiler"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=1.5.0
TERMUX_PKG_SRCURL=https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/dtc-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3416f10ca69b0b911f027a9cb96471485dd8705705fc4813283f963299eaae0a
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"
TERMUX_PKG_BUILD_IN_SRC=true
