#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	echo "This script should be sourced, not executed directly."
	exit 1
fi

function remove_old_docker {
	echo "1. Removing old Docker packages..."
	old_packages=("docker.io" "docker-doc" "docker-compose" "docker-compose-v2" "podman-docker" "containerd" "runc")
	for package in "${old_packages[@]}"; do
		if dpkg -l | grep -q "$package"; then
			echo "   🔄 Removing old package: $package"
			sudo apt-get remove -y "$package" >/dev/null 2>&1 || echo "   ❌ Error: Failed to remove $package"
		fi
	done
}

function install_docker_prerequisites {
	echo "2. Installing Docker prerequisites..."
	prereqs=("ca-certificates" "curl" "gnupg" "lsb-release")
	sudo apt-get update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list"
	for prereq in "${prereqs[@]}"; do
		if ! dpkg -l | grep -q "$prereq"; then
			echo "   🔄 Installing prerequisite: $prereq"
			sudo apt-get install -y "$prereq" >/dev/null 2>&1 || echo "   ❌ Error: Failed to install $prereq"
		else
			echo "   ✅ $prereq is already installed."
		fi
	done
}

function add_docker_repository {
	echo "3. Adding Docker's official GPG key and repository..."
	
	# Create directory for Docker GPG key
	sudo install -m 0755 -d /etc/apt/keyrings >/dev/null 2>&1
	
	# Download and add Docker's GPG key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to download Docker GPG key"
		return 1
	}
	sudo chmod a+r /etc/apt/keyrings/docker.gpg >/dev/null 2>&1
	
	# Add Docker repository
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to add Docker repository"
		return 1
	}
	
	sudo apt-get update >/dev/null 2>&1 || echo "   ❌ Error: Failed to update package list after adding repository"
	echo "   ✅ Docker repository added successfully."
}

function install_docker_engine {
	echo "4. Installing Docker Engine..."
	docker_packages=("docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin")
	for package in "${docker_packages[@]}"; do
		if ! dpkg -l | grep -q "$package"; then
			echo "   🔄 Installing Docker package: $package"
			sudo apt-get install -y "$package" >/dev/null 2>&1 || echo "   ❌ Error: Failed to install $package"
		else
			echo "   ✅ $package is already installed."
		fi
	done
}

function configure_docker {
	echo "5. Configuring Docker..."
	
	# Add current user to docker group
	sudo usermod -aG docker "$USER" >/dev/null 2>&1 || {
		echo "   ❌ Error: Failed to add user to docker group"
		return 1
	}
	echo "   ✅ User $USER added to docker group."
	
	# Enable and start Docker service
	sudo systemctl enable docker >/dev/null 2>&1 || echo "   ❌ Error: Failed to enable Docker service"
	sudo systemctl start docker >/dev/null 2>&1 || echo "   ❌ Error: Failed to start Docker service"
	echo "   ✅ Docker service enabled and started."
}

function test_docker_installation {
	echo "6. Testing Docker installation..."
	
	# Test Docker with hello-world image
	echo "   🔄 Running Docker hello-world test..."
	if sudo docker run --rm hello-world >/dev/null 2>&1; then
		echo "   ✅ Docker hello-world test passed!"
		echo ""
		echo "🎉 Docker installation and configuration complete!"
		echo "📝 Note: You may need to log out and log back in for group changes to take effect."
		echo "   After logging back in, you can run 'docker run hello-world' without sudo."
	else
		echo "   ❌ Error: Docker hello-world test failed"
		return 1
	fi
}

function setup_docker {
	echo "🐳 Starting Docker installation and configuration..."
	remove_old_docker
	install_docker_prerequisites
	add_docker_repository
	install_docker_engine
	configure_docker
	test_docker_installation
} 