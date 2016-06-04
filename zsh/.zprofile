# - login shell

# xinitrc
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

# pathes
if [[ -x `which ruby` ]]; then
  export PATH="$PATH:"`ruby -rubygems -e "puts Gem.user_dir"`"/bin"
fi

if [[ -x `which go` ]]; then
  mkdir -p $HOME/.go/bin
  export PATH="$PATH:$HOME/.go/bin"
  export GOPATH=$HOME/.go
fi

if [[ -x `which R` ]]; then
  export R_ENVIRON_USER="${XDG_CONFIG_HOME}/R/Renviron"
fi

if [[ -x `which javac` ]]; then
  export JAVA_HOME=`readlink -f /usr/bin/javac | sed "s:/bin/javac::"`
fi

if [[ -d $HOME/.anyenv ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`; do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# my scripts and commands
if [[ -d "$HOME/others/scripts" ]]; then
  export PATH="$PATH:$HOME/others/scripts"
fi

if [[ -f "$HOME/dev/twitter/mikutter/mikutter.rb" ]]; then
  alias mikutter="ruby $HOME/dev/twitter/mikutter/mikutter.rb"
fi

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi

if [[ -x `which xsel` ]]; then
  alias cb="xsel -b"
fi

if [[ -x `which cvlc` ]]; then
  alias play="cvlc --play-and-exit $* >& /dev/null"
fi

# X の立ち上げ
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx $XINITRC
