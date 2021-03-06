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
alias vim='vim --servername VIM'
alias vi='vim --servername VIM'
alias v='vim --servername VIM'
alias vs='if [ -e "Session.vim" ]; then vim -S; else vim; fi'
alias m='make'
alias l='ls --color=auto'
alias e='exit'
alias x='xfce4-panel & exit'
alias c='cd'
alias t='tmux a'
alias ta='tmux a'
alias tn='tmux new -s main'
alias gl='git log --graph --pretty=format:"%h - %ar : %s"'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gs='git status'
alias gp='git push'
alias mk='mkdir'
alias jd='mv */* ./'
alias rmr='rm -r'
alias rr='rm -r'
alias ddinfo='sudo kill -USR1 $(pidof dd)'
alias sudo='sudo -E'
alias su='su -m'
alias u='yaourt -Syua --noconfirm'
alias flactomp3='parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: *.flac'
alias y='yaourt'
alias mp3='mp3gain -a *.mp3'
alias hw='inxi -Fx'

PS1='[\u@\h \W]\$ '

export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=radeonsi
export EDITOR=vim
export TERM=xterm-256color
