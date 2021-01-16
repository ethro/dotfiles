if [[ "$OSTYPE" == "linux-gnu" ]]; then
   alias tmx='tmux new-session -s main'
   alias tmxa='tmux attach'
fi

alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ls='ls --color'
alias lsa='ls -a --color'
alias l='ls -1 --color'
alias ll='ls -lh --color'
alias la='ls -1a --color'
alias lla='ls -lah --color'

alias df='df -h'

alias gs='git s -b --ahead-behind'

alias mdnf='sudo dnf --disablerepo=\* --enablerepo=c8-media-BaseOS,c8-media-AppStream,c8-media-extras,c8-media-epel'


