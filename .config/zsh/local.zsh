
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# personal bin dir
export PATH="$BUN_INSTALL/bin:$PATH"

# dotfiles
export PATH=$HOME/projects/dotfiles/bin:$PATH

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# postgres libs
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/projects"
