#!/usr/bin/env bash
#
# Description:
# * Modify bash prompt with simple format
# * Detect conda environment
# 
# Usage:
# * Just source it inside your .bashrc
#
# Note:
# This script is not perfect. But it is ok for learning.
#
# Changelog:
# 20180504 ~> currently merged into .bashrc because shell prompt is not changed to git shell prompt when changing
#             into git directory.

# Define colors
COL_PINK="\[\033[0;38;5;201m\]"
COL_GREEN_BOLD="\[\033[1;38;5;82m\]"
COL_LIGHT_GREEN_BOLD="\[\033[1;38;5;148m\]"
COL_LIGHT_PURPLE="\[\033[0;38;5;75m\]"
COL_YELLOW="\[\033[0;38;5;11m\]"
COL_RESET="\[\033[0m\]"

function set_conda_prompt() {
    if [ -z `basename "$CONDA_PREFIX"` ]; then
        CONDA_PROMPT=""
    else
        CONDA_PROMPT="${COL_PINK}(`basename "$CONDA_PREFIX"`) "
    fi
}

function set_bash_prompt() {

    set_conda_prompt

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
        PS1="${COL_PINK}${debian_chroot:+($debian_chroot)}${CONDA_PROMPT}${COL_GREEN_BOLD}at ${COL_LIGHT_GREEN_BOLD}\w\n${COL_LIGHT_PURPLE}$ ${COL_YELLOW}"    
    else
        PS1="${debian_chroot:+($debian_chroot)}${CONDA_PROMPT}at \w\n$ "
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

function switch_bash_prompt() {
    printf "\n"
    if git branch > /dev/null 2>&1; then
        # Git Bash Prompt
        GIT_PROMPT_ONLY_IN_REPO=1
        source ~/.bash-git-prompt/gitprompt.sh
    else
        set_bash_prompt
    fi
}

PROMPT_COMMAND=switch_bash_prompt
