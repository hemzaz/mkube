#!/usr/bin/env bash
# Function to find the charts directory
find_charts_dir() {
    local start_dir="."
    while [ "$start_dir" != "/" ]; do
        if [ -d "$start_dir/charts" ]; then
            echo "$start_dir/charts"
            return
        fi
        start_dir=$(dirname "$start_dir")
    done
    echo "Charts directory not found." >&2
    exit 1
}

# Function to check if the Bitnami Helm repo is already added
is_repo_added() {
    helm repo list | grep -q 'bitnami'
}

CHARTS_DIR=$(find_charts_dir)
REDIS_CHART_DIR="$CHARTS_DIR/redis"

# Check if the Bitnami repo is added, add if not
if ! is_repo_added; then
    echo "Adding Bitnami Helm repository..."
    helm repo add bitnami https://charts.bitnami.com/bitnami
else
    echo "Bitnami Helm repository already added."
fi

# Update Helm repositories
echo "Updating Helm repositories..."
helm repo update

# Check if the Redis chart already exists
if [ -d "$REDIS_CHART_DIR" ]; then
    echo "Redis Helm chart already exists. Updating..."
    helm upgrade my-redis bitnami/redis --untardir "$CHARTS_DIR"
else
    # Fetch the Redis chart
    echo "Fetching Redis Helm chart..."
    helm pull bitnami/redis --untar --untardir "$CHARTS_DIR"

    # Verify the chart is downloaded
    if [ -d "$REDIS_CHART_DIR" ]; then
        echo "Redis Helm chart successfully fetched into $REDIS_CHART_DIR."
    else
        echo "Failed to fetch Redis Helm chart."
        exit 1
    fi
fi