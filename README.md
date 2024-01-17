# Minikube and Redis Project

This project automates the setup of a Minikube Kubernetes cluster and deploys a Redis server and a Redis client within the cluster. It includes scripts for setting up the environment and deploying the applications, along with a Makefile for easy command execution.

## Prerequisites

- Minikube
- kubectl
- Helm
- Python 3

## Installation and Setup

1. **Bootstrap the Environment:**
   This step sets up Minikube, installs Helm, and starts the Minikube server.
   ```
   make setup
   ```

2. **Fetch Redis Helm Chart:**
   Fetches the Redis chart into the `charts` directory. If the chart already exists, it updates it.
   ```
   make fetch-redis-chart
   ```

3. **Deploy Redis Server:**
   Deploys the Redis server using the Helm chart in the `charts` directory.
   ```
   make deploy-redis
   ```

4. **Deploy Redis Client:**
   Deploys a Redis client that can connect to the Redis server.
   ```
   make deploy-redis-client
   ```

## Usage

- **Set a Key in Redis:**
  This command sets a key `OxKey` with the value `OxValue` in the Redis server.
  ```
  make redis-set
  ```

- **Get a Key from Redis:**
  Retrieves the value of `OxKey` from the Redis server and prints it.
  ```
  make redis-get
  ```

- **Demo:**
  Runs the `redis-set` and `redis-get` commands in sequence.
  ```
  make demo
  ```

## Scripts

- `bootstrap_minikube.sh`: Script to install and start Minikube.
- `deploy_minikube.py`: Python script to deploy Minikube.
- `bootstrap_helm.sh`: Script to install Helm.
- `fetch_redis_chart.sh`: Script to fetch/update the Redis Helm chart.
- `deploy_redis.py`: Python script to deploy Redis server.
- `deploy_redis_client.py`: Python script to deploy Redis client.
- `redis_operations.py`: Python script for Redis set/get operations.

## Makefile Commands

- `make setup`: Bootstraps Minikube and Helm, and starts Minikube.
- `make fetch-redis-chart`: Fetches/updates Redis chart.
- `make deploy-redis`: Deploys Redis server.
- `make deploy-redis-client`: Deploys Redis client.
- `make redis-set`: Sets a key in Redis.
- `make redis-get`: Gets a key from Redis.
- `make demo`: Demonstrates Redis set/get operations.
