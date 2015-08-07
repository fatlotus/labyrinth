#!/bin/bash -e
#
# In order to create an infinite number of scopes, we generate a "scope maze,"
# a series of symlinks cunningly designed to make a single directory appear
# as a countably infinite number of directories.
#
# (ex. so that /enter-maze/321/453/032/exit-maze/index-html -> /index.html)
#
# Unfortunately, some trickery is required for this code to work on Github
# Pages, so this file must be rerun whenever a new file is added to the
# repository.

rm -Rf enter-maze

mkdir -p enter-maze
seq -w 0 999 | xargs "-I{}" ln -s next-step "enter-maze/{}"

mkdir -p enter-maze/next-step
seq -w 0 999 | xargs "-I{}" ln -s "../{}" "enter-maze/next-step/{}"
ln -s ../exit-maze enter-maze/next-step/exit-maze

mkdir -p enter-maze/exit-maze
ls | grep -v enter-maze | xargs "-I{}" ln -s ../../{} "enter-maze/exit-maze/{}"

if ! [ -f enter-maze/exit-maze/make-maze.sh ]; then
  echo "Self-test failed: unable to resolve enter-maze/exit-maze."
  exit 1
fi

if ! [ -f enter-maze/042/131/exit-maze/make-maze.sh ]; then
  echo "Self-test failed: unable to resolve enter-maze/042/131/exit-maze."
  exit 1
fi

