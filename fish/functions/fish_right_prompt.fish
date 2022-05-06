function fish_right_prompt
  set -l last_status $status

  set -l current_time (set_color brgrey)(date "+%F %T")(set_color normal)

  set -l duration "$cmd_duration$CMD_DURATION"
  if test $duration -gt 100
    set duration (math $duration / 1000)s
  else
    set duration
  end

  # Prompt status only if it's not 0
  set -l prompt_status
  if test $last_status -ne 0
    set prompt_status (set_color --bold $fish_color_error)"🚨$last_status"(set_color normal)
  end

  set_color normal
  string join " " -- $prompt_status $duration $current_time
end
