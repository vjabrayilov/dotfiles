
#!/bin/bash

## TODO
# - Fork ezsh and modify script not to prompt for username & password
# - Make zsh default shell
# A Bash script to setup Neovim, configure dotfiles, and install ezsh from a Git repository
#
# TODO: For dev machine we need the following
# 1. Install ezsh
# 2. Install tmux
# 3. Install neovim
# 4. Copy dotfiles

function check_dependencies {
  required_cmds="git curl stow luarocks tmux"
  for cmd in $required_cmds; do
    if ! command -v $cmd &> /dev/null; then
      echo "$cmd is not installed. Installing $cmd..."
      sudo apt-get update
      sudo apt-get install $cmd -y
    fi
  done
}

function install_ezsh {
  if [ ! -d "ezsh" ]; then
    git clone https://github.com/jotyGill/ezsh.git
    cd ezsh
    ./install.sh -c
    cd -
  else
    echo "ezsh is already cloned and set up."
  fi
}

function clone_dotfiles {
  if [ ! -d "dotfiles" ]; then
    git clone git@github.com:vjabrayilov/dotfiles.git $HOME/config
  else
    echo "Dotfiles repository already cloned."
  fi
}

function finalize {
    cp $HOME/config/.p10k.zsh ~/
    source ~/.zshrc
    echo "Setup and installation complete."
}

function install_neovim {
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz  # Clean up the tarball after installation
  if ! grep -q "/opt/nvim/bin" ~/.zshrc; then
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc
  fi
}

function setup_dev {
    check_dependencies
    install_ezsh
    install_neovim
    clone_dotfiles
    finalize
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script should be sourced, not executed directly."
    exit 1
fi
