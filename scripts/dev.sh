#!/bin/bash

# For dev machine we need the following
# 1. Install ezsh
# 2. Install tmux
# 3. Install neovim
# 4. Copy dotfiles

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	echo "This script should be sourced, not executed directly."
	exit 1
fi

function check_dependencies {
	echo "1. Checking required dependencies..."
	required_cmds=("curl" "stow" "luarocks" "tmux" "make" "gcc" "g++" "python3" "python3-venv" "fd-find" "bat")
	sudo apt-get update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"
	sudo apt-get upgrade -y >/dev/null 2>&1 || echo "   ❌ Error: Failed to upgrade package list"
	for cmd in "${required_cmds[@]}"; do
		if ! command -v "$cmd" &>/dev/null; then
			if ! [[ "$cmd" == "python3-venv" ]]; then
				echo "   🔄 Installing missing dependency: $cmd"
			fi
			sudo apt-get install -y "$cmd" >/dev/null 2>&1 || echo "   ❌ Error: Failed to install $cmd"
		fi
	done

	mkdir -p ~/.local/bin >/dev/null 2>&1 || echo "   ❌ Error: Failed to create ~/.local/bin directory"
	ln -s "$(which fdfind)" ~/.local/bin/fd
	ln -s "$(which batcat)" ~/.local/bin/bat

}

function install_ezsh {
	echo "2. Installing ezsh..."
	if [ ! -d "ezsh" ]; then
		git clone https://github.com/vjabrayilov/ezsh.git >/dev/null 2>&1 || {
			echo "   ❌ Error: Failed to clone ezsh"
			return 1
		}
	else
		echo "   ✅ ezsh is already cloned."
	fi
	cd ezsh || {
		echo "   ❌ Error: Failed to enter ezsh directory"
		return 1
	}
	git pull >/dev/null 2>&1
	./install.sh -c 2>&1 | tail -n 10
	cd - >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to return to previous directory"
		return 1
	}
	/bin/zsh -i -c build-fzf-tab-module >/dev/null 2>&1
}

function install_node {
	# Needed for Copilot in Neovim
	curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - >/dev/null 2>&1
	sudo apt install -y nodejs >/dev/null 2>&1
	node -v
	npm -v
}

function install_neovim {
	echo "3. Installing Neovim..."
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to download Neovim"
		return 1
	}
	sudo rm -rf /opt/nvim >/dev/null 2>&1
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to extract Neovim"
		return 1
	}
	rm nvim-linux-x86_64.tar.gz >/dev/null 2>&1
	if ! grep -q "/opt/nvim/bin" ~/.zshrc; then
		echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin"\" >>~/.zshrc
	fi
}

function apply_dotfiles {
	echo "4. Applying dotfiles..."
	DOTFILES_DIR="$HOME/dotfiles"
	if [ ! -d "$DOTFILES_DIR" ]; then
		echo "   ❌ Error: Dotfiles directory ($DOTFILES_DIR) not found!"
		return 1
	fi

	cd "$DOTFILES_DIR" || {
		echo "   ❌ Error: Failed to enter dotfiles directory"
		return 1
	}

	for config in nvim zsh p10k tmux; do
		stow "$config" >/dev/null 2>&1 || echo "   ❌ Error: Failed to stow $config"
	done

	cd "$HOME" || {
		echo "   ❌ Error: Failed to return to home directory"
		return 1
	}
	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		echo "   🔄 Installing tmux plugin manager..."
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	else
		echo "   ✅ Tmux plugin manager already installed."
	fi

	echo "   ✅ Dotfiles applied successfully."
}

function setup_dev {
	echo "🚀 Starting setup for the development environment..."
	check_dependencies
	install_ezsh
	install_neovim
	install_node
	apply_dotfiles
	echo "🎉 Setup and installation complete!"
}
