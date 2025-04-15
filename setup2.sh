#!/bin/bash

function usage {
	echo "setup.sh <mode>"
	echo "  * dev: setup a development environment."
    echo "  * virt: setup a virtualization environment."
}

source scripts/dev.sh
source scripts/virtualization.sh

if [ $# -lt 1 ] ; then
	usage
	exit 0
fi

case $1 in
	"dev")
        setup_dev ;;
    "virt")
        setup_virtualization ;;
	*)
		echo "Error: unknown mode was selected"
		usage
		exit 1
		;;
esac
exit 0

