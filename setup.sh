#!/bin/bash

# A Bash script to setup Neovim, configure dotfiles, and install ezsh from a Git repository

# Function to check if Git and curl are installed
function check_dependencies {
  required_cmds="git curl"
  for cmd in $required_cmds; do
    if ! command -v $cmd &> /dev/null; then
      echo "$cmd is not installed. Installing $cmd..."
      sudo apt-get update
      sudo apt-get install $cmd -y
    fi
  done
}

# Clone and setup ezsh
function setup_ezsh {
  if [ ! -d "ezsh" ]; then
    git clone https://github.com/jotyGill/ezsh.git
    cd ezsh
    sudo ./install.sh -c
    cd -
  else
    echo "ezsh is already cloned and set up."
  fi
}

# Clone the dotfiles repository
function clone_dotfiles {
  if [ ! -d "dotfiles" ]; then
    git clone git@github.com:vjabrayilov/dotfiles.git
  else
    echo "Dotfiles repository already cloned."
  fi
}

# Copy .p10k.zsh to the home directory
function copy_p10k {
  if [ -f "dotfiles/.p10k.zsh" ]; then
    cp dotfiles/.p10k.zsh ~/
  else
    echo ".p10k.zsh file does not exist in the repository."
  fi
}

# Set up nvim configuration
function setup_nvim {
  mkdir -p ~/.config/nvim
  if [ -d "dotfiles/.config/nvim" ]; then
    cp -r dotfiles/* ~/.config/nvim/
  else
    echo "No nvim configuration found in dotfiles."
  fi
}

# Install Neovim
function install_neovim {
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz  # Clean up the tarball after installation
  # Update .zshrc to include Neovim in PATH
  if ! grep -q "/opt/nvim/bin" ~/.zshrc; then
    echo 'export PATH="$PATH:/opt/nvim/bin"' >> ~/.zshrc
  fi
}

# Main execution sequence
check_dependencies
setup_ezsh
clone_dotfiles
copy_p10k
setup_nvim
install_neovim

echo "Setup and installation complete."

