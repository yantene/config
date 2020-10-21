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

# find path

if [[ -x `which sk 2> /dev/null` ]]; then
  function sk-find-path() {
    local filepath="$( (test -x `which fd 2> /dev/null` && fd -Hc always . || find . 2> /dev/null) | sk)"
    [[ -z "$filepath" ]] && return
    escaped_filepath=`printf %q "$filepath"`
    if [[ -n "$LBUFFER" ]]; then
      BUFFER="$LBUFFER $escaped_filepath"
    else
      if [[ -f "$filepath" ]]; then
        BUFFER="$EDITOR $escaped_filepath"
      elif [[ -d "$filepath" ]]; then
        BUFFER="cd $escaped_filepath"
      fi
    fi
    CURSOR=$#BUFFER
  }

  zle -N sk-find-path
  bindkey '' sk-find-path
fi

# find line

if [[ -x `which sk 2> /dev/null` ]] && [[ -x `which rg 2> /dev/null` ]]; then
  function sk-find-line() {
    eval $(sk -i -c 'rg --smart-case --line-number --null --color=always "{}"' | cut -d: -f1 | awk -F "\0" "{print \"$EDITOR -c \" \$2 \" \" \"'\"\$1\"'\"}")
  }

  zle -N sk-find-line
  bindkey '' sk-find-line
fi

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
  ssh-sk-resetbg () {
    if [[ $# -eq 0 ]]; then
      local target_host=`sk --ansi -c 'grep "^Host\s\+[^*]*$" ~/.ssh/config.d/*.conf | sed "s/\s\+/\t/g" | cut -f2'`
      if [[ $target_host ]]; then
        echo connect to $target_host...
        ssh $target_host
      fi
    else
      ssh $@
    fi

    [[ $TMUX ]] && tmux select-pane -P bg=default # resetbg
  }
  alias ssh=ssh-sk-resetbg
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
