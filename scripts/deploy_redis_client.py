import subprocess
import os


def find_chart_dir(chart_name):
    for root, dirs, _ in os.walk("."):
        if chart_name in dirs and "charts" in os.path.relpath(root).split(os.sep):
            return os.path.join(root, chart_name)
    raise FileNotFoundError(f"Chart directory for '{chart_name}' not found.")


def find_chart_values_file(chart_dir):
    values_file_path = os.path.join(chart_dir, "values.yaml")
    if os.path.exists(values_file_path):
        return values_file_path
    else:
        raise FileNotFoundError(f"Values file not found in {values_file_path}.")


def deploy_redis_client_helm_chart(chart_dir, values_file):
    try:
        print(
            f"Deploying Redis client Helm chart from {chart_dir} with values from {values_file}..."
        )
        subprocess.run(
            ["helm", "install", "my-redis-client", chart_dir, "-f", values_file],
            check=True,
        )
        print("Redis client has been deployed.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to deploy Redis client: {e}")


if __name__ == "__main__":
    try:
        redis_client_chart_dir = find_chart_dir("my-redis-client")
        values_file_path = find_chart_values_file(redis_client_chart_dir)
        deploy_redis_client_helm_chart(redis_client_chart_dir, values_file_path)
    except FileNotFoundError as e:
        print(e)
