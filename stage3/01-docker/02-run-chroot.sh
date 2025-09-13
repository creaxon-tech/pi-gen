#!/bin/bash -e

echo "Testing Docker installation..."

# Check if Docker service is active
if systemctl is-enabled docker >/dev/null 2>&1; then
    echo "✓ Docker service is enabled"
else
    echo "⚠ Docker service is not enabled"
fi

# Check Docker version
if command -v docker >/dev/null 2>&1; then
    echo "✓ Docker is installed: $(docker --version)"
else
    echo "✗ Docker command not found"
fi

# Check docker-compose
if command -v docker-compose >/dev/null 2>&1; then
    echo "✓ Docker Compose is installed: $(docker-compose --version)"
else
    echo "⚠ Docker Compose not found"
fi

echo "Docker installation test completed"
