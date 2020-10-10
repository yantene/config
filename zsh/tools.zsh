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

if [[ -x `which git 2> /dev/null` ]]; then
  g () { [[ $# -eq 0 ]] && git status || git $@ }
  compdef g=git
fi

if [[ -x `which ghq 2> /dev/null` &&  -x `which sk 2> /dev/null` ]]; then
  ghq-cd () {
    if [[ $# -eq 0 ]]; then
      local repo_path=`sk -c 'ghq list'`
      [[ $repo_path ]] && cd `ghq root`/$repo_path
    else
      ghq $@
    fi
  }
  alias ghq=ghq-cd
fi

# ssh

if [[ -x `which ssh 2> /dev/null` ]]; then
  ssh-sk () {
    if [[ $# -eq 0 ]]; then
      local target_host=`sk --ansi -c 'grep "^Host\s\+[^*]*$" ~/.ssh/config.d/*.conf | sed "s/\s\+/\t/g" | cut -f2'`
      [[ $target_host ]] && ssh $target_host
    else
      ssh $@
    fi
  }
  alias ssh=ssh-sk
fi

# kill

if [[ -x `which sk 2> /dev/null` ]]; then
  function kill-sk () {
    if [[ $# -eq 0 ]]; then
      local target_process=`sk --multi -c 'ps -ef --no-headers' | awk '{ print $2 }'`
      [[ $target_process ]] && echo $target_process | xargs kill
    else
      kill $@
    fi
  }
  alias kill=kill-sk
fi

# unzipall

function unzipall () { ls -1 $@ | xargs -I{} unzip {} }
function wunzipall () { ls -1 $@ | xargs -I{} wunzip {} }
