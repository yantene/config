# override

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tmux="tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias diff='diff -u'

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

if [[ -x `which bundle 2> /dev/null` ]]; then
  alias be='bundle exec'
fi

# shortcut

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi
