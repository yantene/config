if type -q ssh
  function ssh
    if test (count $argv) -eq 0
      set target_host (
        sk --ansi -c "
          grep '^Host\s\+[^*]*\$' ~/.ssh/{config,config.d/**/*.conf} |\
          sed 's/\s\+/\t/g' |\
          cut -f2
        "
      )

      test -z $target_host && return

      command ssh $target_host
    else
      command ssh $argv
    end
  end
end
