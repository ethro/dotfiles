#!/bin/bash

_install_dir=~/.local/share
mkdir -p $_install_dir

_fim_installed=$(which fim)
if [ $? -eq 1 ]; then
    if [ -d $_install_dir/fim/ ]; then
        rm -rf $_install_dir/fim
    fi
    if [ ! -d $_install_dir/fim/ ]; then
        pushd $_install_dir
        svn export http://svn.savannah.nongnu.org/svn/fbi-improved/trunk fim
        popd
        ln -s $_install_dir/fim/... ~/.local/bin/fim
    fi
fi
