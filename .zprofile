if [ -d "$HOME/.fhs/bin" ] ; then
	PATH="$PATH:$HOME/.fhs/bin"
fi
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
