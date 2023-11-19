import os
import yaml
import itertools
import subprocess


def env_args():
    return list(itertools.chain(
        *[['--set', f'{k}={v}'] for k, v in os.environ.items()]))


def install_chart(cluster_name, env_args):
    proc = subprocess.Popen(
        ["helm", "install", *env_args, cluster_name, "./kube"])

    proc.wait()
    proc.kill()


def upgrade_chart(cluster_name, env_args):
    print(f"Upgrading chart {cluster_name}", env_args)
    proc = subprocess.Popen(
        ["helm", "upgrade", *env_args, cluster_name, "./kube"])

    proc.wait()
    proc.kill()


def update_config(cluster_name):
    proc = subprocess.Popen(["aws", "eks", "update-kubeconfig",
                             "--region", "us-west-2", "--name", cluster_name], env=env)
    proc.wait()
    proc.kill()


def update_auth(account_id):
    def str_presenter(dumper, data):
        if len(data.splitlines()) > 1:
            return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')
        return dumper.represent_scalar('tag:yaml.org,2002:str', data)

    yaml.add_representer(str, str_presenter)
    yaml.representer.SafeRepresenter.add_representer(str, str_presenter)

    auth = {
        "apiVersion": "v1",
        "data": {"mapUsers": f"- groups:\n  - system:masters\n  userarn: arn:aws:iam::{account_id}:root"},
        "kind": "ConfigMap",
        "metadata": {"name": "aws-auth", "namespace": "kube-system"}
    }

    with open('./kube/auth.yaml', 'w') as outfile:
        yaml.dump(auth, outfile)

    proc = subprocess.Popen(
        ["kubectl",  "apply", "-f", "./kube/auth.yaml"])

    proc.wait()
    proc.kill()
