## uncomment to enable zsh profiling (see bottom of file)
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZDOTDIR=$HOME/.config/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

# brew install p10k antidote zsh-syntax-highlighting zsh-autosuggestions

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

# iterm2 config: brew install iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf: brew install fzf
eval "$(fzf --zsh)"

# ruby env, rbenv: brew install rbenv ruby-build
eval "$(rbenv init - zsh)"

# # python setup: brew install pyenv pyenv-virtualenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

config_files=(
  "$HOME/.config/zsh/alias.zsh"
  "$HOME/.config/zsh/local.zsh"
  "$HOME/.github"
)

for config in ${config_files[@]}; do
  if [ -f "$config" ]; then
    . $config
  fi
done

# Preferred editor
export EDITOR=nvim

# but we force zsh to run in emacs keybinding mode
bindkey -e

# don't use less by default
export PAGER="/bin/cat"

# homebrew config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# brew install zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## uncomment to enable zsh profiling (see top of file)
# zprof