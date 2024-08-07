# work settings on the work machine, personal settings on the personal machine
export PATH="$HOME/workspace/dotfiles/bin:$PATH"
export PATH="$HOME/workspace/developer-setup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH" # poetry
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# don't need to navigate to ~/ to cd into Downloads, etc.
export CDPATH=".:$HOME:$HOME/workspace:$HOME/src"

# add local completions
fpath=(~/.config/zshrc/completions $fpath)

source $ZDOTDIR/recurly.zsh

# Google Cloud SDK.
export GCLOUD_SDK=$HOME/src/google-cloud-sdk
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CLOUDSDK_PYTHON=$PYENV_ROOT/shims/python
if [ -f "$GCLOUD_SDK/path.zsh.inc" ]; then . "$GCLOUD_SDK/path.zsh.inc"; fi
if [ -f "$GCLOUD_SDK/completion.zsh.inc" ]; then . "$GCLOUD_SDK/completion.zsh.inc"; fi

# z command, a smart cd replacement: https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
