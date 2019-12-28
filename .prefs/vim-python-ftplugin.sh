#!/bin/bash

if [ "$OSTYPE" = "msys" ]; then
   sed -i 's/setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8/setlocal expandtab shiftwidth=3 softtabstop=3 tabstop=3/g' /usr/share/vim/vim81/ftplugin/python.vim
fi
