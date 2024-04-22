eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -n "$ZSH_VERSION" -a -n "$PS1" ]; then
  if [ -f "$HOME/.config/zsh/.zshrc" ]; then
    . "$HOME/.config/zsh/.zshrc"
  fi
fi

