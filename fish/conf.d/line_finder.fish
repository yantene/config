if type -q sk; and type -q rg
  function __line-finder
    eval (
      sk -i \
        -c 'rg --smart-case --line-number --null --color=always "{}"' |\
        cut -d: -f1 |\
        awk \
          -F "\0" \
          "{print \"$EDITOR -c \" \$2 \" \" \"'\"\$1\"'\"}"
    )
  end

  bind \cg __line-finder
end
