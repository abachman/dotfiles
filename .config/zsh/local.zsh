
eval "$(zoxide init zsh)"

# export BUN_INSTALL="$HOME/.bun"
# [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
[ -s "/Users/adambachman/.bun/_bun" ] && source "/Users/adambachman/.bun/_bun"

# # nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# personal bin dirs
export PATH="$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/projects/dotfiles/bin:$PATH

# java
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# postgres libs
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# # python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/projects"

# ~/.zprofile
eval "$(mise activate zsh --shims)"

# iterm2 compatible keyboard controls
bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

t() {
  if [ -d "$PWD/tmp/bin" ]; then
    echo 'PATH includes tmp/bin'
    export PATH="$PWD/tmp/bin:$PATH"
  else
    echo 'no tmp/bin directory found'
  fi
}
