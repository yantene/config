# - login shell
# - interactive shell

# aliases
alias ls="ls --color=auto"
eval $(dircolors -b)

alias grep="grep --color=auto"
alias tmux="tmux -2 -f \"$XDG_CONFIG_HOME\"/tmux/tmux.conf"
alias rm="rm -i"
alias trash="mv --backup=numbered --target-directory=$HOME/trash"

if [[ -x `which hub` ]]; then
  alias git="hub"
fi

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

if [[ -x `which nvim` ]]; then
  alias vim='nvim'
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
PROMPT="
%B%F{yellow}%n@%M:%f %~
%(?.%F{green}%#%f.%F{red}%#%f)%b " # 平常時のプロンプト
RPROMPT="%B[%F{cyan}%D %T%f]%b" # 右プロンプト
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

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# command history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# key bind
bindkey -e # キーバインドを emacs モードに
bindkey '^U' backward-kill-line # C-u でカーソル以左を削除

# options
setopt complete_aliases
setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt list_packed  # 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
setopt hist_ignore_space # 先頭が空白のコマンドを履歴に残さない

# others
source "${XDG_CONFIG_HOME}/zsh/netcmdgips"
