TERMUX_PKG_HOMEPAGE=http://github.com/freeioe/skynet
TERMUX_PKG_DESCRIPTION="A lightweight online game framework"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_REVISION=0
TERMUX_PKG_DEPENDS="libcurl, openssl, zip, unzip"
TERMUX_PKG_BUILD_IN_SRC=yes

# Build configuration.

termux_step_extract_package() {
	local CHECKED_OUT_FOLDER=$TERMUX_PKG_CACHEDIR/skynet-$TERMUX_PKG_VERSION
	if [ ! -d $CHECKED_OUT_FOLDER ]; then
		local TMP_CHECKOUT=$TERMUX_PKG_TMPDIR/tmp-checkout
		rm -Rf $TMP_CHECKOUT
		mkdir -p $TMP_CHECKOUT

		git clone --depth 1 \
			https://github.com/srdgame/skynet.git \
			$TMP_CHECKOUT
		cd $TMP_CHECKOUT
		git submodule update --init --recursive # --depth 1
		mv $TMP_CHECKOUT $CHECKED_OUT_FOLDER
	fi

	mkdir $TERMUX_PKG_SRCDIR
	cd $TERMUX_PKG_SRCDIR
	cp -Rf $CHECKED_OUT_FOLDER/* .
}

termux_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" make -j $TERMUX_MAKE_PROCESSES android
}

termux_step_make_install() {
	mkdir -p ${TERMUX_PREFIX}/ioe/skynet/
	cp -r lualib ${TERMUX_PREFIX}/ioe/skynet/lualib
	cp -r luaclib ${TERMUX_PREFIX}/ioe/skynet/luaclib
	cp -r service ${TERMUX_PREFIX}/ioe/skynet/service
	cp -r cservice ${TERMUX_PREFIX}/ioe/skynet/cservice
	cp README.md ${TERMUX_PREFIX}/ioe/skynet/
	cp HISTORY.md ${TERMUX_PREFIX}/ioe/skynet/
	cp LICENSE ${TERMUX_PREFIX}/ioe/skynet/
	cp skynet ${TERMUX_PREFIX}/ioe/skynet/

	echo ${TERMUX_PKG_VERSION} > ${TERMUX_PREFIX}/ioe/skynet/version
	echo ${TERMUX_PKG_REVISION} >> ${TERMUX_PREFIX}/ioe/skynet/version

	cd ${TERMUX_PREFIX}/ioe/skynet/
	ln -s ../freeioe ./ioe
	ln -s /var/log ./logs
	cd -
}
