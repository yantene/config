# エイリアス
alias ls="ls --color=auto"
eval $(dircolors -b)

alias grep='grep -n --color=auto'
alias tmux='tmux -2'
alias dog='cat'
alias cb='xsel -b'

if [[ -x `which vim` ]]; then
  alias vi="vim"
fi

if [[ -x `which hub` ]]; then
  alias git="hub"
fi

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`; do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# 環境変数
export EDITOR="vim"
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# 補完機能
autoload -U compinit
compinit

# プロンプト
PROMPT="
%B%F{yellow}%n@%M:%f %~
%(?.%F{green}%#%f.%F{red}%#%f)%b " # 平常時のプロンプト
RPROMPT="%B[%F{cyan}%D %T%f]%b" # 右プロンプト
PROMPT2="  " # コマンドの続き
SPROMPT=" %F{green}%r?%f " # 合ってる？

# ターミナルタイトル
case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# コマンド履歴
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# キーバインド
bindkey -e # キーバインドを emacs モードに
bindkey '^U' backward-kill-line # C-u でカーソル以左を削除

# オプション
setopt complete_aliases
setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt list_packed  # 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
setopt hist_ignore_space # 先頭が空白のコマンドを履歴に残さない

# その他
source ~/.netcmdgipsrc
