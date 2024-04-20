#!/bin/bash
_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_pkgs="\
    tmux \
    svn \
    git \
    "

# sudo dnf install $_pkgs
