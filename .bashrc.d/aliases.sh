alias l='ls -lh'
alias la='ls -lah'

alias tmx='tmux new-session -s main'
alias tmxa='tmux attach'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
   alias dots='git --git-dir=/home/$USER/.dotfiles/ --work-tree=/home/$USER/'
elif [[ "$OSTYPE" == "msys" ]]; then
   alias dots='git --git-dir=/c/Users/%USERNAME% --work-tree=/c/Users/%USERNAME%'
fi

alias gs='git s -b --ahead-behind'

