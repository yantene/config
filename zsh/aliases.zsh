# override

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tmux="tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if [[ -x `which git 2> /dev/null` ]]; then
  alias diff='git diff --no-index'
else
  alias diff='diff -u'
fi

if [[ -x `which nvim 2> /dev/null` ]]; then
  alias vim='nvim'
else
  alias nvim='vim'
fi

# shorten

alias la='ls -lah'
alias lat='ls -lahtr'

if [[ -x `which systemctl 2> /dev/null` ]]; then
  alias sc='systemctl'
  compdef sc='systemctl'
fi

# shortcut

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi
