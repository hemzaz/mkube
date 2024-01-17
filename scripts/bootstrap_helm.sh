#!/usr/bin/env bash

# Function to install Helm
install_helm() {
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
}

# Check if Helm is installed
if ! command -v helm &> /dev/null
then
    echo "Helm not found, installing..."
    install_helm
else
    echo "Helm is already installed."
fi

# Validate Helm installation
echo "Validating Helm installation..."
helm version
if [ $? -ne 0 ]; then
    echo "Helm installation validation failed."
    exit 1
else
    echo "Helm installation is valid."
fi

# Verify Helm's connection to Minikube
echo "Verifying Helm's connection to Minikube..."
kubectl cluster-info
if [ $? -ne 0 ]; then
    echo "Failed to connect Helm to Minikube."
    exit 1
else
    echo "Helm is connected to Minikube."
fi
