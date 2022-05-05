if type -q sk; and type -q fd
  function __path-finder
    set file_path (fd -Hc always . | sk)

    test -z $file_path && return
    set escaped_file_path (command printf %q "$file_path")

    if test -n (commandline)
      commandline -a "$escaped_file_path"
    else if test -f $file_path
      commandline "$EDITOR $escaped_file_path"
    else if test -d $file_path
      commandline "cd $escaped_file_path"
    end

    commandline -f repaint
  end

  bind \cf __path-finder
end
