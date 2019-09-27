ZSH=/usr/share/oh-my-zsh/
ZSH_CUSTOM=~/.config/zsh/
ZSH_THEME="mytheme"
DISABLE_AUTO_UPDATE="true"
FZF_BASE="/usr/share/fzf"
plugins=(
    fzf
    git
    z
    cp
    sudo
    fancy-ctrl-z
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

if [ -n "$DISPLAY" ]; then
    export BROWSER=surf
else 
    export BROWSER=w3m
fi

alias accio='sudo bb-wrapper -S --aur '
alias erised='bb-wrapper -Ss --aur '
alias ascendio='sudo bb-wrapper -Syu --aur '
alias vim='vis'
alias vi='vis'
alias nvim='vis'

[[ -f "$ZSH/oh-my-zsh.sh" ]] \
	&& source $ZSH/oh-my-zsh.sh

[[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
    && source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

[[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
    && source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
