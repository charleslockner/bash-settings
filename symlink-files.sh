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
  local dest_dir=$(dirname "$1")
  local dest_name=$(basename "$1")
  local dest_path="$dest_dir/$dest_name"
  local src_path="$DIR/$dest_name"

  if test -f "$dest_path"; then
    echo "$dest_path already exists. Please remove $dest_path and rerun. This script will create a symlink called $dest_name in $dest_dir"
    return 1
  fi

  mkdir -p $dest_dir
  ln -s $src_path $dest_path
}

# install-fzf.sh

symlink_local_file "$HOME/.bashrc"
symlink_local_file "$HOME/.tmux.conf"
symlink_local_file "$HOME/.config/nvim/init.lua"
