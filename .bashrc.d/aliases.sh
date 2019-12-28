if [[ "$OSTYPE" == "linux-gnu" ]]; then
   alias dots='git --git-dir=/home/$USER/.dotfiles/ --work-tree=/home/$USER/'

   alias tmx='tmux new-session -s main'
   alias tmxa='tmux attach'
elif [[ "$OSTYPE" == "msys" ]]; then
   alias dots='git --git-dir=/c/Users/$USERNAME/.dotfiles/ --work-tree=/c/Users/$USERNAME'
fi

alias l='ls -lh'
alias la='ls -lah'

alias df='df -h'

alias gs='git s -b --ahead-behind'

