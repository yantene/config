# エイリアス
alias ls="ls --color=auto"
alias vi="vim"
alias tmux="tmux -2"

# 環境変数
export EDITOR="vim"

# 補完機能
autoload -U compinit
compinit

# プロンプト
PROMPT="
%B%F{yellow}%n@%M:%f %~
%(?.%F{green}%#%f.%F{red}%#%f)%b " # 平常時のプロンプト
RPROMPT="" # 右プロンプト
PROMPT2=" " # コマンドの続き
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

# オプション
setopt complete_aliases
setopt auto_pushd # 移動履歴(cd -[Tab])
setopt correct  # コマンド訂正
setopt list_packed  # 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
