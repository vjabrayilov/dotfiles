#!/bin/bash

# This script sets up the environment for building a Linux kernel on Ubuntu.
# It installs necessary dependencies and tools, and provides functions to download and extract the kernel source code.

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	echo "This script is intended to be sourced, not executed directly."
	exit 1
fi

function setup_kernel_env {
	echo "Updating package lists..."
	sudo apt-get update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"

	echo "Installing kernel build dependencies..."
	sudo apt-get install -y \
        autoconf \
		build-essential \
		bc \
		bison \
		ccache \
        dkms \
		dwarves \
        fakeroot \
		flex \
        gawk \
        libncurses-dev \
        libdwarf-dev \
        libdw-dev \
		libssl-dev \
		libelf-dev \
		libudev-dev \
		libpci-dev \
		libiberty-dev \
        openssl \
		wget > /dev/null 2>&1 || echo "   ❌ Error: Failed to install dependencies"

    echo "Successfully installed kernel build dependencies."
	ccache -M 10G >/dev/null 2>&1 || echo "   ❌ Error: Failed to set ccache size"
}
