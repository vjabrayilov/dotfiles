#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script should be sourced, not executed directly."
    exit 1
fi

function install_dependencies {
    echo "1. Installing required dependencies..."
    deps=("virtme-ng qemu-system-x86" "qemu-kvm" "libvirt-daemon-system" "libguestfs-tools" "virt-manager")
    sudo apt-get update > /dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"
    sudo apt-get upgrade -y > /dev/null 2>&1 || echo "   ❌ Error: Failed to upgrade package list"
    for dep in "${deps[@]}"; do
        if ! dpkg -l | grep -q "$dep"; then
            echo "   🔄 Installing missing dependency: $dep"
            sudo apt-get install -y "$dep" > /dev/null 2>&1 || echo "   ❌ Error: Failed to install $dep"
        else
            echo "   ✅ $dep is already installed."
        fi
    done
}

function setup_virtualization {
    echo "Setting up a virtualization environment..."
    install_dependencies
    sudo usermod -aG libvirt,kvm $USER
    echo "After reboot, check kvm-ok and virt-host-validate"
}
