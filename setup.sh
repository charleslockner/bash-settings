#!/bin/bash

set -x

# Retrieves the current directory of this file (even though symlinks)
# https://www.reddit.com/r/vim/comments/48s8ei/if_i_open_a_file_in_vim_and_press_j_to_move_down/
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Function to create symlink in home directory of a file contained in this repo
function symlink_local_file {
  local file_dir=$(dirname "$1")
  local file_name=$(basename "$1")
  local sym_dest="$file_dir/$file_name"
  local sym_src="$DIR/$file_name"
  local local_file_name=$file_name"_local"
  local local_file="$file_dir/$local_file_name"

  if test -f "$sym_dest"; then
    echo "$sym_dest already exists. Please rename your $file_name to $local_file_name and rerun. This script will create a symlink called $file_name in $file_dir"
    return 1
  fi

  mkdir -p $file_dir
  ln -s $sym_src $sym_dest
}

# install-fzf.sh

symlink_local_file "$HOME/.bashrc"
# symlink_local_file "$HOME/.tmux.conf"
symlink_local_file "$HOME/.config/nvim/init.vim"
symlink_local_file "$HOME/.vimrc"
