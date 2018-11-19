alias xpath='xmllint --html --xpath 2> /dev/null'
alias wunzip='unzip -Ocp932'
alias trash="mv --backup=numbered --target-directory=$HOME/trash"

# timestamp

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

# text processing

alias sp2tab='sed -e "s/\s\+/\t/g"'

# git

alias gup='git rev-parse --is-inside-work-tree > /dev/null 2>&1 && cd `pwd`/`git rev-parse --show-cdup`'

if [[ -x `which hub 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && hub status || hub $@ }
  compdef g=hub
elif [[ -x `which git 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && git status || git $@ }
  compdef g=git
fi

if [[ -x `which ghq 2> /dev/null` ]]; then
  ghq-cd () {
    if [[ $# -eq 0 ]]; then
      cd `\ghq root`/`\ghq list | peco`
    else
      ghq $@
    fi
  }
  alias ghq=ghq-cd
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
