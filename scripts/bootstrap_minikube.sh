#!/usr/bin/env bash

# Function to check if Minikube is installed
is_minikube_installed() {
    if command -v minikube >/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install Minikube on Ubuntu
install_minikube_ubuntu() {
    echo "Installing Minikube on Ubuntu..."
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo cp minikube-linux-amd64 /usr/local/bin/minikube
    sudo chmod 755 /usr/local/bin/minikube
}

# Function to install Minikube on macOS
install_minikube_mac() {
    echo "Installing Minikube on macOS..."
    brew install minikube
}

# Start Minikube
start_minikube() {
    echo "Starting Minikube..."
    minikube start
    echo "Minikube started."
}

# Validate kubectl connection
validate_kubectl_connection() {
    echo "Validating kubectl connection to Minikube..."
    if ! kubectl cluster-info; then
        echo "Failed to connect to Minikube via kubectl."
        exit 1
    else
        echo "kubectl is configured to connect to Minikube."
    fi
}

# Detect the operating system
OS="$(uname -s)"
case "$OS" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=Mac;;
    *)          OS="UNKNOWN"
esac

# Check if Minikube is installed, install it if not
if ! is_minikube_installed; then
    echo "Minikube not installed. Installing..."
    if [ "$OS" = "Linux" ]; then
        . /etc/os-release
        if [ "$ID" = "ubuntu" ]; then
            install_minikube_ubuntu
        else
            echo "Unsupported Linux distribution: $ID"
            exit 1
        fi
    elif [ "$OS" = "Mac" ]; then
        install_minikube_mac
    else
        echo "Unsupported operating system: $OS"
        exit 1
    fi
else
    echo "Minikube is already installed."
fi

# Start Minikube and Validate kubectl connection
start_minikube
validate_kubectl_connection
