# XDG のパスを指定
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh の dotfiles のディレクトリパスを指定
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# その他パスの指定
if [[ -x `which ruby` ]]; then
  PATH="$PATH:"`ruby -rubygems -e "puts Gem.user_dir"`"/bin"
fi
if [[ -x `which go` ]]; then
  mkdir -p $HOME/.go/bin
  PATH="$PATH:$HOME/.go/bin"
  export GOPATH=$HOME/.go
fi
if [[ -x `which javac` ]]; then
  export JAVA_HOME=`readlink -f /usr/bin/javac | sed "s:/bin/javac::"`
fi

# 自作スクリプト類の指定
if [ -d "$HOME/others/scripts" ] ; then
  PATH="$PATH:$HOME/others/scripts"
fi

if [ -f /usr/lib/mozc/mozc_tool ]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi

if [[ -x `which xsel` ]]; then
  alias cb="xsel -b"
fi

if [[ -x `which cvlc` ]]; then
  alias play="cvlc --play-and-exit $* >& /dev/null"
fi

