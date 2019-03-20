TERMUX_PKG_HOMEPAGE=http://github.com/freeioe/
TERMUX_PKG_DESCRIPTION="A framework for building IOE (Internet Of Everything) gateway device"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=1089
TERMUX_PKG_REVISION=0
TERMUX_PKG_SRCURL=http://172.30.11.139/download/freeioe/1089.tar.gz
TERMUX_PKG_SHA256=5a26e3c74d1dbd2accb3ea4036b5a8a7d79dac13d3ad3131c679957e8530f56f
TERMUX_PKG_DEPENDS="skynet"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_PLATFORM_INDEPENDENT=yes

termux_step_make() {
	echo "fake make"
}

termux_step_make_install() {
	mkdir -p ${TERMUX_PREFIX}/ioe/freeioe
	cp -R ./* ${TERMUX_PREFIX}/ioe/freeioe/
}
