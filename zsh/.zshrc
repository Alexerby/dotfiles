# ------------------------------------------------------------------------------
# P10K INSTANT PROMPT
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 2. CORE OH-MY-ZSH & THEME CONFIG
# ------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Oh My Zsh (if you use it) or just the theme
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES & PATHS
# ------------------------------------------------------------------------------
# Use a unique array to prevent duplicate paths when sourcing multiple times
typeset -U path
path=(
  "$HOME/.local/bin"
  "/usr/local/texlive/2025/bin/x86_64-linux"
  "/usr/local/stata/"
  "$HOME/bin"
  $path
)
export PATH

# NVM Initialization
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ------------------------------------------------------------------------------
# PYTHON WORKFLOW FUNCTIONS
# ------------------------------------------------------------------------------
pav() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "⚠️  A virtual environment is already active: $(basename "$VIRTUAL_ENV")"
    return 0
  fi

  local names=(".venv" "venv" "env" "virtualenv")
  for name in "${names[@]}"; do
    if [[ -f "$name/bin/activate" ]]; then
      if source "$name/bin/activate"; then
        echo "✅ Success: Activated '$name'"
        return 0
      fi
    fi
  done

  echo "🔍 No venv found. Checked: ${names[*]}"
  return 1
}

pdv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local name=$(basename "$VIRTUAL_ENV")
    deactivate
    echo "👋 Deactivated: $name"
  else
    echo "ℹ️  No virtual environment active."
  fi
}

# ------------------------------------------------------------------------------
# SHELL UTILS & ALIASES
# ------------------------------------------------------------------------------
# System Reload
sz() {
  if zsh -n "$HOME/.zshrc"; then
    source "$HOME/.zshrc"
    echo "🚀 Zsh configuration reloaded!"
  else
    echo "❌ Syntax error in .zshrc. Reload aborted."
    return 1
  fi
}

# General Aliases
alias vim="nvim"
alias python="python3"
alias ls="eza --icons"
alias tree="eza -T --icons"
alias xclipp="xclip -selection clipboard"
alias ta="tmux a"
alias cpwd="pwd | xclip -selection clipboard"
alias cb="xclip -selection clipboard"

# ------------------------------------------------------------------------------
# KEYBINDINGS
# ------------------------------------------------------------------------------
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
