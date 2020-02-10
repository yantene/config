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
      branch_status="!?[%F{magenta}"
      branch_name="NO BRANCH"
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

# zsh-syntax-highlighting

if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi

# key bind

bindkey -e # キーバインドを emacs モードに
bindkey '' backward-kill-line # C-u でカーソル以左を削除
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # C-w 時にスラッシュを単語デリミタとして扱う

# history

HISTFILE=$XDG_DATA_HOME/zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_space # 先頭が空白のコマンドを履歴に残さない
setopt hist_reduce_blanks # 余計な空白を除去して記録する
setopt share_history # 複数の端末で履歴を共有する
setopt append_history # 複数の zsh を同時に使用した際に、履歴ファイルを上書きではなく追記する
setopt extended_history # 実行開始時刻・実行時間を記録

if [[ -x `which sk 2> /dev/null` ]]; then
  function sk-select-history() {
    BUFFER="$(history -nr 1 | awk '!_[$0]++' | sk --regex --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N sk-select-history
  bindkey '' sk-select-history
else
  autoload history-search-end
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey '' history-beginning-search-backward-end
  bindkey '' history-beginning-search-forward-end
fi

setopt no_flow_control

# input completion

autoload -U compinit
setopt complete_aliases
setopt list_packed  # 補完候補の詰め詰め
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compinit

# find path

if [[ -x `which sk 2> /dev/null` ]]; then
  function sk-find-path() {
    local filepath="$( (test -x `which fd 2> /dev/null` && fd -Hc always . || find . 2> /dev/null) | sk)"
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

  zle -N sk-find-path
  bindkey '' sk-find-path
fi

# find line

if [[ -x `which sk 2> /dev/null`  && -x `which rg 2> /dev/null` ]]; then
  function sk-find-line() {
    eval $(sk -i -c 'rg --smart-case --line-number --null --color=always "{}"' | cut -d: -f1 | awk -F "\0" "{print \"$EDITOR -c \" \$2 \" \" \$1}")
  }

  zle -N sk-find-line
  bindkey '' sk-find-line
fi

# others

setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt nolistbeep # ビープ消す

[[ -x `which dircolors 2> /dev/null` ]] && eval $(dircolors -b)

export EDITOR='nvim'
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# skim

export SKIM_DEFAULT_OPTIONS='
  --ansi
  --reverse
  --color=matched:0,matched_bg:3
  --bind "ctrl-u:backward-kill-word"
'

# anyenv

if [[ -x `which anyenv 2> /dev/null` ]]; then
  eval "$(anyenv init -)"
fi

# yarn

if [[ -x `which yarn 2> /dev/null` ]]; then
  if [[ -d "$XDG_DATA_HOME/yarn/global/node_modules/.bin" ]]; then
    export PATH="$XDG_DATA_HOME/yarn/global/node_modules/.bin:$PATH"
  else
    export PATH="`yarn global dir --offline`/node_modules/.bin:$PATH"
  fi
fi

# direnv

if [[ -x `which direnv 2> /dev/null` ]]; then
  eval "$(direnv hook zsh)"
fi

# mosh

if [[ -x `which mosh 2> /dev/null` ]]; then
  compdef mosh=ssh # ssh の補完を mosh に
fi
