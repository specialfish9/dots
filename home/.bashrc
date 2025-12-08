#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vi=nvim

source /usr/share/nvm/init-nvm.sh

[[ ! -r /home/mattia/.opam/opam-init/init.zsh ]] || source /home/mattia/.opam/opam-init/init.sh  > /dev/null 2> /dev/null

alias ls='ls --color=auto'
PS1='\[\e[38;5;177m\]\u\[\e[92;1m\] at \[\e[0;38;5;123m\]\h\[\e[92;1m\] in \[\e[0;38;5;214m\]\w \[\e[0;3m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0;38;5;202;1m\]\\$\[\e[0m\] '

export PATH="$PATH:$HOME/.local/bin:$GOPATH:$HOME/tesi/Krajono/matita/matita"
export PATH="$PATH:$HOME/Tools/flutter/bin"
export PATH="$PATH:/opt/android-sdk/cmdline-tools/latest/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/Tools/clion-2024.1.1/bin"
export PATH="$PATH:~/.nix-profile/bin"
export ANDROID_HOME="$HOME/Tools/AndroidSdk"
# ACT
export PATH="$PATH:~/Tools/act/act"

toilet -f mono9 -F rainbow Edgar

source <(kubectl completion bash)
. "$HOME/.cargo/env"
