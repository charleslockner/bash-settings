#!/bin/bash

# Set the location of your HISTFILE
export HISTFILE=$HOME/.bash_history_eternal
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Ignore commands that start with a space, exit, &, pwd, ls, and cd
export HISTIGNORE="&:[ ]*:exit:pwd:ls:cd"
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
# Just before terminal displays prompt, make sure to add last command to history
# May kill "new tab same directory" for some reason
export PROMPT_COMMAND='history -a; history -r'
# Don't let other terminal tabs overwrite history, just append
shopt -s histappend
