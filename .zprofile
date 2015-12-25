if [ -d "$HOME/others/scripts" ] ; then
  PATH="$PATH:$HOME/others/scripts"
fi
if [ `which ruby` ] ; then
  PATH="$PATH:"`ruby -rubygems -e "puts Gem.user_dir"`"/bin"
fi
if [ `which go` ] ; then
  mkdir -p $HOME/.go/bin
  PATH="$PATH:$HOME/.go/bin"
  export GOPATH=$HOME/.go
fi
if [ `which javac` ] ; then
  export JAVA_HOME=`readlink -f /usr/bin/javac | sed "s:/bin/javac::"`
fi
if [ `which xsel` ] ; then
  alias cb="xsel -b"
fi

mkdir -p /tmp/yantene-temporary
mkdir -p /tmp/yantene-trash

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
