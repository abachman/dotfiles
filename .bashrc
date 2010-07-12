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

if [[ -s /home/adam/.rvm/scripts/rvm ]] ; then source /home/adam/.rvm/scripts/rvm ; fi

# REE tuning
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=1000000

export PATH=$PATH:/home/adam/tools/flex_sdk_4/bin:/home/adam/bin:
export PATH=$PATH:/home/adam/projects/better-console/sls-svn:/home/adam/projects/better-console/bin
export PATH=$PATH:/home/adam/src/nicks-toolbox:/home/adam/src/johns-toolbox
export PATH=$PATH:/home/adam/src/flash_player_10_linux_dev/standalone/debugger
export SDL_audiodriver=alsa
export EDITOR=vim
export GEM_EDITOR=vim

# JAVA NONSENSE
export ANT_HOME=/usr/share/ant
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/jre
export JAVA_VERSION=1.6
export FLEX_HOME=/home/adam/tools/flex_sdk_4
# export RED5_HOME=/usr/lib/red5
# export PUREMVC_HOME=/home/adam/src/PureMVC_AS3_2_0_4/bin
# export DEGRAFA_HOME=/home/adam/src/Degrafa_Beta3.1_Flex3

# freetds, odbc, sql server from linux connector
export TDSDUMP=/tmp/freetds.log

# command line friendly: $ svn co $svn/project/trunk
export svn=https://svn.slsdev.net

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias dir='ls --color=auto --format=vertical'
  alias rgrep='rgrep --color --exclude-dir=.svn'
  alias grep='grep --color --exclude-dir=.svn'
  alias rgrepn='rgrep -n --color --exclude-dir=.svn'
  alias grepn='grep -n --color --exclude-dir=.svn'
fi

# some more aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias irb='irb -r "rubygems"'
alias sz='du -cksh * | sort -rn | head -11'
alias con='script/console'

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

# Go to the directory pointed to by my current project.
current() {
  cd $(readlink -f /home/adam/workspace/psl/current)
}

# simple functions
psgrep() {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# copy pwd to clipboard, cd to clipboard (poor man's bookmark)
alias pp='pwd | xsel -b'
alias pc='cd `xsel -b`'

## Rake with RAILS_ENV=test
alias raket="rake RAILS_ENV=test"
alias rakec="rake RAILS_ENV=cucumber"

# color diffs for SVN
function svn-diff () {
  if [ "$1" != "" ]; then
    svn diff $@ | colordiff;
  else
    svn diff | colordiff;
  fi
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## Autocomplete tasks
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
source ~/src/johns-toolbox/gen-autocomplete.sh

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

ps_scm_f() {
  _VCS=
  local s=
  if [[ -d ".svn" ]] ; then
    local r=$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )
    local root=$(find_svn_root)
    local mod_symbol=$(svn status --ignore-externals | grep -v '^?' | grep -q -v '^X' && echo -n "⚡" )
    local num_mod=$(svn st $root | grep -c ^M)
    local num_add=$(svn st $root | grep -c ^A)
    local num_del=$(svn st $root | grep -c ^D)
    if [ -n "$mod_symbol" ]; then
      s="(${r} ${num_mod} ${num_add} ${num_del} ${mod_symbol})"
    else
      s="(${r})"
    fi
  else
    local d=$(git rev-parse --git-dir 2>/dev/null ) b= r= a=
    if [[ -n "${d}" ]] ; then
      if [[ -d "${d}/../.dotest" ]] ; then
        if [[ -f "${d}/../.dotest/rebase" ]] ; then
          r="rebase"
        elif [[ -f "${d}/../.dotest/applying" ]] ; then
          r="am"
        else
          r="???"
        fi
        b=$(git symbolic-ref HEAD 2>/dev/null )
      elif [[ -f "${d}/.dotest-merge/interactive" ]] ; then
        r="rebase-i"
        b=$(<${d}/.dotest-merge/head-name)
      elif [[ -d "${d}/../.dotest-merge" ]] ; then
        r="rebase-m"
        b=$(<${d}/.dotest-merge/head-name)
      elif [[ -f "${d}/MERGE_HEAD" ]] ; then
        r="merge"
        b=$(git symbolic-ref HEAD 2>/dev/null )
      elif [[ -f "${d}/BISECT_LOG" ]] ; then
        r="bisect"
        b=$(git symbolic-ref HEAD 2>/dev/null )"???"
      else
        r=""
        b=$(git symbolic-ref HEAD 2>/dev/null )
      fi

      if git status | grep -q '^# Changed but not updated:' ; then
        a="${a}⚡"
      fi

      if git status | grep -q '^# Changes to be committed:' ; then
        a="${a}+"
      fi

      if git status | grep -q '^# Untracked files:' ; then
        a="${a}?"
      fi

      b=${b#refs/heads/}
      b=${b// }
      [[ -n "${r}${b}${a}" ]] && s="(${r:+${r}:}${b}${a:+ ${a}})"
    fi
  fi
  s="${s}${ACTIVE_COMPILER}"
  s="${s:+${s}}"
  _VCS=$s
  echo -en $s # (eval "echo \"$_VCS\"")
}

function color_sed() {
  # Replace all color codes (e.g. ${color}) with Bash prompt escaped
  # (e.g. \[${color}\]) versions.
  echo -e "$1" | sed "s/\${txtblu}/\[${txtblu}\]/"
}

PS1="\[${txtgrn}\$(~/.rvm/bin/rvm-prompt)${NONE}\] \[${bldpur}\]\A\[${NONE}\] \w \[${bldylw}\]\$(ps_scm_f)\[${NONE}\]\n$ "
