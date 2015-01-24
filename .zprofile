if [ -d "$HOME/others/scripts" ] ; then
  PATH="$PATH:$HOME/others/scripts"
fi
if [ -d "$HOME/.gem/ruby/2.2.0/bin" ] ; then
  PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin"
fi

mkdir -p /tmp/yantene-temporary
mkdir -p /tmp/yantene-trash

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
