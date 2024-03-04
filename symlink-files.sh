#!/bin/bash

# Print out all commands as they are run
# set -x

# Stop script if any command fails
set -e

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
  if [ $# -eq 1 ]; then
    local rel_dest_path=$1
  else
    local rel_dest_path=$2
  fi

  local dest_dir=$(dirname "$rel_dest_path")
  local file_name=$(basename "$rel_dest_path")
  local abs_dest_path=$dest_dir/$file_name

  if [ $# -eq 1 ]; then
      local rel_src_path="$DIR/$file_name"
    else
      local rel_src_path=$1
  fi

  local abs_src_path=$(readlink -f "$rel_src_path")
  # local src_dir=$(dirname "$rel_src_path")

  echo "dest_path $abs_dest_path"
  echo "src_path $abs_src_path"

  if test -L "$abs_dest_path"; then
    echo Symbolic link at "$abs_dest_path that points to $abs_src_path already exists. Please remove it if it should point somewhere else"
    return 0
  fi

  if test -f "$abs_dest_path"; then
    echo "File $abs_dest_path already exists. Please remove it so that a new symlink for $abs_src_path may be added"
    return 0
  fi

  if test -d "$abs_dest_path"; then
    echo "Directory $abs_dest_path already exists. Please remove $abs_dest_path so that a symlink for $abs_src_path may be added"
    return 0
  fi
  
  mkdir -p $dest_dir
  ln -s $abs_src_path $abs_dest_path
  echo "Symbolic link $abs_dest_path created that points to $abs_src_path"
}

# install-fzf.sh

symlink_local_file "$HOME/.bashrc"
symlink_local_file "$HOME/.tmux.conf"
symlink_local_file "$HOME/.fonts/JetBrainsMono"
# nvim config
symlink_local_file "NvChad/init.lua" "$HOME/.config/nvim/init.lua"
symlink_local_file "NvChad/lua" "$HOME/.config/nvim/lua"
