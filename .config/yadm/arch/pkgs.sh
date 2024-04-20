#!/bin/bash

_check_for_pkgs="\
    alacritty \
    arandr \
    base \
    base-devel \
    bat-extras \
    binwalk \
    bluez-utils \
    calcurse \
    cdrtools \
    cmake \
    cmus \
    conky \
    curl \
    devtools \
    dvdbackup \
    figlet \
    flashrom \
    git-delta \
    git-lfs \
    gptfdisk \
    grub \
    i3blocks \
    intel-ucode \
    libaacs \
    libreoffice-fresh \
    light \
    lightdm-slick-greeter \
    luarocks \
    man-pages \
    minicom \
    neovim \
    networkmanager \
    nfs-utils \
    ninja \
    ntfs-3g \
    nvidia \
    openocd \
    pacman-contrib \
    pavucontrol \
    picom \
    polybar \
    ranger \
    sysstat \
    unzip
    usbutils \
    vlc \
    vorbis-tools \
    wget \
    xf86-video-intel \
    xf86-video-vesa \
    xorg-bdftopcf \
    xorg-docs \
    xorg-font-util \
    xorg-fonts-100dpi \
    xorg-fonts-75dpi \
    xorg-iceauth \
    xorg-server-xnest \
    xorg-server-xvfb \
    xorg-sessreg \
    xorg-smproxy \
    xorg-x11perf \
    xorg-xbacklight \
    xorg-xcmsdb \
    xorg-xcursorgen \
    xorg-xdriinfo \
    xorg-xev \
    xorg-xgamma \
    xorg-xhost \
    xorg-xinit \
    xorg-xinput \
    xorg-xkbevd \
    xorg-xkbutils \
    xorg-xkill \
    xorg-xlsatoms \
    xorg-xlsclients \
    xorg-xpr \
    xorg-xrefresh \
    xorg-xsetroot \
    xorg-xvinfo \
    xorg-xwayland \
    xorg-xwd \
    xorg-xwud \
    "

_pkgs=""

_check_pkg() {
  pacman -Q $1 >/dev/null 2>&1
  if [ $? -eq 1 ]; then
    _pkgs+=" $1"
  fi
}

for _pkg in $_check_for_pkgs; do
  _check_pkg $_pkg
done

if [ ! "$_pkgs" = "" ]; then
  sudo pacman -Syu $_pkgs --noconfirm
fi

# Currently installed packages
# alacritty
# arandr
# base
# base-devel
# binwalk
# blender
# bluez-utils
# calcurse
# cdrtools
# cmus
# conky
# devtools
# dvdbackup
# fd
# figlet
# flashrom
# fzf
# git-lfs
# gptfdisk
# grub
# i3blocks
# intel-ucode
# libaacs
# libreoffice-fresh
# light
# lightdm-slick-greeter
# luarocks
# man-pages
# minicom
# neovim
# networkmanager
# nfs-utils
# ntfs-3g
# nvidia
# openocd
# pacman-contrib
# pavucontrol
# picom
# polybar
# prusa-slicer
# pyenv
# ranger
# ripgrep
# sweethome3d
# sysstat
# usbutils
# vi
# vlc
# vorbis-tools
# wget
# xf86-video-intel
# xf86-video-vesa
# xorg-bdftopcf
# xorg-docs
# xorg-font-util
# xorg-fonts-100dpi
# xorg-fonts-75dpi
# xorg-iceauth
# xorg-server-xnest
# xorg-server-xvfb
# xorg-sessreg
# xorg-smproxy
# xorg-x11perf
# xorg-xbacklight
# xorg-xcmsdb
# xorg-xcursorgen
# xorg-xdriinfo
# xorg-xev
# xorg-xgamma
# xorg-xhost
# xorg-xinit
# xorg-xinput
# xorg-xkbevd
# xorg-xkbutils
# xorg-xkill
# xorg-xlsatoms
# xorg-xlsclients
# xorg-xpr
# xorg-xrefresh
# xorg-xsetroot
# xorg-xvinfo
# xorg-xwayland
# xorg-xwd
# xorg-xwud
# yadm
