termux_step_replace_data_folder() {
	if grep -s -q "data/data/com.termux" "$TERMUX_PKG_SRCDIR"; then
		sed -i "s/data\/data\/com.termux/data\/data\/com.thingsroot.freeioe/g" `grep "data/data/com.termux" -rl $TERMUX_PKG_SRCDIR`
	fi
}
