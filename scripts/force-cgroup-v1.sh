#!/bin/bash

set -e

echo "🔧 Forcing system to use cgroup v1..."

# 1. Update GRUB default config
echo "📦 Updating /etc/default/grub..."
sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub
# Force cgroup v1 by setting the appropriate kernel parameters
echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash systemd.unified_cgroup_hierarchy=0 systemd.legacy_systemd_cgroup_controller=yes"' | sudo tee -a /etc/default/grub > /dev/null

# 2. Update GRUB
echo "🔄 Running update-grub..."
sudo update-grub

# 3. Configure systemd to use legacy hierarchy
echo "🧠 Creating /etc/systemd/cgroup.conf..."
sudo mkdir -p /etc/systemd
echo -e "[Manager]\nDefaultHierarchy=legacy" | sudo tee /etc/systemd/cgroup.conf > /dev/null

# 4. Rebuild initramfs
echo "⚙️ Updating initramfs..."
sudo update-initramfs -u

# 5. Reboot prompt
echo "✅ All done! Ready to reboot for changes to take effect."

read -p "👉 Reboot now? [y/N]: " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "🚀 Rebooting..."
    sudo reboot
else
    echo "⚠️ Please reboot manually to apply the changes."
fi

