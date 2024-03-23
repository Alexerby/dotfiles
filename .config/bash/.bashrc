# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/aleri/.oh-my-bash'
OSH_THEME="powerline"

OMB_USE_SUDO=true
completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

source "$OSH"/oh-my-bash.sh
source /etc/profile.d/bash_completion.sh

# Aliases
alias ls='exa --icons -a'
alias tre="exa --tree --icons"

alias python="python3"
