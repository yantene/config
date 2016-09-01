from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import subprocess
import os

@hook.subscribe.startup_once
def autostart():
    subprocess.call(['ibus-daemon', '-d', '-x'])
    subprocess.call(['pulseaudio', '--start'])
    subprocess.call(['syndaemon', '-i', '0.2', '-d'])
    os.system('dunst &')

k_ctrl  = 'control'
k_shift = 'shift'
k_alt   = 'mod1'
k_super = 'mod4'

keys = [
    # 現在のスタックペインでウィンドウのフォーカスを切り替える
    Key(
        [k_super], 'k',
        lazy.layout.down()
    ),
    Key(
        [k_super], 'j',
        lazy.layout.up()
    ),

    # 現在のスタックでウィンドウを上下移動させる
    Key(
        [k_super, k_shift], 'k',
        lazy.layout.shuffle_down()
    ),
    Key(
        [k_super, k_shift], 'j',
        lazy.layout.shuffle_up()
    ),

    # 別のスタックペインへフォーカスを切り替える
    Key(
        [k_super], 'space',
        lazy.layout.next()
    ),

    # スタックペインを入れ替える
    Key(
        [k_super, k_shift], 'space',
        lazy.layout.rotate()
    ),

    # スタックでウィンドウを分割表示するかしないかをトグルする
    Key(
        [k_super], 'Return',
        lazy.layout.toggle_split()
    ),

    # gnome-terminal を立ち上げる
    Key([k_super, k_shift], 'Return', 
        lazy.spawn('termite')
    ),

    # コマンド入力欄を表示する
    Key([k_super], 'd', lazy.spawncmd()),

    # レイアウトをトグルする
    Key([k_super], 'Tab', lazy.next_layout()),

    # ウィンドウを kill する
    Key([k_super, k_shift], 'c', lazy.window.kill()),

    # qtile を再起動・終了する
    Key([k_super, k_ctrl], 'r', lazy.restart()),
    Key([k_super, k_ctrl], 'q', lazy.shutdown()),

    # タッチパッド
    Key([], 'XF86TouchpadToggle',
      # VAIO Pro では Fn + F1 で XF86TouchpadToggle イベントが発生しないので使用不可
      lazy.spawn('sh -c \"synclient TouchpadOff=$(synclient -l | grep -c \'TouchpadOff.*=.*0\')\"'),
    ),

    # 音量
    Key([], 'XF86AudioMute',
      lazy.spawn('pactl set-sink-mute 1 toggle'),
      lazy.spawn('pactl set-sink-mute 2 toggle'),
    ),
    Key([], 'XF86AudioLowerVolume',
      lazy.spawn('pactl set-sink-mute 1 false'),
      lazy.spawn('pactl set-sink-mute 2 false'),
      lazy.spawn('pactl set-sink-volume 1 -5%'),
      lazy.spawn('pactl set-sink-volume 2 -5%'),
    ),
    Key([], 'XF86AudioRaiseVolume',
      lazy.spawn('pactl set-sink-mute 1 false'),
      lazy.spawn('pactl set-sink-mute 2 false'),
      lazy.spawn('pactl set-sink-volume 1 +5%'),
      lazy.spawn('pactl set-sink-volume 2 +5%'),
    ),

    # 輝度
    Key([], 'XF86MonBrightnessDown', lazy.spawn('xbacklight -dec 2')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('xbacklight -inc 2')),

    # デュアルスクリーン
    Key([], 'XF86Display', lazy.spawn('dscreen')),
]

groups = [Group(i) for i in 'qwertyuiop']

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([k_super], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([k_super, k_shift], i.name, lazy.window.togroup(i.name))
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
                widget.CPUGraph(line_width=2, width=50, graph_color='f8ff8c'),
                widget.MemoryGraph(line_width=2, width=50, graph_color='8cff8d'),
                widget.NetGraph(interface='wlp1s0', bandwidth_type='down',
                                line_width=2, width=50, graph_color='8cfff8'),
                widget.NetGraph(interface='wlp1s0', bandwidth_type='up',
                                line_width=2, width=50, graph_color='8c9aff'),
                widget.BatteryIcon(theme_path='/home/yantene/.config/qtile/battery-icons'),
                widget.Battery(format='{percent:2.0%}'),
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
                widget.WindowName(),
                widget.Clock(format='%Y-%m-%d (%a) %p %I:%M'),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([k_super], 'Button1', lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([k_super], 'Button3', lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([k_super], 'Button2', lazy.window.bring_to_front())
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
wmname = 'LG3D'
