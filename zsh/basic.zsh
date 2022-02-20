# shellcheck disable=SC2034

# terminal title

case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# prompt

if [[ -z "$SSH_CONNECTION" ]]; then
  hostname_color='yellow'
else
  hostname_color='blue'
fi

function rprompt-git-current-branch {
  local branch_name st branch_status
  if git rev-parse 2> /dev/null; then
    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    st=$(git status 2> /dev/null)
    if grep -q "^nothing to" <<<"$st"; then
      # 全てcommitされてクリーンな状態
      branch_status="[%F{green}"
    elif grep -q "^Untracked files" <<<"$st"; then
      # gitに管理されていないファイルがある状態
      branch_status="?[%F{red}"
    elif grep -q "^Changes not staged for commit" <<<"$st"; then
      # git addされていないファイルがある状態
      branch_status="+[%F{red}"
    elif grep -q "^Changes to be committed" <<<"$st"; then
      # git commitされていないファイルがある状態
      branch_status="![%F{yellow}"
    elif grep -q "^rebase in progress" <<<"$st"; then
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
prompt_2ndline="%B%F{${hostname_color}}%n@%M:%f%b%~"
prompt_3rdline="%F{grey}$%f "
setopt prompt_subst
PROMPT="$prompt_1stline

$prompt_2ndline
$prompt_3rdline" # 平常時のプロンプト
# shellcheck disable=SC2016
RPROMPT='%B$(rprompt-git-current-branch)%b' # 右プロンプト
PROMPT2="  " # コマンドの続き
SPROMPT=" %F{green}%r?%f " # 合ってる？

# zsh-syntax-highlighting

if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  # shellcheck disable=SC1094
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

if [[ -x $(which sk 2> /dev/null) ]]; then
  function sk-select-history() {
    # shellcheck disable=SC2153
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

# others

setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt nolistbeep # ビープ消す

[[ -x $(which dircolors 2> /dev/null) ]] && eval "$(dircolors -b)"

if [[ -x $(which nvim 2> /dev/null) ]]; then
  export EDITOR='nvim'
elif [[ -x $(which vim 2> /dev/null) ]]; then
  export EDITOR='vim'
elif [[ -x $(which vi 2> /dev/null) ]]; then
  export EDITOR='vi'
elif [[ -x $(which nano 2> /dev/null) ]]; then
  export EDITOR='nano'
fi

LESS=-R
LESS_TERMCAP_me=$(printf '\e[0m')
LESS_TERMCAP_se=$(printf '\e[0m')
LESS_TERMCAP_ue=$(printf '\e[0m')
LESS_TERMCAP_mb=$(printf '\e[1;32m')
LESS_TERMCAP_md=$(printf '\e[1;34m')
LESS_TERMCAP_us=$(printf '\e[1;32m')
LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# skim

export SKIM_DEFAULT_OPTIONS='
  --ansi
  --reverse
  --color=matched:0,matched_bg:3,current_bg:8,current_match:0,current_match_bg:3
'

# asdf

if [[ -f /opt/asdf-vm/asdf.sh ]]; then
  . /opt/asdf-vm/asdf.sh
fi

# yarn

if [[ -x $(which yarn 2> /dev/null) ]]; then
  if [[ -d "$XDG_DATA_HOME/yarn/global/node_modules/.bin" ]]; then
    PATH="$XDG_DATA_HOME/yarn/global/node_modules/.bin:$PATH"
  else
    PATH="$(yarn global dir --offline)/node_modules/.bin:$PATH"
  fi
fi

# direnv

if [[ -x $(which direnv 2> /dev/null) ]]; then
  eval "$(direnv hook zsh)"
fi

# mosh

if [[ -x $(which mosh 2> /dev/null) ]]; then
  compdef mosh=ssh # ssh の補完を mosh に
fi
