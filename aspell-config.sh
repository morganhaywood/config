#! /usr/bin/env bash

# this script will generate ~/.aspell.conf
# as paths in it must be absolute, so it's awkward
# to hard-code it as normal

wl=".aspell-tech.en.pws"

ln -sf "$(pwd)"/tech.wordlist ~/"$wl"

cat <<EOF >~/.aspell.conf
add-extra-dicts $HOME/$wl
ignore-case true
EOF
