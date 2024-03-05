#!/bin/bash

# Start of color definitions

export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBx

NORM=0
BOLD=1
DIM=2
UNDER=4
BLINK=5

NO_COLOR='0'
BLACK='30'
RED='31'
GREEN='32'
YELLOW='33'
BLUE='34'
MAGENTA='35'
CYAN='36'
GRAY='37'
SILVER='38'
DEFAULT='39'
WHITE='97'

# export COLOR_OCHRE='\033[38;5;95m'

# Bash prompt helper functions

function date_major_color {
  echo -e "\001\033[${NORM};${BOLD};${MAGENTA}m\002"
}

function date_minor_color {
  echo -e "\001\033[${NORM};${BOLD};${DIM};${MAGENTA}m\002"
}

function user_color {
  if [ $UID -eq "0" ]; then
    echo -e "\001\033[${NORM};${BOLD};${RED}m\002" # root's color
  else
    echo -e "\001\033[${NORM};${BOLD};${CYAN}m\002" # regular user's color
  fi
}

function pwd_path_color {
  echo -e "\001\033[${BOLD};${YELLOW}m\002"
}

function git_path_color {
  echo -e "\001\033[${NORM};${BOLD};${GRAY}m\002"
}

function git_branch_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "nothing to commit" ]]; then
    echo -e "\001\033[${NORM};${BOLD};${GREEN}m\002"
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e "\001\033[${NORM};${BOLD};${YELLOW}m\002"
  elif [[ $git_status =~ "You have unmerged paths." ]]; then
    echo -e "\001\033[${NORM};${BOLD};${PURPLE}m\002"
  else
    echo -e "\001\033[${NORM};${BOLD};${RED}m\002"
  fi
}

function arrow_color { echo -e "\001\033[${NORM};${BOLD};${GREEN}m\002"
}

function default_color {
  echo -e "\001\033[${NORM};${NO_COLOR}m\002"
}

function prompt_date {
  local MAC=$(date_major_color)
  local MNC=$(date_minor_color)
  local weekday=$(date "+%a")
  local day=$(date "+%d")
  local month=$(date "+%b")
  local year=$(date "+%Y")
  local hour=$(date "+%H")
  local minute=$(date "+%M")
  local second=$(date "+%S")
  echo -e "$MNC[$MAC$weekday $MAC$month $day$MNC]"
}

function prompt_user {
  echo -e "$(user_color)$USER"
}

function in_git_dir {
  git rev-parse --git-dir > /dev/null 2>&1
}

function prompt_path {
  local pwd_path="${PWD}"

  if ! in_git_dir; then
    echo "$(pwd_path_color)$pwd_path"
  else
    local base_path="$(git rev-parse --show-toplevel)"
    local escaped_path="$(echo -e ${base_path//\//\\/})"
    local git_path=`echo -e $pwd_path | sed "s/&*\$escaped_path//g"`
    
    local pwd="$(pwd_path_color)$base_path"
    local git="$(git_path_color)$git_path"

    echo -e "$pwd$git"
  fi
}

function prompt_git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo -e "$(git_branch_color)[$branch]"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo -e "$(git_branch_color)[$commit]"
  else
    echo -e ""
  fi
}

function prompt_arrow {
  echo -e "$(arrow_color)⤵$(default_color) "
}

# Bash prompt
export PS1='\n$(prompt_user) $(prompt_path) $(prompt_git_branch) $(prompt_arrow)\n' 

