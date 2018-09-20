alias xpath='xmllint --html --xpath 2> /dev/null'
alias wunzip='unzip -Ocp932'
alias trash="mv --backup=numbered --target-directory=$HOME/trash"

# timestamp

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

# anonymous browser

alias anony="chromium --proxy-server=socks://localhost:9050 --no-referrers --user-agent='' --incognito --user-data-dir=`mktemp -d` https://duckduckgo.com"

# text processing

alias sp2tab='sed -e "s/\s\+/\t/g"'

# git

alias gup='git rev-parse --is-inside-work-tree > /dev/null 2>&1 && cd `pwd`/`git rev-parse --show-cdup`'
alias gbranch='git rev-parse --abbrev-ref HEAD 2> /dev/null'

if [[ -x `which hub 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && hub status || hub $@ }
  compdef g=hub
elif [[ -x `which git 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && git status || git $@ }
  compdef g=git
fi

# search

if [[ -x `which peco 2> /dev/null` && -x `which ag 2> /dev/null` ]]; then
  function age () {
    local args=$@
    [[ $# -eq 0 ]] && args='.'

    eval $(ag $args | peco | awk -F : "{print \"$EDITOR -c \" \$2 \" \" \$1}")
  }
fi

# pekill

if [[ -x `which peco 2> /dev/null` ]]; then
  function pekill () {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
  }
fi

# notes

if [[ -x `which peco 2> /dev/null` && -x `which ag 2> /dev/null` ]]; then
  function notes () {
    eval $(ag -U $@ $HOME/notes | peco | awk -F : "{print \"$EDITOR -c \" \$2 \" \" \$1}")
  }
fi

# mozc

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi
