# - login shell

# xinitrc
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

# SSH Agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# X の立ち上げ
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx $XINITRC
