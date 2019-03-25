termux_step_replace_data_folder() {
	cd "$TERMUX_PKG_SRCDIR"
	local DEBUG_PATCHES=""
	shopt -s nullglob
	sed -i 's/data\/data\/com.termux/data\/data\/com.thingsroot.freeioe/g' `grep 'data/data/com.termux' -rl ./`
	shopt -u nullglob
}
