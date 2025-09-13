#!/bin/bash -e

echo "Configuring sudo access for pi user..."

# Add pi user to sudo group
if getent passwd pi > /dev/null; then
    usermod -aG sudo pi
    echo "Added user 'pi' to sudo group"
    
    # Configure passwordless sudo for pi user
    echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/010_pi-nopasswd
    chmod 440 /etc/sudoers.d/010_pi-nopasswd
    echo "Configured passwordless sudo for user 'pi'"
else
    echo "Warning: 'pi' user not found"
fi

# Ensure sudo package is properly configured
if command -v visudo >/dev/null 2>&1; then
    echo "✓ sudo package is installed and configured"
else
    echo "⚠ sudo package not found"
fi

echo "Sudo configuration completed"
