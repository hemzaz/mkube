import subprocess


def deploy_minikube():
    try:
        print("Starting Minikube cluster...")
        subprocess.run(["minikube", "start"], check=True)
        print("Minikube cluster is up and running.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to start Minikube cluster: {e}")


if __name__ == "__main__":
    deploy_minikube()
