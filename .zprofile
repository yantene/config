if [ -d "$HOME/others/scripts" ] ; then
  PATH="$PATH:$HOME/others/scripts"
fi
if [ -d "$HOME/.gem/ruby" ] ; then
  PATH="$PATH:"`ls -d ~/.gem/ruby/* | sort | tail -n 1`"/bin"
fi

mkdir -p /tmp/yantene-temporary
mkdir -p /tmp/yantene-trash

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
