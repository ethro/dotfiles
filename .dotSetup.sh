#!/bin/bash

git clone --bare https://github.com/ethro/dotfiles.git $HOME/.dotfiles

function dots {
   git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
}

mkdir -p .dotfile-backup
dots checkout

if [ $? = 0 ]; then
   echo "checkout out dotfiles."
else
   echo "Backing up pre-existing dot files."
   dots checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfile-backup/{}
fi

dots checkout

dots config status.showUntrackedFiles no

