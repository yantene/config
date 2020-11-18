# override

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tmux="tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias diff='diff -u'
alias qssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias each="xargs -L1 $@"
alias resetbg='tmux select-pane -P bg=default'

if [[ -x `which nvim 2> /dev/null` ]]; then
  alias vim='nvim'
else
  alias nvim='vim'
fi

# shorten

if [[ -x `which exa 2> /dev/null` ]]; then
  alias la='exa -lgFiaa --git'
else
  alias la='ls -lah'
fi

if [[ -x `which systemctl 2> /dev/null` ]]; then
  alias sc='systemctl'
  compdef sc='systemctl'
fi

if [[ -x `which bundle 2> /dev/null` ]]; then
  alias be='bundle exec'
fi

if [[ -x `which docker 2> /dev/null` ]]; then
  alias d='docker'
  compdef d='docker'
fi

if [[ -x `which docker-compose 2> /dev/null` ]]; then
  alias fig='docker-compose'
  compdef fig='docker-compose'
fi

# shortcut

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi
