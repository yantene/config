alias xpath='xmllint --html --xpath 2> /dev/null'
alias wunzip='unzip -Ocp932'
alias trash="mv --backup=numbered --target-directory=$HOME/trash"

cb () {
  if [[ -p /dev/stdin ]]; then
    xclip -selection clipboard
  else
    xclip -o -selection clipboard
  fi
}

# timestamp

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

# text processing

alias sp2tab='sed -e "s/\s\+/\t/g"'
alias csv2tsv='ruby -rcsv -ne '\''puts CSV.parse($_)[0].join(%[\t])'\'

# git

alias gup='git rev-parse --is-inside-work-tree > /dev/null 2>&1 && cd `pwd`/`git rev-parse --show-cdup`'

if [[ -x `which hub 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && hub status || hub $@ }
  compdef g=hub
elif [[ -x `which git 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && git status || git $@ }
  compdef g=git
fi

if [[ -x `which ghq 2> /dev/null` &&  -x `which sk 2> /dev/null` ]]; then
  ghq-cd () {
    if [[ $# -eq 0 ]]; then
      cd `ghq root`/`sk -c 'ghq list'`
    else
      ghq $@
    fi
  }
  alias ghq=ghq-cd
fi
# unzipall

function unzipall () { ls -1 $@ | xargs -I{} unzip {} }
function wunzipall () { ls -1 $@ | xargs -I{} wunzip {} }

# pekill

if [[ -x `which sk 2> /dev/null` ]]; then
  function pekill () {
    sk --ansi -c 'ps -ef --no-headers' | awk '{ print $2 }' | xargs kill
  }
fi

# notes

if [[ -x `which sk 2> /dev/null` && -x `which ag 2> /dev/null` ]]; then
  function notes () {
    eval $(sk --ansi -i -c "rg --line-number --null --color=always '{}' $HOME/notes" | cut -d: -f1 | awk -F "\0" "{print \"$EDITOR -c \" \$2 \" \" \$1}")
  }
fi
