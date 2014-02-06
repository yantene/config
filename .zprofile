if [ -d "$HOME/.scripts" ] ; then
	PATH="$PATH:$HOME/.scripts"
fi

mkdir -p /tmp/{yantene-desktop,yantene-temporary}

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
