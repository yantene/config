if type -q ghq
  function ghq
    if test (count $argv) -eq 0
      set repo_path (sk -c "command ghq list")
      test $repo_path && cd "$(command ghq root)/$repo_path" || return
    else
      command ghq $argv
    end
  end
end
