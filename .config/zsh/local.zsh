
eval "$(zoxide init zsh)"

export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# nvm 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# personal bin dir
export PATH="$BUN_INSTALL/bin:$PATH"

# dotfiles
export PATH=$HOME/projects/dotfiles/bin:$PATH

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# postgres libs
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/projects"

