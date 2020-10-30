#! /usr/bin/env bash

d=$(pwd)

ln -sf "$d"/.zshrc ~/.zshrc
ln -sf "$d"/.gitconfig ~/.gitconfig
ln -sf "$d"/.gitignore_global ~/.gitignore_global
mkdir -p ~/.config/kak && cp kakrc ~/.config/kak/kakrc

while read -r util; do
  brew install "$util"
done < brew.list

while read -r util; do
    pip3 install "$util" --upgrade --user
done < pip.list

while read -r util; do
    GOPATH="$HOME/go" go get "$util"
done < go.list

while read -r repo; do
  git clone https://github.com/"$repo" "$HOME/repos/src/github.com/$repo"
done < repos.list
