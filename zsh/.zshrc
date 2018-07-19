# - login shell
# - interactive shell

# pathes

if [[ -d $HOME/.anyenv ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`; do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

if [[ -x `which ruby 2> /dev/null` ]]; then
  export PATH="$PATH:"`ruby -e "puts Gem.user_dir"`"/bin"
fi

if [[ -x `which go 2> /dev/null` ]]; then
  mkdir -p $HOME/.go/bin
  export PATH="$PATH:$HOME/.go/bin"
  export GOPATH=$HOME/.go
fi

if [[ -x `which R 2> /dev/null` ]]; then
  export R_ENVIRON_USER="${XDG_CONFIG_HOME}/R/Renviron"
fi

if [[ -x `which javac 2> /dev/null` ]]; then
  export JAVA_HOME=`readlink -f /usr/bin/javac | sed "s:/bin/javac::"`
fi

if [[ -x `which direnv 2> /dev/null` ]]; then
  eval "$(direnv hook zsh)"
fi

# aliases
alias ls="ls --color=auto"
eval $(dircolors -b)

alias grep="grep --color=auto"
alias tmux="tmux -2 -f \"$XDG_CONFIG_HOME\"/tmux/tmux.conf"
alias trash="mv --backup=numbered --target-directory=$HOME/trash"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias la="ls -lah"
alias lat="ls -lahtr"
alias sc="systemctl"
alias xpath='xmllint --html --xpath 2> /dev/null'
alias wunzip='unzip -Ocp932'

alias anony="chromium --proxy-server=socks://localhost:9050 --no-referrers --user-agent='' --incognito --user-data-dir=`mktemp -d` https://duckduckgo.com"

# tools

alias sp2tab='sed -e "s/\s\+/\t/g"'

function gup () {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

if [[ -x `which peco 2> /dev/null` ]]; then
  function cedit () {
    [[ $# -eq 0 ]] && return 1
    $EDITOR $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
  }

  function nedit () {
    [[ $# -eq 0 ]] && return 1
    $EDITOR $(ag -g $@ | peco --query "$LBUFFER")
  }
fi

if [[ `find $XDG_CONFIG_HOME/chromium/Default/Extensions -name 'line_chrome.min.css' 2> /dev/null | wc -l` -eq 1 ]]; then
  alias line="chromium --app-id=$(find $XDG_CONFIG_HOME/chromium/Default/Extensions -name 'line_chrome.min.css' | cut -d'/' -f8)"
fi

if [[ -x `which hub 2> /dev/null` ]]; then
  alias git="hub"
  alias gbranch="git rev-parse --abbrev-ref HEAD 2> /dev/null"
fi

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

if [[ -x `which trans 2> /dev/null` ]]; then
  alias trans='trans -show-original Y\
                     -show-original-phonetics n\
                     -show-translation Y\
                     -show-translation-phonetics n\
                     -show-prompt-message n\
                     -show-languages n\
                     -show-original-dictionary N\
                     -show-dictionary n\
                     -show-alternatives n\
                     -no-ansi'
  function ja() {
    if [[ -p /dev/stdin ]]; then
      trans :ja
    else
      echo "$@" | ja
    fi
  }
  function en() {
    if [[ -p /dev/stdin ]]; then
      trans :en
    else
      echo "$@" | en
    fi
  }
fi

# my scripts and commands
if [[ -d "$HOME/scripts" ]]; then
  export PATH="$PATH:$HOME/scripts"
fi

if [[ -f "$HOME/dev/twitter/mikutter/mikutter.rb" ]]; then
  alias mikutter="ruby $HOME/dev/twitter/mikutter/mikutter.rb"
fi

if [[ -f /usr/lib/mozc/mozc_tool ]]; then
  alias mozc='/usr/lib/mozc/mozc_tool --mode=config_dialog'
fi

if [[ -x `which xsel 2> /dev/null` ]]; then
  alias cb="xsel -b"
fi

if [[ -x `which cvlc 2> /dev/null` ]]; then
  alias play="cvlc --play-and-exit $* >& /dev/null"
fi

# environment variables
export EDITOR="nvim"
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# input completion
autoload -U compinit
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compinit

# prompt
if [[ ! -n "$SSH_CONNECTION" ]]; then
  # ローカル環境
  hostname_color='yellow'
else
  # リモート環境
  hostname_color='blue'
fi
function rprompt-git-current-branch {
  local branch_name st branch_status
  if git rev-parse 2> /dev/null; then
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
    if [[ -n `grep "^nothing to" <<<$st` ]]; then
      # 全てcommitされてクリーンな状態
      branch_status="[%F{green}"
    elif [[ -n `grep "^Untracked files" <<<$st` ]]; then
      # gitに管理されていないファイルがある状態
      branch_status="?[%F{red}"
    elif [[ -n `grep "^Changes not staged for commit" <<<$st` ]]; then
      # git addされていないファイルがある状態
      branch_status="+[%F{red}"
    elif [[ -n `grep "^Changes to be committed" <<<$st` ]]; then
      # git commitされていないファイルがある状態
      branch_status="![%F{yellow}"
    elif [[ -n `grep "^rebase in progress" <<<$st` ]]; then
      # コンフリクトが起こった状態
      echo "!(no branch)[%F{red}"
      return
    else
      # 上記以外の状態の場合は青色で表示させる
      branch_status="[%F{blue}"
    fi
    echo "${branch_status}$branch_name%f]"
  else
    return
  fi
}
prompt_1stline="[%F{cyan}%D %T%f%f] %B%(?.%F{green}↩%f.%F{red}↩%f)%b"
prompt_2ndline="%B%F{${hostname_color}}%n@%M:%f %~%b"
prompt_3rdline="%F{grey}$%f "
setopt prompt_subst
PROMPT="$prompt_1stline

$prompt_2ndline
$prompt_3rdline" # 平常時のプロンプト
RPROMPT='%B`rprompt-git-current-branch`%b' # 右プロンプト
PROMPT2="  " # コマンドの続き
SPROMPT=" %F{green}%r?%f " # 合ってる？

# terminal title
case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# key bind
bindkey -e # キーバインドを emacs モードに
bindkey '' backward-kill-line # C-u でカーソル以左を削除
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # C-w 時にスラッシュを単語デリミタとして扱う

# history settings
HISTFILE=$XDG_CACHE_HOME/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# command history
if [[ -x `which peco 2> /dev/null` ]]; then
  function peco-select-history() {
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N peco-select-history
  bindkey '' peco-select-history
else
  autoload history-search-end
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey '' history-beginning-search-backward-end
  bindkey '' history-beginning-search-forward-end
fi

# options
setopt complete_aliases
setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt list_packed  # 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
setopt hist_ignore_space # 先頭が空白のコマンドを履歴に残さない

# compdef
compdef mosh=ssh # ssh の補完を mosh に

# others
source "${XDG_CONFIG_HOME}/zsh/netcmdgips"
