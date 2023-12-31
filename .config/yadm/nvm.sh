#!/bin/bash

_NVM_VERSION=v0.39.5

[ ! -f ~/.nvm/nvm.sh ] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$_NVM_VERSION/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
source ~/.bashrc
_node_installed=$(which node)
if [ $? -eq 1 ]; then
	nvm install node
fi
