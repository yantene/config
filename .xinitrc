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
#xsetroot -cursor_name left_ptr

#ibus-mozc
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

#タッチパッド誤動作防止
syndaemon -i 0.5 -d

#スタートアップアプリケーション

exec xmonad
# exec gnome-session
# exec startkde
# exec startxfce4
