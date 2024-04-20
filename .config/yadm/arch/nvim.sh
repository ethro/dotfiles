#!/bin/bash
_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ ! -f ~/.local/bin/getnf ]; then
	pushd ~/.local/share/
	git clone https://github.com/ronniedroid/getnf.git
	pushd getnf
	./install.sh
	popd
	popd
fi

if [ -f ~/.local/bin/getnf ]; then
	echo 14 | getnf
fi

if [ ! -f ~/.local/bin/nvim ]; then
	_install_dir=~/.local/share
	_resource_dir=~/.local/resources
	mkdir -p $_install_dir
	mkdir -p $_resource_dir

	pushd $_resource_dir
	[ -f nvim.appimage ] && rm nvim.appimage
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	[ -d squashfs-root ] && rm -rf squashfs-root
	./nvim.appimage --appimage-extract
	./squashfs-root/AppRun --version
	popd
	ln -s $_resource_dir/squashfs-root/AppRun ~/.local/bin/nvim
fi

# Check for and setup the expected venv for nvim
if [ ! -d ~/.local/venv/nvim ]; then
	mkdir -p ~/.local/venv
	# Add check to make sure i get the python3 version i want...
	pushd ~/.local/venv
	python3 -m venv nvim
	source nvim/bin/activate
	pip install debugpy isort black flake8
	deactivate
	popd
fi
