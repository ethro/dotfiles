#!/bin/bash

# We use Alacritty's default Linux config directory as our storage location here.
_ALACRITTY_THEMES_DIR=~/.config/alacritty/themes
mkdir -p $_ALACRITTY_THEMES_DIR
[ ! -d "$_ALACRITTY_THEMES_DIR/.git" ] && git clone https://github.com/alacritty/alacritty-theme $_ALACRITTY_THEMES_DIR

if [ ! "$(uname)" = "Linux" ]; then
	_alacritty_portable_version=v0.12.3
	_portable_filename=Alacritty-$_alacritty_portable_version-portable.exe
	_share_dir=~/.local/share/alacritty
	mkdir -p ~/.local/bin
	mkdir -p $_share_dir
	pushd $_share_dir
	wget https://github.com/alacritty/alacritty/releases/download/v0.12.3/$_portable_filename
	ln -s ~/.local/bin/$_portable_filename ~/.local/bin/alacritty.exe
	popd
fi
