#!/bin/bash

mkdir -p ~/.local/bin
export PATH=~/.local/bin:$PATH

if [ ! -d ~/.pyenv ]; then
	curl https://pyenv.run | bash
fi
source ~/.bashrc.d/exports.sh

_xxenv_latest_path="$(pyenv root)"/plugins/xxenv-latest
source ~/.bashrc.d/exports.sh
if [ ! -d "$_xxenv_latest_path" ]; then
	git clone https://github.com/momo-lab/xxenv-latest.git $_xxenv_latest_path
	ln -s $_xxenv_latest_path/bin/pyenv-latest ~/.local/bin/pyenv-latest
	# pyenv-latest install
	# pyenv global $(pyenv latest -k 3)
  pyenv install 3.11
	pyenv global 3.11
fi

# Use compiledb with makefiles to create a compile_commands.json file
# pip install --user compiledb
