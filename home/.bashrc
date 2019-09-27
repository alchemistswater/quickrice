#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#eval `dircolors /home/sifr/builds/dircolors-solarized/dircolors.256dark`
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
#if [ -z "$BASH_EXECUTION_STRING" ]; then exec fish; fi
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="~/bin:~/.local/bin:$PATH"
source ~/.bashalias
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh
export EDITOR=vim
if [ -n "$DISPLAY" ]; then
    export BROWSER=surf
else 
    export BROWSER=w3m
fi
source /usr/share/bash-completion/bash_completion

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
function yta() {
	    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
    }
