# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# ... and save a whole bunch of commands
export HISTFILESIZE=100000000
export HISTSIZE=100000

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*

# Projects
export PROJECTS=$HOME/projects/tixato
for project in $PROJECTS; do
  if [ -f $project/.profile ]; then
    . $project/.profile
  fi
done

export PATH=$PATH:$HOME/projects/better-console/bin:$HOME/projects/johns-toolbox
export PATH=$HOME/local/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR='mvim -f'
export GEM_EDITOR='mvim -f'

# system
if [[ $OSTYPE == darwin* ]]; then
  # copy pwd to clipboard, cd to clipboard (poor man's bookmark)
  alias pp='pwd | pbcopy'
  alias pc='cd `pbpaste`'

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  alias npm-exec='PATH=$(npm bin):$PATH'
  # export NODE_PATH=/Users/adam/node_modules
  export NODE_PATH=/usr/local/lib/node_modules
  export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
  export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

  export PATH=$PATH:/usr/local/opt/go/libexec/bin
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
  export PATH=$PATH:/Users/adam/src/go/bin

  # Brew fix for mysql
  export PATH=$PATH:$(brew --prefix mysql)/bin

  # Brew fix for mvim
  export PATH=$PATH:$(brew --prefix macvim)/bin

  # android SDK
  export PATH=$PATH:$HOME/src/android/sdk/tools

  export CDPATH=".:$HOME:$HOME/projects:$HOME/src:$HOME/projects/sketchbook"

  # ruby bin, so that VIM works properly
  export RUBY_BIN=`which ruby | sed 's/ruby$//'`

  function pt() {
    papertrail -f -d 5 $_ | colortail -g papertrail }
  }

  alias ls='ls -G'
  alias dir='ls -G --format=vertical'
  alias rgrep='rgrep --color -n'
  alias grep='grep --color -n'
  alias git=hub
  alias b='bundle exec'

  # COURSERA!
  export COURSERA_EMAIL=adam.bachman@gmail.com

  export ANDROID_SDK=/Users/adam/src/android/sdk
  export ANDROID_NDK=/Users/adam/src/android/android-ndk-r9
  export ANDROID_HOME=/Users/adam/src/android/sdk

else
  # linux

  # copy pwd to clipboard, cd to clipboard (poor man's bookmark)
  alias pp='pwd | xsel -b'
  alias pc='cd `xsel -b`'

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes
  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~} : ${HOSTNAME}\007"'
    ;;
  *)
    ;;
  esac

  # enable color support of ls and also add handy aliases
  if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls -G'
    alias dir='ls -G --format=vertical'
    alias rgrep='rgrep --color -n'
    alias grep='grep --color -n'
  fi
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

stty stop undef

# some more aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias irb='irb -r "rubygems"'
alias sz='du -cksh * | sort -rn | head -11'
alias con='script/console'
source ~/.projects

# Navigate to the root directory of the current Ruby on Rails project
rr() {
  CURRENT_PWD=`pwd`
  FAILED_RR=0
  rr_expression=^app.*config.*log.*test
  # Drop down the path until we hit a directory containing
  # "app" "config" "log" and "test"
  until [[ "$(ls)" =~ $rr_expression  ]]; do
    cd ..
    if [ $(pwd) = / ]; then
      FAILED_RR=1
      break
    fi
  done
  if [ $FAILED_RR -eq 1 ]; then
    cd $CURRENT_PWD
  else
    echo "going to `pwd`"
  fi
}

# simple functions
psgrep() {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

timestamp() {
  date +%Y%m%d%H%M%S
}

## Rake with RAILS_ENV=test
alias raket="rake RAILS_ENV=test"
alias rakec="rake RAILS_ENV=cucumber"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

## Autocomplete tasks
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
source $HOME/projects/johns-toolbox/gen-autocomplete.sh
# source ~/projects/better-console/completion/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
source ~/projects/better-console/completion/bundler-completion.sh

## COLORS
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
NONE='\e[0m'

## VCS prompt
find_svn_root() {
  if [ ! -d '.svn' ]; then
    echo "'$(pwd)' is not a working copy."
    return
  fi

  current="$(pwd)"
  while [ 1 -eq 1 ]; do
    svn info ${current}/.. 2>&1 | grep -q 'is not a working copy' && break
    current=${current}/..
  done
  echo $(cd "$current"; pwd)
}

# git prompt variables
GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
# GIT_PS1_SHOWUPSTREAM="auto"

function color_sed() {
  # Replace all color codes (e.g. ${color}) with Bash prompt escaped
  # (e.g. \[${color}\]) versions.
  echo -e "$1" | sed "s/\${txtblu}/\[${txtblu}\]/"
}

PS1="\[${bldpur}\]\A\[${NONE}\] \w \[${bldylw}\]\$(__git_ps1 '(%s)')\[${NONE}\]\n$ "
PS1="\[${txtgrn}\]\$(~/.rvm/bin/rvm-prompt)\[${NONE}\] $PS1"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
