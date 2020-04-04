#!/bin/bash

remoteURL=https://github.com/ethro/dotfiles.git

cd ~/
git clone --bare $remoteURL $HOME/.dotfiles
function dots {
   git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
dots checkout
if [ $? = 0 ]; then
   echo "checkout out dotfiles."
else
	echo "Backing up pre-existing dot files."
	mkdir -p .dotfile-backup/.bashrc.d
	mkdir -p .dotfile-backup/.prefs
	mkdir -p .dotfile-backup/.vim/{colors,doc,plugin}
	dots checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfile-backup/{}
fi
dots checkout
dots config status.showUntrackedFiles no
