# override

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias tmux="tmux -2 -f \"$XDG_CONFIG_HOME\"/tmux/tmux.conf"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

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

alias la="ls -lah"
alias lat="ls -lahtr"
alias sc="systemctl"

# tools

alias xpath='xmllint --html --xpath 2> /dev/null'
alias wunzip='unzip -Ocp932'
alias anony="chromium --proxy-server=socks://localhost:9050 --no-referrers --user-agent='' --incognito --user-data-dir=`mktemp -d` https://duckduckgo.com"
alias trash="mv --backup=numbered --target-directory=$HOME/trash"

## timestamp

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

## text processing

alias sp2tab='sed -e "s/\s\+/\t/g"'

## git

function gup () {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

if [[ -x `which hub 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && hub status || hub $@ }
  compdef g=hub
  alias gbranch="hub rev-parse --abbrev-ref HEAD 2> /dev/null"
elif [[ -x `which git 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && git status || git $@ }
  compdef g=git
  alias gbranch="git rev-parse --abbrev-ref HEAD 2> /dev/null"
fi

# search

if [[ -x `which peco 2> /dev/null` ]]; then
  if [[ -x `which ag 2> /dev/null` ]]; then
    function age () {
      args=$@
      [[ $# -eq 0 ]] && args='.'

      eval $(ag $args | peco | awk -F : "{print \"$EDITOR -c \" \$2 \" \" \$1}")
    }
  fi

  function pekill () {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
  }
fi

# mozc

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi
