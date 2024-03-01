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
# now in .bash-eternal-history.sh (set to unlimited)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# 	# We have color support; assume it's compliant with Ecma-48
# 	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# 	# a case would tend to support setf rather than setaf.)
# 	color_prompt=yes
#     else
# 	color_prompt=
#     fi
# fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
echo "Running .bash-eternal-history.shy"
test -f $DIR/.bash-eternal-history.sh && . $_ && echo "Finished running $_"

# Special custom bash prompt
echo "Running .bash-prompt.sh"
test -f $DIR/.bash-prompt.sh && . $_ && echo "Finished running $_"

# export NVM_DIR="/home/charles/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# . ~/.bash_profile
# source /usr/share/doc/fzf/examples/key-bindings.bash
# source /usr/share/doc/fzf/examples/completion.bash

# Get rid of annoying warning
# unset GREP_OPTIONS



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

# add this to PATH so zoxide will work
export PATH=$PATH:/home/charles/.local/bin

# Set nvim as default text editor https://stackoverflow.com/questions/66298660/how-do-i-make-neovim-my-default-text-code-editor
export EDITOR=nvim

#Add our personal private key to ssh agent
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

# Shortcuts
alias source-bash='source ~/.bashrc'
alias source-tmux='tmux source-file ~/.tmux.conf'
alias get-git-project-path='git rev-parse --show-toplevel'
alias sha="openssl dgst -sha256"
alias tmux-base='tmux attach -t base || tmux new -s base'
alias ls='ls -a'
# fortune anarchism | cowsay | lolcat

# Add zoxide to shell
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#user-content-fn-1-0482b3d36e652cf44e7f6074b87265b3
eval "$(zoxide init bash)"

echo "Current PATH: $PATH"
echo -e "*** Finished running .bashrc ***\n"
