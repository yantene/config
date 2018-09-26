require 'color'

def hsl2rgb(h, s, l)
  Color::HSL.new(h % 360, s, l).html.gsub('#', '0x')
end

rot = -10
nsat, nlit =  65, 55
bsat, blit =  75, 65

puts <<~ALACRITTY
  env:
    TERM: xterm-256color
  
  window:
    dimensions:
      columns: 0
      lines: 0
    padding:
      x: 0
      y: 0
    decorations: none
  
  scrolling:
    history: 100000
  
  tabspaces: 2
  
  font:
    normal:
      family: monospace
    bold:
      family: monospace
    italic:
      family: monospace
    size: 6
  
  colors:
    primary:
      foreground: '0xeaeaea'
      background: '0x242424'
    normal:
      black:   '#{hsl2rgb(  0,    0,     0)}'
      red:     '#{hsl2rgb(  0 + rot, nsat,  nlit)}'
      yellow:  '#{hsl2rgb( 60 + rot, nsat,  nlit)}'
      green:   '#{hsl2rgb(120 + rot, nsat,  nlit)}'
      cyan:    '#{hsl2rgb(180 + rot, nsat,  nlit)}'
      blue:    '#{hsl2rgb(240 + rot, nsat,  nlit)}'
      magenta: '#{hsl2rgb(300 + rot, nsat,  nlit)}'
      white:   '#{hsl2rgb(  0,    0,    85)}'
    bright:
      black:   '#{hsl2rgb(  0,    0,    35)}'
      red:     '#{hsl2rgb(  0 + rot, bsat,  blit)}'
      yellow:  '#{hsl2rgb( 60 + rot, bsat,  blit)}'
      green:   '#{hsl2rgb(120 + rot, bsat,  blit)}'
      cyan:    '#{hsl2rgb(180 + rot, bsat,  blit)}'
      blue:    '#{hsl2rgb(240 + rot, bsat,  blit)}'
      magenta: '#{hsl2rgb(300 + rot, bsat,  blit)}'
      white:   '#{hsl2rgb(  0,    0,    90)}'
  
  key_bindings:
    - { key: Left,  chars: "\\x1b[D",   mode: ~AppCursor }
    - { key: Left,  chars: "\\x1bOD",   mode: AppCursor  }
    - { key: Right, chars: "\\x1b[C",   mode: ~AppCursor }
    - { key: Right, chars: "\\x1bOC",   mode: AppCursor  }
    - { key: Up,    chars: "\\x1b[A",   mode: ~AppCursor }
    - { key: Up,    chars: "\\x1bOA",   mode: AppCursor  }
    - { key: Down,  chars: "\\x1b[B",   mode: ~AppCursor }
    - { key: Down,  chars: "\\x1bOB",   mode: AppCursor  }
    - { key: V, mods: Control|Shift, action: Paste }
    - { key: C, mods: Control|Shift, action: Copy  }
  
  dynamic_title: true
  live_config_reload: true
ALACRITTY
