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
  export PATH="$PATH:"`ruby -rubygems -e "puts Gem.user_dir"`"/bin"
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

if [[ `find $XDG_CONFIG_HOME/chromium/Default/Extensions -name 'line_chrome.min.css' 2> /dev/null | wc -l` -eq 1 ]]; then
  alias line="chromium --app-id=$(find $XDG_CONFIG_HOME/chromium/Default/Extensions -name 'line_chrome.min.css' | cut -d'/' -f8)"
fi

if [[ -x `which hub 2> /dev/null` ]]; then
  alias git="hub"
fi

if [[ -x `which pacaur 2> /dev/null` ]]; then
  alias pac='pacaur'
else
  alias pac='pacman'
fi

if [[ -x `which colordiff 2> /dev/null` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

if [[ -x `which nvim 2> /dev/null` ]]; then
  alias vim='nvim'
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
  # ローカルでの平常時のプロンプト
  PROMPT="
%B%F{yellow}%n@%M:%f %~
%(?.%F{green}$%f.%F{red}$%f)%b "
else
  # リモートでの平常時のプロンプト
  PROMPT="
%B%F{blue}%n@%M:%f %~
%(?.%F{green}$%f.%F{red}$%f)%b " # 平常時のプロンプト
fi
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
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# command history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '' history-beginning-search-backward-end
bindkey '' history-beginning-search-forward-end

# key bind
bindkey -e # キーバインドを emacs モードに
bindkey '' backward-kill-line # C-u でカーソル以左を削除

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
