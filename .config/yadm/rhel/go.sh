#!/bin/bash

_GO_VERSION=1.21.1

if [ ! -f ~/.local/bin/go ]; then
	_tarball_name=go$_GO_VERSION.linux-amd64.tar.gz
	_install_dir=~/.local/share
	_resource_dir=~/.local/resources
	mkdir -p $_install_dir
	mkdir -p $_resource_dir
	pushd $_resource_dir
	curl -LO https://go.dev/dl/$_tarball_name
	tar -C $_install_dir -xzf $_tarball_name
	ln -s $_install_dir/go/bin/go ~/.local/bin/go
	ln -s $_install_dir/go/bin/gofmt ~/.local/bin/gofmt
	popd
fi

_fzf_installed=$(which fzf)
if [ $? -eq 1 ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	echo 'y\ny\ny\n' | ~/.fzf/install
fi
