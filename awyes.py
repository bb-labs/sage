import os
import boto3
import yaml
import itertools
import subprocess


def wait_and_kill(proc):
    proc.wait()
    proc.kill()


def str_presenter(dumper, data):
    if len(data.splitlines()) > 1:
        return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')
    return dumper.represent_scalar('tag:yaml.org,2002:str', data)


def deploy(action, account_id, region, cluster_name):
    # Update kubeconfig auth to talk to the cluster
    wait_and_kill(subprocess.Popen(["aws", "eks", "update-kubeconfig",
                                    "--region", region, "--name", cluster_name], env=os.environ))

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

    wait_and_kill(subprocess.Popen(
        ["kubectl",  "apply", "-f", "./kube/auth.yaml"]))

    # Install Helm charts
    env_args = list(itertools.chain(
        *[['--set', f'{k}={v}'] for k, v in os.environ.items()]))

    wait_and_kill(subprocess.Popen(
        ["helm", action, *env_args, cluster_name, "./kube"]))


def docker_login(username, password):
    wait_and_kill(subprocess.Popen(
        ["docker", "login", "-u", username, "-p", password]))


def docker_build_image(path, tag):
    wait_and_kill(subprocess.Popen(["docker", "build", "-t", tag, path]))


def docker_push_image(tag):
    wait_and_kill(subprocess.Popen(["docker", "push", tag]))


user = {
    "deploy": deploy,
    "login": docker_login,
    "build": docker_build_image,
    "push": docker_push_image
}

iam = boto3.client('iam')
ec2 = boto3.client('ec2')
eks = boto3.client('eks')
eks_waiter = eks.get_waiter('cluster_active')
