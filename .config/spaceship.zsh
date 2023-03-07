SPACESHIP_CHAR_SYMBOL="${SPACESHIP_CHAR_SYMBOL="$ "}"

SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_REPO=false

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  package       # Package version
  ruby          # Ruby section
  xcode         # Xcode section
  gcloud        # Google Cloud Platform section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# unused PROMPT_ORDER:
# hg            # Mercurial section (hg_branch  + hg_status)
# gradle        # Gradle section
# maven         # Maven section
# php           # PHP section
# haskell       # Haskell Stack section
# julia         # Julia section
# aws           # Amazon Web Services section
# conda         # conda virtualenv section
# pyenv         # Pyenv section
# dotnet        # .NET section
# ember         # Ember.js section
# terraform     # Terraform workspace section
# elixir        # Elixir section
# golang        # Go section
# rust          # Rust section
# docker        # Docker section
# venv          # virtualenv section
# kubectl       # Kubectl context section
# node          # Node.js section
# swift         # Swift section

SPACESHIP_RPROMPT_ORDER=(
  time
)

spaceship add async
