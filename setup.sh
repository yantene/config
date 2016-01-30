#!/bin/sh

cd `dirname $0`

for file in `find . -type f | grep -v '\(^\.\/.git\/.*$\|^\.\/setup\.sh$\)'`; do
  orig_file=$(cd `dirname $file` && pwd)/`basename $file`
  (
    cd ~
    mkdir -p `dirname $file`
    link_file=$(cd `dirname $file` && pwd)/`basename $file`
    ln -sf $orig_file $link_file
  )
  echo
done


