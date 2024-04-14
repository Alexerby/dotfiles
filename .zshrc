# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.GA
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# Paths
export PATH="$HOME/bin:$PATH"

plugins=(git)

# source $ZSH/oh-my-zsh.sh

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Aliases
alias ls='exa --icons'
alias tre="exa --tree --icons"

alias python="python3"
alias vim="nvim"
alias cat="batcat"


typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


