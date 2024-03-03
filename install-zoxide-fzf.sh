#!/bin/sh

set -x

# Install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install fzf
sudo apt install fzf