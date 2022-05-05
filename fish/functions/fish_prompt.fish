function fish_prompt
  set -l normal (set_color normal)

  set -l current_username (set_color --bold yellow)(echo $USER)(echo $normal)
  set -l current_hostname (set_color --bold yellow)(prompt_hostname)(echo $normal)

  set -l delim '$'
  # If we don't have unicode use a simpler delimiter
  string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL; or set delim ">"

  fish_is_root_user; and set delim "#"

  set -l cwd (set_color $fish_color_cwd)
  if command -sq cksum
    set -l shas (pwd -P | cksum | string split -f1 ' ' | math --base=hex | string sub -s 3 | string match -ra ..)
    set -l col 0x$shas[1..3]

    while test (math 0.2126 x $col[1] + 0.7152 x $col[2] + 0.0722 x $col[3]) -lt 120
      set col[1] (math --base=hex "min(255, $col[1] + 60)")
      set col[2] (math --base=hex "min(255, $col[2] + 60)")
      set col[3] (math --base=hex "min(255, $col[3] + 60)")
    end
    set -l col (string replace 0x '' $col | string pad -c 0 -w 2 | string join "")

    set cwd (set_color $col)
  end

  # VCS Prompt
  set -g __fish_git_prompt_showdirtystate 1
  set -g __fish_git_prompt_showuntrackedfiles 1
  set -g __fish_git_prompt_showupstream informative
  set -g __fish_git_prompt_showcolorhints 1
  set -g __fish_git_prompt_use_informative_chars 1
  # Unfortunately this only works if we have a sensible locale
  string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
  and set -g __fish_git_prompt_char_dirtystate \U1F4a9
  set -g __fish_git_prompt_char_untrackedfiles "?"

  # The git prompt's default format is ' (%s)'.
  # We don't want the leading space.
  set -l vcs (fish_vcs_prompt '[%s]' 2>/dev/null)

  # Shorten pwd if prompt is too long
  set -l pwd (prompt_pwd)

  echo -ens "\n$current_username@$current_hostname:$cwd$pwd$normal $vcs\n$delim "
end
