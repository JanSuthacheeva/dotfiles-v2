# ~/.zshrc — pure zsh (no oh-my-zsh, no powerlevel10k).
# Prompt is a custom single-line aurum prompt (see PROMPT below).

##--------------------------------------------------------------------------
## History
##--------------------------------------------------------------------------
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob nomatch
setopt hist_ignore_dups hist_reduce_blanks share_history
unsetopt autocd beep notify

##--------------------------------------------------------------------------
## Completion & keymap
##--------------------------------------------------------------------------
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

source ~/.fonts/*.sh
eval "$(dircolors -b ~/.dircolors)"
eval "$(starship init zsh)"

##--------------------------------------------------------------------------
## Prompt (aurum): path + git branch/dirty + chevron
##--------------------------------------------------------------------------
# # Colors: steel #849ec2 (path), pastel gold #ecd693 (branch/ok chevron),
# # terracotta #cf6a48 (dirty markers, error chevron).
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' unstagedstr '%F{#cf6a48}*'
# zstyle ':vcs_info:git:*' stagedstr '%F{#cf6a48}+'
# zstyle ':vcs_info:git:*' formats ' %F{#ecd693}%b%u%c%f'
# zstyle ':vcs_info:git:*' actionformats ' %F{#ecd693}%b|%a%u%c%f'
# precmd() { vcs_info }
# setopt prompt_subst
# PROMPT='%F{#849ec2}%~%f${vcs_info_msg_0_} %(?.%F{#ecd693}.%F{#cf6a48})❯%f '

##--------------------------------------------------------------------------
## Aliases
##--------------------------------------------------------------------------
alias ls='ls --color=auto -F'
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias glg='git log --oneline --decorate --graph'
alias pa="php artisan"
alias sail="sh $([ -f sail ] && echo sail || echo vendor/bin/sail)"
alias sa="sail artisan"

[[ -f ~/.cache/terminal-sequences ]] && cat ~/.cache/terminal-sequences
