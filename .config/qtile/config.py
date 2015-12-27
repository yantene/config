from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import subprocess
import os

@hook.subscribe.startup_once
def autostart():
    subprocess.call(["fcitx", "-d"])
    subprocess.call(["pulseaudio", "--start"])
    os.system("dunst &")

ctrl = "control"
alt  = "mod1"
spr  = "mod4"

keys = [
    # 現在のスタックペインでウィンドウのフォーカスを切り替える
    Key(
        [spr], "k",
        lazy.layout.down()
    ),
    Key(
        [spr], "j",
        lazy.layout.up()
    ),

    # 現在のスタックでウィンドウを上下移動させる
    Key(
        [spr, "shift"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [spr, "shift"], "j",
        lazy.layout.shuffle_up()
    ),

    # 別のスタックペインへフォーカスを切り替える
    Key(
        [spr], "space",
        lazy.layout.next()
    ),

    # スタックペインを入れ替える
    Key(
        [spr, "shift"], "space",
        lazy.layout.rotate()
    ),

    # スタックでウィンドウを分割表示するかしないかをトグルする
    Key(
        [spr], "Return",
        lazy.layout.toggle_split()
    ),

    # urxvt を立ち上げる
    Key([spr, "shift"], "Return", 
        lazy.spawn("urxvt")
    ),

    # コマンド入力欄を表示する
    Key([spr], "d", lazy.spawncmd()),

    # レイアウトをトグルする
    Key([spr], "Tab", lazy.next_layout()),

    # ウィンドウを kill する
    Key([spr, "shift"], "c", lazy.window.kill()),

    # qtile を再起動・終了する
    Key([spr, "control"], "r", lazy.restart()),
    Key([spr, "control"], "q", lazy.shutdown()),

    # タッチパッド
    Key([], "XF86TouchpadToggle",
        lazy.spawn("synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')")
    ),

    # 音量
    Key([], "XF86AudioMute", lazy.spawn("amixer -q sset Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master on 10%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master on 10%+")),

    # 輝度
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 2")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 2")),
    
    # デュアルスクリーン
    Key([], "XF86Display", lazy.spawn("")),
]

groups = [Group(i) for i in "qwertyuiop"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([spr], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([spr, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2)
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.TextBox("default config", name="default"),
                widget.Battery(),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d (%a) %p %I:%M'),
            ],
            30,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Clock(format='%Y-%m-%d (%a) %p %I:%M'),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([spr], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([spr], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([spr], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
