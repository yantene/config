# エイリアス
setopt complete_aliases
alias ls="ls --color=auto"
alias vi="vim"

# 環境変数
export EDITOR=vim

# 補完機能
autoload -U compinit
compinit

# プロンプト
case ${UID} in
0)
	PROMPT="%{[31m%}%n%%%{[m%} "
	RPROMPT="[%~]"
	PROMPT2="%B%{[31m%}%_#%{[m%}%b "
	SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
	;;
*)
	PROMPT="%{[31m%}%n%%%{[m%} "
	RPROMPT="[%~]"
	PROMPT2="%{[31m%}%_%%%{[m%} "
	SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
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
setopt auto_pushd	# 移動履歴(cd -[Tab])
setopt correct	# コマンド訂正
setopt list_packed	# 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
bindkey -v
