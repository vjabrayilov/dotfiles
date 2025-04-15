#!/bin/bash

if [[ "$BASH_SOURCE" == "${0}" ]]; then
	echo "This script should be sourced, not executed directly."
	exit 1
fi

function install_prerequisite {
	# --- Install system dependencies ---
	echo "📦 Installing system dependencies..."
	sudo apt update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"
	sudo apt install -y build-essential curl git pkg-config libssl-dev libclang-dev cmake >/dev/null 2>&1 || echo "   ❌ Error: Failed to install dependencies"
}

function install_rustup {
	# --- Install rustup + toolchain ---
	if ! command -v rustup >/dev/null 2>&1; then
		echo "📥 Installing rustup (Rust toolchain manager)..."
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y >/dev/null 2>&1 || {
			echo "   ❌ Error: Failed to install rustup"
			return 1
		}
	else
		echo "✅ rustup already installed."
	fi
}

function install_rust {
	# Load cargo env
	source "$HOME/.cargo/env"

	# --- Install stable toolchain and common components ---
	echo "📦 Installing stable Rust toolchain and tools..."
	rustup install stable >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to install stable toolchain"
		return 1
	}
	rustup default stable >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to set stable toolchain as default"
		return 1
	}
}

function install_dev_tools {
	# --- Install common development tools ---
	rustup component add clippy rustfmt rust-analyzer >/dev/null 2>&1

	# --- Optional: Setup nightly toolchain ---
	read -p "🌙 Do you want to install the nightly toolchain as well? [y/N]: " yn
	if [[ "$yn" =~ ^[Yy]$ ]]; then
		rustup install nightly >/dev/null 2>&1
		rustup component add clippy rustfmt rust-analyzer --toolchain nightly >/dev/null 2>&1
	fi
}

function verify {
	# --- Final checks ---
	echo "✅ Rust environment setup complete:"
	rustc --version
	cargo --version
	rustup show
	shell_name="$(basename "$SHELL")"

	echo "To reconfigure current shell, run: "
	case "$shell_name" in
	fish)
		echo 'source "$HOME/.cargo/env.fish"'
		;;
	nu)
		echo 'source "$HOME/.cargo/env.nu"'
		;;
	*)
		echo '. "$HOME/.cargo/env"   # For sh/bash/zsh/ash/dash/pdksh'
		;;
	esac
	echo "🛠️ You can now start building with Cargo!"
}

function setup_rust {
	echo "🦀 Setting up full Rust development environment..."
	install_prerequisite
	install_rustup
	install_rust
	install_dev_tools
	verify
}
