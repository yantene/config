# - login shell
# - interactive shell

source $ZDOTDIR/basic.zsh

source $ZDOTDIR/tools.zsh

source $ZDOTDIR/aliases.zsh

for scripts_dir in `ls -1d $ZDOTDIR/scripts/*`; do
  export PATH="$scripts_dir:$PATH"
done
