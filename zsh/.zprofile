# - login shell

# xinitrc
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

# X の立ち上げ
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx $XINITRC
