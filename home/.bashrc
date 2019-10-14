#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source <(kitty + complete setup bash)
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

PS1='[\u@\h \W]\$ '
export PATH="~/bin:~/.local/bin:$PATH"
source ~/.bashalias
export EDITOR=vis

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=lynx
fi

#source /usr/share/bash-completion/bash_completion

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
function yta() {
	    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
    }
