#!/bin/bash -e

echo "Installing system packages for stage3..."

# Update package lists
apt-get update

# Install packages from 00-packages
# The package installation is handled automatically by pi-gen
# This script can be used for additional configuration

echo "System packages installation completed"
