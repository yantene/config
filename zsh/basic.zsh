# terminal title

case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# prompt

if [[ ! -n "$SSH_CONNECTION" ]]; then
  hostname_color='yellow'
else
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

# key bind

bindkey -e # キーバインドを emacs モードに
bindkey '' backward-kill-line # C-u でカーソル以左を削除
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # C-w 時にスラッシュを単語デリミタとして扱う

# history

HISTFILE=$XDG_CACHE_HOME/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt hist_ignore_space # 先頭が空白のコマンドを履歴に残さない
setopt share_history

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

# input completion

autoload -U compinit
setopt complete_aliases
setopt list_packed  # 補完候補の詰め詰め
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compinit

# change directory and edit file

if [[ -x `which peco 2> /dev/null` ]]; then
  function peco-path() {
    local filepath="$(find . | grep -v '/\.' | peco --prompt 'PATH>')"
    [[ -z "$filepath" ]] && return
    if [[ -n "$LBUFFER" ]]; then
      BUFFER="$LBUFFER$filepath"
    else
      if [[ -d "$filepath" ]]; then
        BUFFER="cd $filepath"
      elif [[ -f "$filepath" ]]; then
        BUFFER="$EDITOR $filepath"
      fi
    fi
    CURSOR=$#BUFFER
  }

  zle -N peco-path
  bindkey '' peco-path
fi

# others

setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt nolistbeep # ビープ消す

eval $(dircolors -b)

export EDITOR='nvim'
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# anyenv

if [[ -x `which git 2> /dev/null` ]]; then
  [[ -d $HOME/.anyenv ]] || git clone https://github.com/riywo/anyenv $HOME/.anyenv
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# yarn

if [[ -x `which yarn 2> /dev/null` ]]; then
  export PATH="`yarn global dir`/node_modules/.bin:$PATH"
  alias npm='yarn'
fi

# direnv

if [[ -x `which direnv 2> /dev/null` ]]; then
  eval "$(direnv hook zsh)"
fi

# mosh

if [[ -x `which mosh 2> /dev/null` ]]; then
  compdef mosh=ssh # ssh の補完を mosh に
fi
