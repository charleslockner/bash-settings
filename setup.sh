#!/bin/bash


# Retrieves the current directory of this file (even though symlinks)
# https://www.reddit.com/r/vim/comments/48s8ei/if_i_open_a_file_in_vim_and_press_j_to_move_down/
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if test -f "$HOME/.bash_profile"; then
    echo "$HOME/.bash_profile already exists. Please rename your .bash_profile to .bash_profile_local and rerun. This script will create a symlink called .bash_profile in $HOME"
    exit 1
fi

touch ~/.bash_profile_local
ln -s $DIR/.bash_profile $HOME/.bash_profile
