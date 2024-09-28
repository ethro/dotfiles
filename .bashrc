# .bashrc

# Source global definitions
# Arch based
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi
# Fedora based
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [ -d "$HOME/.local/bin" ]; then
    mkdir -p "$HOME/.local/bin"
fi
if ! [[ "$PATH" =~ $HOME/.local/bin: ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

if ! [[ "$RUSTPATH" =~ $HOME/.cargo/bin ]]; then
    RUSTPATH="$HOME/.cargo/bin:$RUSTPATH"
fi
export PATH=$PATH:$RUSTPATH
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if ! [[ "$GOPATH" =~ $HOME/.config/go ]]; then
    GOPATH="$HOME/.config/go:$GOPATH"
fi
export GOPATH
export PATH=$PATH:$HOME/.config/go/bin

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
EDITOR=/usr/bin/nvim
export EDITOR

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
[ -f "$HOME/.config/fzf/fzf_source.sh" ] && source "$HOME/.config/fzf/fzf_source.sh"

if ! [[ "$PATH" =~ $HOME/go/bin: ]]; then
    PATH="$HOME/go/bin:$PATH"
fi
export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
