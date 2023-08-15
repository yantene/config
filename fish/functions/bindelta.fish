function bindelta
  delta (hexyl -v $argv[1] | psub) (hexyl -v $argv[2] | psub)
end
