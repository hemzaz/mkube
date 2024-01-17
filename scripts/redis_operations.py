import subprocess
import sys


def exec_into_pod(command):
    try:
        return subprocess.run(
            ["kubectl", "exec", "-it", "deployment/my-redis-client", "--"] + command,
            check=True,
            capture_output=True,
            text=True,
        ).stdout
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {e}")
        return None


def set_key():
    result = exec_into_pod(["redis-cli", "SET", "OxKey", "OxValue"])
    if result is not None:
        print("Key 'OxKey' set to 'OxValue'")


def get_key():
    result = exec_into_pod(["redis-cli", "GET", "OxKey"])
    if result is not None:
        print(f"Value of 'OxKey': {result}")


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] not in ["set", "get"]:
        print("Usage: python3 redis_operations.py <set|get>")
        sys.exit(1)

    operation = sys.argv[1]
    if operation == "set":
        set_key()
    elif operation == "get":
        get_key()
