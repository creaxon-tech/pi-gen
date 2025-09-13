#!/bin/bash -e

echo "Installing Docker..."

# Update package lists (prerequisites should already be installed via 00-packages)
apt-get update

# Create directory for apt keyrings
install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists with Docker repository
apt-get update

# Install Docker packages
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker service
systemctl enable docker

# Install docker-compose via pip3
pip3 install docker-compose

# Add pi user to docker group (assuming default pi user exists)
if getent passwd pi > /dev/null; then
    usermod -aG docker pi
    echo "Added user 'pi' to docker group"
fi

# Add the first user to docker group if different from pi
if [ -n "${FIRST_USER_NAME}" ] && [ "${FIRST_USER_NAME}" != "pi" ]; then
    if getent passwd "${FIRST_USER_NAME}" > /dev/null; then
        usermod -aG docker "${FIRST_USER_NAME}"
        echo "Added user '${FIRST_USER_NAME}' to docker group"
    fi
fi

echo "Docker installation completed successfully"
echo "Note: Users need to log out and back in for docker group membership to take effect"
