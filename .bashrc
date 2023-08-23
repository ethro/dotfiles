# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if ! [[ "$RUSTPATH" =~ "$HOME/.cargo/bin" ]]
then
    RUSTPATH="$HOME/.cargo/bin:$RUSTPATH"
fi
export PATH=$PATH:$RUSTPATH

if ! [[ "$GOPATH" =~ "$HOME/.config/go" ]]
then
    GOPATH="$HOME/.config/go:$GOPATH"
fi
export GOPATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

EDITOR=/usr/bin/vim
export EDITOR

# Run any shell script in ~/.bashrc.d to set up environment
for i in ~/.bashrc.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.config/fzf/fzf_source.sh ] && source ~/.config/fzf/fzf_source.sh
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
