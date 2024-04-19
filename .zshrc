export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZDOTDIR=$HOME/.config/zsh

source_if_real() {
  if [ -f "$1" ]; then source "$1"; fi
}

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # https://getantidote.github.io/
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote load

  autoload -Uz promptinit && promptinit && prompt powerlevel10k

  # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
  [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

  # iterm2 config
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  # fzf
  eval "$(fzf --zsh)"
else
  eval "$(starship init zsh)"
  alias warp-test='echo "warp config active"'
fi

# must come first
source_if_real $HOME/.config/zsh/local.zsh

# python setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source_if_real $HOME/.config/zsh/alias.zsh
source_if_real $HOME/.config/zsh/nvm.zsh

# Preferred editor
export EDITOR=nvim

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/projects:$HOME/src"

# ruby env, rbenv
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
source $ZDOTDIR/nvm.zsh

# Set up NPM_TOKEN if .npmrc exists
if [ -f ~/.npmrc ]; then
  export NPM_TOKEN=$(sed -n -e '/_authToken/ s/.*\= *//p' ~/.npmrc)
fi

# but we force zsh to run in emacs keybinding mode
bindkey -e

# might be tokens, might not
source_if_real $HOME/.github
source_if_real $HOME/.jira

# don't use less by default
export PAGER="/bin/cat"

# homebrew config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# ruby env, rbenv
eval "$(rbenv init - zsh)"

# python setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
