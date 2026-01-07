#!/usr/bin/env bash
# @describe install zsh shell

eval $(argc --argc-eval "$0" "$@")

echo "setting zsh shell ..."
chsh -s /bin/zsh

