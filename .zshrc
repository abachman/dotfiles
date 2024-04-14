export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/projects/dotfiles/bin:$PATH

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # https://getantidote.github.io/
  export ZDOTDIR=$HOME/.config/zsh
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

# Preferred editor
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/projects:$HOME/src"

# ruby env, rbenv
command -v rbenv >/dev/null || eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Set up NPM_TOKEN if .npmrc exists
if [ -f ~/.npmrc ]; then
  export NPM_TOKEN=$(sed -n -e '/_authToken/ s/.*\= *//p' ~/.npmrc)
fi

# might be tokens, might not
source "$HOME/.github"

# don't use less by default
export PAGER="/bin/cat"

# homebrew config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# commands
alias code.="code ."
alias b="bundle exec"
alias ls='ls -G'
alias dir='ls -G --format=vertical'
alias rgrep='rgrep --color -n'
alias grep='grep --color -n'
alias dc='docker-compose'

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# python setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || eval "$(pyenv init -)"
