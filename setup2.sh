#!/bin/bash

function usage {
	echo "Usage: $0 <mode> [options]"
	echo
	echo "Modes:"
	echo "  dev               Setup a development environment."
	echo "  virt              Setup a virtualization environment."
	echo "  llvm [VERSION]    Setup LLVM toolchain (defaults to version 20 if not specified)."
	echo "  kernel            Setup a kernel development environment."
	echo "  rust              Setup a Rust development environment."
	echo "  docker            Install and configure Docker on Ubuntu Linux."
	echo "  help              Show this message."
}

source scripts/dev.sh
source scripts/virtualization.sh
source scripts/llvm.sh
source scripts/kernel.sh
source scripts/rust.sh
source scripts/docker.sh

if [ $# -lt 1 ]; then
	usage
	exit 0
fi

MODE="$1"
shift

case "$MODE" in
"dev")
	setup_dev
	;;
"virt")
	setup_virtualization
	;;
"llvm")
	# If an argument is provided after 'llvm', treat it as the version;
	# otherwise, default to 20.
	if [ $# -gt 0 ]; then
		VERSION="$1"
	else
		VERSION="20"
	fi
	setup_llvm "$VERSION"
	;;
"kernel")
    setup_kernel_env
    ;;
"rust")
    setup_rust
    ;;
"docker")
	setup_docker
	;;
"help")
	usage
	;;
*)
	echo "Error: unknown mode '$MODE'"
	usage
	exit 1
	;;
esac

exit 0
