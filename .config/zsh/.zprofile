# temporary ディレクトリの作成

mkdir -p /tmp/yantene-temporary
mkdir -p /tmp/yantene-trash

# X の立ち上げ

export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
