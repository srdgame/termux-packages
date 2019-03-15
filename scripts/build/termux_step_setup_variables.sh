termux_step_setup_variables() {
	# shellcheck source=scripts/properties.sh
	. "$TERMUX_SCRIPTDIR/scripts/properties.sh"
	: "${TERMUX_MAKE_PROCESSES:="$(nproc)"}"
	: "${TERMUX_TOPDIR:="$HOME/.termux-build"}"
	: "${TERMUX_ARCH:="aarch64"}" # arm, aarch64, i686 or x86_64.
	: "${TERMUX_PREFIX:="/data/data/com.thingsroot.freeioe/files/usr"}"
	: "${TERMUX_ANDROID_HOME:="/data/data/com.thingsroot.freeioe/files/home"}"
	: "${TERMUX_DEBUG:=""}"
	: "${TERMUX_PKG_API_LEVEL:="21"}"
	: "${TERMUX_NO_CLEAN:="false"}"
	: "${TERMUX_QUIET_BUILD:="false"}"
	: "${TERMUX_DEBDIR:="${TERMUX_SCRIPTDIR}/debs"}"
	: "${TERMUX_SKIP_DEPCHECK:="false"}"
	: "${TERMUX_INSTALL_DEPS:="false"}"
	: "${TERMUX_REPO_SIGNING_KEYS:="packages/apt/trusted.gpg packages/termux-keyring/grimler.gpg packages/termux-keyring/xeffyr.gpg"}"
	: "${TERMUX_PKG_MAINTAINER:="Fredrik Fornwall @fornwall"}"
	: "${TERMUX_PACKAGES_DIRECTORIES:="packages"}"

	if [ -z ${TERMUX_REPO_URL+x} ]; then
		TERMUX_REPO_URL=(https://termux.net)
		# TERMUX_REPO_URL=(https://termux.net https://grimler.se https://dl.bintray.com/xeffyr/unstable-packages)
	fi
	if [ -z ${TERMUX_REPO_DISTRIBUTION+x} ]; then
		TERMUX_REPO_DISTRIBUTION=(stable)
		# TERMUX_REPO_DISTRIBUTION=(stable root unstable)
	fi
	if [ -z ${TERMUX_REPO_COMPONENT+x} ]; then
		TERMUX_REPO_COMPONENT=(main)
		# TERMUX_REPO_COMPONENT=(main stable main)
	fi

	if [ "x86_64" = "$TERMUX_ARCH" ] || [ "aarch64" = "$TERMUX_ARCH" ]; then
		TERMUX_ARCH_BITS=64
	else
		TERMUX_ARCH_BITS=32
	fi

	TERMUX_HOST_PLATFORM="${TERMUX_ARCH}-linux-android"
	if [ "$TERMUX_ARCH" = "arm" ]; then TERMUX_HOST_PLATFORM="${TERMUX_HOST_PLATFORM}eabi"; fi

	if [ ! -d "$NDK" ]; then
		termux_error_exit 'NDK not pointing at a directory!'
	fi
	if ! grep -s -q "Pkg.Revision = $TERMUX_NDK_VERSION_NUM" "$NDK/source.properties"; then
		termux_error_exit "Wrong NDK version - we need $TERMUX_NDK_VERSION"
	fi

	# The build tuple that may be given to --build configure flag:
	TERMUX_BUILD_TUPLE=$(sh "$TERMUX_SCRIPTDIR/scripts/config.guess")

	# We do not put all of build-tools/$TERMUX_ANDROID_BUILD_TOOLS_VERSION/ into PATH
	# to avoid stuff like arm-linux-androideabi-ld there to conflict with ones from
	# the standalone toolchain.
	TERMUX_D8=$ANDROID_HOME/build-tools/$TERMUX_ANDROID_BUILD_TOOLS_VERSION/d8

	TERMUX_COMMON_CACHEDIR="$TERMUX_TOPDIR/_cache"
	TERMUX_ELF_CLEANER=$TERMUX_COMMON_CACHEDIR/termux-elf-cleaner

	export prefix=${TERMUX_PREFIX}
	export PREFIX=${TERMUX_PREFIX}

	TERMUX_PKG_BUILDDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/build
	TERMUX_PKG_CACHEDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/cache
	TERMUX_PKG_MASSAGEDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/massage
	TERMUX_PKG_PACKAGEDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/package
	TERMUX_PKG_SRCDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/src
	TERMUX_PKG_SHA256=""
	TERMUX_PKG_TMPDIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/tmp
	TERMUX_PKG_HOSTBUILD_DIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/host-build
	TERMUX_PKG_PLATFORM_INDEPENDENT=""
	TERMUX_PKG_NO_DEVELSPLIT=""
	TERMUX_PKG_REVISION="0" # http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS=""
	TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS=""
	TERMUX_PKG_EXTRA_MAKE_ARGS=""
	TERMUX_PKG_BUILD_IN_SRC=""
	TERMUX_PKG_RM_AFTER_INSTALL=""
	TERMUX_PKG_BREAKS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	TERMUX_PKG_DEPENDS=""
	TERMUX_PKG_BUILD_DEPENDS=""
	TERMUX_PKG_HOMEPAGE=""
	TERMUX_PKG_DESCRIPTION="FIXME:Add description"
	TERMUX_PKG_KEEP_STATIC_LIBRARIES="false"
	TERMUX_PKG_ESSENTIAL=""
	TERMUX_PKG_CONFLICTS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts
	TERMUX_PKG_RECOMMENDS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	TERMUX_PKG_SUGGESTS=""
	TERMUX_PKG_REPLACES=""
	TERMUX_PKG_PROVIDES="" #https://www.debian.org/doc/debian-policy/#virtual-packages-provides
	TERMUX_PKG_CONFFILES=""
	TERMUX_PKG_INCLUDE_IN_DEVPACKAGE=""
	TERMUX_PKG_DEVPACKAGE_DEPENDS=""
	# Set if a host build should be done in TERMUX_PKG_HOSTBUILD_DIR:
	TERMUX_PKG_HOSTBUILD=""
	TERMUX_PKG_FORCE_CMAKE=no # if the package has autotools as well as cmake, then set this to prefer cmake
	TERMUX_CMAKE_BUILD=Ninja # Which cmake generator to use
	TERMUX_PKG_HAS_DEBUG=yes # set to no if debug build doesn't exist or doesn't work, for example for python based packages

	unset CFLAGS CPPFLAGS LDFLAGS CXXFLAGS
}
