# ------------------------------------------------------------------------------
# P10K INSTANT PROMPT
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# OH-MY-ZSH & THEME
# ------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ ! -d "$ZSH/custom/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH/custom/themes/powerlevel10k"
fi

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"


# ------------------------------------------------------------------------------
# TMUX
# ------------------------------------------------------------------------------
TMUX_PLUGINS_DIR="$HOME/.tmux/plugins"
TMUX_PLUGINS="tmux-plugins/tpm,vaaleyard/tmux-dotbar"

mkdir -p "$TMUX_PLUGINS_DIR"

for plugin in ${(s:,:)TMUX_PLUGINS}; do
    plugin_name=${plugin#*/}
    
    if [[ ! -d "$TMUX_PLUGINS_DIR/$plugin_name" ]]; then
        printf "Cloning %s...\n" "$plugin_name"
        git clone "https://github.com/$plugin" "$TMUX_PLUGINS_DIR/$plugin_name"
    fi
done



# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES & PATHS
# ------------------------------------------------------------------------------
typeset -U path
path=(
  "$HOME/.local/bin"
  "/usr/local/texlive/2025/bin/x86_64-linux"
  "/usr/local/stata/"
  "$HOME/bin"
  $path
)
export PATH

export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

export NVM_DIR="$HOME/.config/nvm"
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
sz() {
  if zsh -n "$HOME/.zshrc"; then
    source "$HOME/.zshrc"
    echo "🚀 Zsh configuration reloaded!"
  else
    echo "❌ Syntax error in .zshrc. Reload aborted."
    return 1
  fi
}

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

# ------------------------------------------------------------------------------
# Sourcing
# ------------------------------------------------------------------------------
if [[ ! -d "$ZSH/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH/plugins/zsh-autosuggestions"
fi
source "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

if [[ ! -d "$ZSH/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH/plugins/zsh-syntax-highlighting"
fi
source "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
