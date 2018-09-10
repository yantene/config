# - login shell
# - interactive shell

source $ZDOTDIR/basic.zsh

source $ZDOTDIR/aliases.zsh

for scripts_dir in `ls -1 $ZDOTDIR/scripts`; do
  export PATH="$scripts_dir:$PATH"
done
