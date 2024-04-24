#!/bin/bash

## TODO
# - Fork ezsh and modify script not to prompt for username & password
# - Make zsh default shell
#
#
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
    ./install.sh -c
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

# Copy the LKV helper scripts and add alias
function copy_lkv {
    git clone git@github.com:vjabrayilov/linux-kernel-vscode.git
    cp linux-kernel-vscode/*.sh .
    rm -rf linux-kernel-vscode

    if ! grep -q "alias sudo=" ~/.zshrc; then
        echo 'alias sudo="sudo "' >> ~/.zshrc
    fi
    if ! grep -q "alias lkv=" ~/.zshrc; then
        echo 'alias lkv="bash ~/tasks.sh"' >> ~/.zshrc
    fi
}

# Install Kernel and QEMU, KVM depdenencies

function install_deps {
    sudo apt update
    sudo apt install -y gdb-multiarch ccache clang clangd llvm lld  \
    libguestfs-tools libssl-dev trace-cmd python3-pip jsonnet libelf-dev bison \
    bindfs mmdebstrap proot systemtap flex yacc bc fakeroot qemu qemu-system-x86 \
    qemu-kvm libvirt-daemon-system virt-manager
}

# Clone Kernel repo

function clone_kernel {
    git clone git@github.com:columbia/vmsched-ghost-kernel.git
}

# Main execution sequence
check_dependencies
setup_ezsh
clone_dotfiles
copy_p10k
setup_nvim
install_neovim
copy_lkv
clone_kernel

echo "Setup and installation complete."

