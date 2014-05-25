if [ -d "$HOME/.scripts" ] ; then
  PATH="$PATH:$HOME/.scripts"
fi
if [ -d "$HOME/.gem/ruby/2.1.0/bin" ] ; then
  PATH="$PATH:$HOME/.gem/ruby/2.1.0/bin"
fi

mkdir -p /tmp/yantene-temporary
mkdir -p /tmp/yantene-trash

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
