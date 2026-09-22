typeset -U path PATH
path=(~/.local/bin $path)
. "$HOME/.cargo/env" 

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
