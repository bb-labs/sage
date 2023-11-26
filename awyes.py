import os
import boto3
import yaml
import docker
import itertools
import subprocess


def deploy(action, account_id, region, cluster_name):
    # Inline utility functions
    def str_presenter(dumper, data):
        if len(data.splitlines()) > 1:
            return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')
        return dumper.represent_scalar('tag:yaml.org,2002:str', data)

    def wait_and_kill(proc):
        proc.wait()
        proc.kill()

    # Update kubeconfig auth to talk to the cluster
    wait_and_kill(subprocess.Popen(["/usr/local/bin/aws", "eks", "update-kubeconfig",
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
        ["/usr/local/bin/kubectl",  "apply", "-f", "./kube/auth.yaml"]))

    # Install Helm charts
    env_args = list(itertools.chain(
        *[['--set', f'{k}={v}'] for k, v in os.environ.items()]))

    wait_and_kill(subprocess.Popen(
        ["/usr/local/bin/helm", action, *env_args, cluster_name, "./kube"]))


user = {"deploy": deploy}
iam = boto3.client('iam')
ec2 = boto3.client('ec2')
eks = boto3.client('eks')
eks_waiter = eks.get_waiter('cluster_active')
image = docker.from_env().images
