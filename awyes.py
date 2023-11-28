import os
import boto3
import yaml
import docker
import itertools
import subprocess


def install_binaries():
    # helm
    subprocess.run(
        [
            "curl",
            "-fsSL",
            "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3",
            "-o",
            "get_helm.sh",
        ]
    )
    subprocess.run(["chmod", "700", "get_helm.sh"])
    subprocess.run(["./get_helm.sh"])

    # awscli
    subprocess.run(
        [
            "curl",
            "-fsSL",
            "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip",
            "-o",
            "awscliv2.zip",
        ]
    )
    subprocess.run(["unzip", "-q", "awscliv2.zip"])
    subprocess.run(["sudo", "./aws/install"])

    # kubectl
    subprocess.run(
        [
            "curl",
            "-fsSL",
            "https://storage.googleapis.com/kubernetes-release/release/v1.28.4/bin/linux/amd64/kubectl",
            "-o",
            "kubectl",
        ]
    )
    subprocess.run(["chmod", "+x", "./kubectl"])
    subprocess.run(["sudo", "mv", "./kubectl", "/usr/local/bin/kubectl"])


def deploy(action, cluster_name, dry_run=False):
    # Install Helm charts
    env_args = list(
        itertools.chain(*[["--set", f"{k}={v}"] for k, v in os.environ.items()])
    )

    subprocess.run(
        ["helm", action, *env_args, cluster_name, "./kube"]
        + (["--dry-run"] if dry_run else [])
    )

    subprocess.run(
        [
            "helm",
            action,
            *env_args,
            cluster_name,
            "oauth2-proxy/oauth2-proxy",
            "--config",
            "./kube/oauth.cfg",
        ]
        + (["--dry-run"] if dry_run else [])
    )


def init(account_id, region, cluster_name):
    # Inline utility functions
    def str_presenter(dumper, data):
        if len(data.splitlines()) > 1:
            return dumper.represent_scalar("tag:yaml.org,2002:str", data, style="|")

        return dumper.represent_scalar("tag:yaml.org,2002:str", data)

    # Update kubeconfig auth to talk to the cluster
    subprocess.run(
        ["aws", "eks", "update-kubeconfig", "--region", region, "--name", cluster_name]
    )

    yaml.add_representer(str, str_presenter)
    yaml.representer.SafeRepresenter.add_representer(str, str_presenter)

    with open("./kube/auth.yaml", "w") as outfile:
        yaml.dump(
            {
                "apiVersion": "v1",
                "data": {
                    "mapUsers": f"- groups:\n  - system:masters\n  userarn: arn:aws:iam::{account_id}:root"
                },
                "kind": "ConfigMap",
                "metadata": {"name": "aws-auth", "namespace": "kube-system"},
            },
            outfile,
        )

    subprocess.run(["kubectl", "apply", "-f", "./kube/auth.yaml"])

    # Grab the proxy chart
    subprocess.run(
        [
            "helm",
            "repo",
            "add",
            "oauth2-proxy",
            "https://oauth2-proxy.github.io/manifests",
        ]
    )


user = {"deploy": deploy, "init": init, "binaries": install_binaries}
iam = boto3.client("iam")
ec2 = boto3.client("ec2")
eks = boto3.client("eks")
eks_waiter = eks.get_waiter("cluster_active")
image = docker.from_env().images
