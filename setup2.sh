#!/bin/bash

function usage {
	echo "setup.sh <mode>"
	echo "  * dev: setup a development environment."
}

source scripts/dev.sh

if [ $# -lt 1 ] ; then
	usage
	exit 0
fi

case $1 in
	"dev")
        setup_dev ;;
	*)
		echo "Error: unknown mode was selected"
		usage
		exit 1
		;;
esac
exit 0

