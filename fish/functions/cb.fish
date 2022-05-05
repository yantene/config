if type -q xclip
  function cb
    # Avoid the fish builtin test command
    # https://github.com/fish-shell/fish-shell/issues/3792
    if command test -p /dev/stdin -o -f /dev/stdin
      xclip -selection clipboard
    else
      xclip -o -selection clipboard
    end
  end
end
