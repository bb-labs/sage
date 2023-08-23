import sys
import os
import yaml
import base64


def generate_config_map(properties):
    data = {}
    for key, value in properties.items():
        data[key] = value

    config_map = {
        'apiVersion': 'v1',
        'kind': 'ConfigMap',
        'metadata': {
            'name': 'sage-config-map'
        },
        'data': data
    }

    return yaml.dump(config_map)


def generate_secret(properties):
    data = {}
    for key, value in properties.items():
        data[key] = base64.b64encode(value.encode()).decode()

    secret = {
        'apiVersion': 'v1',
        'kind': 'Secret',
        'metadata': {
            'name': 'sage-secret'
        },
        'type': 'Opaque',
        'data': data
    }

    return yaml.dump(secret)


def load_env_file(filepath):
    properties = {}
    with open(filepath, 'r') as file:
        for line in file:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                properties[key] = value

    return properties


def main():
    if len(sys.argv) != 3:
        print("Please provide the action (config-map or secret) and the path to the environment file.")
        sys.exit(1)

    action = sys.argv[1]
    env_file = sys.argv[2]

    if not os.path.isfile(env_file):
        print(f"Environment file '{env_file}' not found.")
        sys.exit(1)

    config = load_env_file(env_file)

    if action == 'config-map':
        output_yaml = generate_config_map(config)
    elif action == 'secret':
        output_yaml = generate_secret(config)
    else:
        print(
            f"Invalid action '{action}'. Please choose either 'config-map' or 'secret'.")
        sys.exit(1)

    print(output_yaml)


if __name__ == '__main__':
    main()
