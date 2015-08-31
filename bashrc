#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias lsl='ls -l --color=auto'
alias la='ls -a --color=auto'
alias lal='ls -al --color=auto'
alias lla='ls -al --color=auto'
alias gcc='gcc -Wall'
alias vi='vim'
alias v='vim'
alias m='make'
alias l='ls --color=auto'
alias e='exit'
alias x='xfce4-panel & exit'
alias c='cd'
alias t='tmux a'
alias ta='tmux a'
alias tn='tmux new -s main'
alias mk='mkdir'
alias jd='mv */* ./'
alias rmr='rm -r'
alias rr='rm -r'
alias ddinfo='sudo kill -USR1 $(pidof dd)'
alias sudo='sudo -E'
alias su='su -m'
alias update='yaourt -Syua --noconfirm'
alias updatee='yaourt -Syua --noconfirm && exit'
alias u='yaourt -Syua --noconfirm'
alias ue='yaourt -Syua --noconfirm && exit'
alias flactomp3='parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: *.flac'
alias y='yaourt'

PS1='[\u@\h \W]\$ '

export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=radeonsi
export EDITOR=vim
export TERM=xterm-256color
