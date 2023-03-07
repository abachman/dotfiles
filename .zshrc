export PATH=$HOME/bin:/usr/local/bin:$PATH

export PAGER="/bin/cat"

source "$HOME/.github"
export HOMEBREW_NO_ANALYTICS=1

## shell features i don't want running in Warp
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # zsh plugins and prompt styling with spaceship
  source "/opt/homebrew/opt/spaceship/spaceship.zsh"
  export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship.zsh"

  # iterm2 config
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  # fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
  eval "$(starship init zsh)"
  alias warp-test='echo "warp config active"'
  # source <(/opt/homebrew/bin/starship init zsh --print-full-init)
fi

# Preferred editor
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/workspace:$HOME/src"

# ruby env, rbenv
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# place this after nvm initialization!
# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Set up NPM_TOKEN if .npmrc exists
if [ -f ~/.npmrc ]; then
  export NPM_TOKEN=`sed -n -e '/_authToken/ s/.*\= *//p' ~/.npmrc`
fi

# homebrew config
export HOMEBREW_NO_ANALYTICS=1

# commands
alias code.="code ."
alias b="bundle exec"
alias ls='ls -G'
alias dir='ls -G --format=vertical'
alias rgrep='rgrep --color -n'
alias grep='grep --color -n'
alias dc='docker-compose'

source $HOME/.projects

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# python setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Google Cloud (gcloud) PATH and shell completion
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CLOUDSDK_PYTHON=$PYENV_ROOT/shims/python
export GCLOUD_SDK="$HOME/bin/google-cloud-sdk"
if [ -f "$GCLOUD_SDK/google-cloud-sdk/path.zsh.inc" ]; then source "$GCLOUD_SDK/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$GCLOUD_SDK/google-cloud-sdk/completion.zsh.inc" ]; then source "$GCLOUD_SDK/google-cloud-sdk/completion.zsh.inc"; fi

export PATH="$GCLOUD_SDK/bin:$PATH"

source /Users/abachman/.docker/init-zsh.sh || true # Added by Docker Desktop
