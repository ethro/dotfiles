#!/bin/bash

_rust_installed=$(which rustup)
if [ $? -eq 1 ]; then
    # Install rustup if it isn't already installed
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source ~/.bashrc

# Add git-delta

_check_for_crates="\
    bat \
    rg \
    "

_crates=""

_check_crate()
{
    _crate_check=$(which $1)
    if [ $? -eq 1 ]; then
        _crates+=" $1"
    fi
}

for _crate in $_check_for_crates
do
    _check_crate $_crate
done

if [ ! "$_crates" = "" ]; then
    cargo install $_crates
fi





_install_dir=~/.local/share
_resource_dir=~/.local/resources
mkdir -p $_install_dir
mkdir -p $_resource_dir
_fd_dir=$_resource_dir/fd
if [ ! -d $_fd_dir ]; then
    git clone https://github.com/sharkdp/fd $_fd_dir
    pushd $_fd_dir
    cargo build
    cargo install --path .
    popd
fi
