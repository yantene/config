if [ -d "$HOME/.fhs/bin" ] ; then
	PATH="$PATH:$HOME/.fhs/bin"
fi

mkdir -p /tmp/{yantene-desktop,yantene-temporary}

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
