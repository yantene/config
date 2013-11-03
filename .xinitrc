#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#キーマップの変更
xmodmap $HOME/.xmodmaprc

#マウスカーソルの指定
xsetroot -cursor_name left_ptr

#ibus-mozc
ibus-daemon -drx
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

#スタートアップアプリケーション
syndaemon -i 0.5 &

exec xmonad
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
