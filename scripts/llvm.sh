#!/bin/bash
# This script:
#   - Installs Clang/LLVM and associated packages for the specified VERSION
#   - Sets up update-alternatives to map 'clang', 'clang++', 'clang-format', etc.
#     to the specified version.
#   - If needed, it can be adapted to add the official LLVM repository for the
#     latest versions not in Ubuntu's default repositories.

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	echo "This script should be sourced, not executed directly."
	exit 1
fi

# Use the following lines to add the official LLVM repo
#     if the desired version is not available in your default repositories.
#     Replace 'lunar' (Ubuntu 23.04), 'mantic' (Ubuntu 23.10), etc., with your
#     actual Ubuntu codename if needed (e.g. 'lunar', 'mantic', 'noble').
#
# echo "Adding official LLVM apt repository..."
# wget https://apt.llvm.org/llvm-snapshot.gpg.key -O /tmp/llvm-snapshot.gpg.key
# sudo apt-key add /tmp/llvm-snapshot.gpg.key
# echo "deb http://apt.llvm.org/lunar/ llvm-toolchain-lunar-${VERSION} main" \
#   | sudo tee /etc/apt/sources.list.d/llvm-toolchain-${VERSION}.list
# rm /tmp/llvm-snapshot.gpg.key
#
function install_tools {
	local VERSION="$1"
	echo "Updating package lists..."
	sudo apt update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"

	echo "Installing Clang/LLVM toolchain version ${VERSION}..."
	sudo apt install -y \
		clang-${VERSION} \
		clang-tools-${VERSION} \
		lldb-${VERSION} \
		lld-${VERSION} \
		clang-format-${VERSION} \
		clang-tidy-${VERSION} \
		clangd-${VERSION} \
		llvm-${VERSION} \
		llvm-${VERSION}-dev \
		libllvm-${VERSION}-ocaml-dev \
		libc++-${VERSION}-dev \
		libc++abi-${VERSION}-dev >/dev/null 2>&1 || echo "   ❌ Error: Failed to install Clang/LLVM version ${VERSION}"
}

function configure_tools {
	local VERSION="$1"

	echo "Configuring update-alternatives for Clang/LLVM tools..."
	# clang
	sudo update-alternatives \
		--install /usr/bin/clang clang /usr/bin/clang-${VERSION} 100
	# clang++
	sudo update-alternatives \
		--install /usr/bin/clang++ clang++ /usr/bin/clang++-${VERSION} 100
	# clang-format
	sudo update-alternatives \
		--install /usr/bin/clang-format clang-format /usr/bin/clang-format-${VERSION} 100
	# clang-tidy
	sudo update-alternatives \
		--install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${VERSION} 100
	# clangd
	if [ -x "/usr/bin/clangd-${VERSION}" ]; then
		sudo update-alternatives \
			--install /usr/bin/clangd clangd /usr/bin/clangd-${VERSION} 100
	fi
	# lldb
	if [ -x "/usr/bin/lldb-${VERSION}" ]; then
		sudo update-alternatives \
			--install /usr/bin/lldb lldb /usr/bin/lldb-${VERSION} 100
	fi
	# lldb-server (if available)
	if [ -x "/usr/bin/lldb-server-${VERSION}" ]; then
		sudo update-alternatives \
			--install /usr/bin/lldb-server lldb-server /usr/bin/lldb-server-${VERSION} 100
	fi
	# lld (if available)
	if [ -x "/usr/bin/lld-${VERSION}" ]; then
		sudo update-alternatives \
			--install /usr/bin/lld lld /usr/bin/lld-${VERSION} 100
	fi
}

function verify_installation {
	local VERSION="$1"
	echo
	echo "Verifying clang installation..."
	clang --version

	echo
	echo "Verifying clang++ installation..."
	clang++ --version

	echo
	echo "Verifying clangd installation..."
	if command -v clangd >/dev/null 2>&1; then
		clangd --version
	else
		echo "clangd command not found."
	fi

	echo
	echo "LLVM/Clang version ${VERSION} installation complete!"
	echo "You can use 'update-alternatives --config clang' (etc.) to switch versions if multiple are installed."
}

function setup_llvm {
	local VERSION="$1"
	echo "Installing LLVM/Clang version: ${VERSION}"
	install_tools "${VERSION}"
	configure_tools "${VERSION}"
	verify_installation "${VERSION}"
}
