# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Before using below script,
# please configure ~/.condarc with changeps1: False

# Define colors
COL_PINK="\[\033[0;38;5;201m\]"
COL_GREEN_BOLD="\[\033[1;38;5;82m\]"
COL_LIGHT_GREEN_BOLD="\[\033[1;38;5;148m\]"
COL_LIGHT_LIME="\[\033[38;5;48m\]"
COL_LIGHT_PURPLE="\[\033[0;38;5;75m\]"
COL_YELLOW="\[\033[0;38;5;11m\]"
COL_YELLOW_BOLD="\[\033[1;38;5;11m\]"
COL_CHOCOLATE="\[\033[1;38;5;130m\]"
COL_RESET="\[\033[0m\]"
TITLEBAR="\[\033]0; TVLK \007\]"

function set_venv_prompt() {
    # For Conda
    if [ ! -z "$(basename "$CONDA_PREFIX")" ]; then
        VENV_PROMPT="${COL_PINK}(`basename "$CONDA_PREFIX"`) "
    else
        # For pipenv
        if [ ! -z "${VIRTUAL_ENV}" ] && pipenv --venv > /dev/null 2>&1; then
            VENV_PROMPT="${COL_PINK}($(basename "$(pipenv --venv)")) "
        else
            VENV_PROMPT=""
        fi
    fi
}

function set_bash_prompt() {
    set_venv_prompt

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
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
        PS1="\n${TITLEBAR}${COL_PINK}${debian_chroot:+($debian_chroot)}${VENV_PROMPT}${COL_YELLOW_BOLD}☻  ${COL_GREEN_BOLD}➙  ${COL_LIGHT_GREEN_BOLD}\w\n${COL_LIGHT_PURPLE}☛  ${COL_LIGHT_LIME}" 
    else
        PS1="\n${TITLEBAR}${debian_chroot:+($debian_chroot)}${VENV_PROMPT}☻  ➙  \w\n☛  "
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias
alias traveloka='cd $HOME/sources/traveloka'
alias junkyard='cd $HOME/sources/github/junks-lab'
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d= -f1 | xargs -n1 pip install -U"
alias pip-update-force="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d= -f1 | xargs -n1 pip install --ignore-installed -U"
alias jupyter-bg="nohup jupyter notebook > /dev/null 2>&1 &"

export TRAVELOKA_ROOT=~jeffryangtoni/traveloka
export GEN=~jeffryangtoni/traveloka/generated
ARCANIST_HOME="$TRAVELOKA_ROOT/arcanist"
export TOOLS_ROOT=/home/jeffryangtoni/tools
IDEA_HOME=/home/jeffryangtoni/tools/idea
source $TOOLS_ROOT/fixed/bashrc
source $TOOLS_ROOT/scripts/variables

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

# added by Anaconda3 installer
export PATH="/home/jeffryangtoni/anaconda3/bin:$PATH"
eval "$(register-python-argcomplete conda)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Go Lang
export GOPATH=$HOME/go
export PATH="/usr/lib/go-1.10/bin:$PATH"

# SDKMan
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Export CLASSPATH for Java
export CLASSPATH=".:${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java org.antlr.v4.gui.TestRig'

# Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Luarocks
export PATH="$HOME/.luarocks/bin:$PATH"

# Dart bin
export PATH="/usr/lib/dart/bin:$PATH"

# Flutter bin
export PATH="$HOME/flutter/bin:$PATH"

# Pipenv completion
eval "$(pipenv --completion)"

set_bash_prompt
PROMPT_COMMAND=set_bash_prompt

GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

complete -C /usr/local/bin/terraform terraform

# Get motivation
motivate | cowsay
