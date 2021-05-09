
echo "*** Running .bash_profile ***"

# Retrieves the current directory of this file (even though symlinks)
# https://www.reddit.com/r/vim/comments/48s8ei/if_i_open_a_file_in_vim_and_press_j_to_move_down/
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Terminal history
echo "Running eternal bash history"
test -f $DIR/.bash-eternal-history.sh && . $_ && echo "Finished running $_"

# Special custom bash prompt
echo "Running bash-prompt"
test -f $DIR/.bash-prompt.sh && . $_ && echo "Finished running $_"

# Include bash_profile_local
echo "Running local bash profile"
test -f $HOME/.bash_profile_local && . $_ && echo "Finished running $_"

# Source cargo environment
. "$HOME/.cargo/env"

# Bash rc
. "$HOME/.bashrc"

# Set Bash PATH
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin;
# export PATH=$PATH:/usr/local/opt/icu4c/lib
# export PATH=$PATH:/usr/local/opt/icu4c/bin
# export PATH=$PATH:/usr/local/opt/icu4c/sbin
# export PATH=$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
# export PATH=$PATH:/usr/local/opt/node@8/bin
# export PATH=$PATH:~/go/bin
# export PATH=$PATH:/snap/bin
# export PATH=$PATH:/usr/games
echo "PATH: $PATH"

export EDITOR=nvim

#Add our personal private key to ssh agent
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

# Shortcuts
alias source-bash='source ~/.bash_profile'
alias source-tmux='tmux source-file ~/.tmux.conf'
alias get-git-project-path='git rev-parse --show-toplevel'
alias sha="openssl dgst -sha256"
alias tmux-base='tmux attach -t base || tmux new -s base'
alias ls='ls -a'
# fortune anarchism | cowsay | lolcat

echo -e "*** Finished running .bash_profile ***\n"

