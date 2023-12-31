_nvim_check=$(which nvim)
[ $? -eq 0 ] && export EDITOR=$(which nvim)
[ ! -d ~/.config/task ] && mkdir -p ~/.config/task
export TASKRC=~/.config/task/taskrc

if [ -d ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

export LS_COLORS=$LS_COLORS':ow=0;0;35'
