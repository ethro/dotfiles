if [[ "$OSTYPE" == "linux-gnu" ]]; then
   alias tmx='tmux new-session -s main'
   alias tmxa='tmux attach'
fi

alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias l='ls -lh'
alias la='ls -lah'

alias df='df -h'

alias gs='git s -b --ahead-behind'

alias mdnf='sudo dnf --disablerepo=\* --enablerepo=c8-media-BaseOS,c8-media-AppStream,c8-media-extras,c8-media-epel'


