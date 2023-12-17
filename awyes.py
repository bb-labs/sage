import os
import jwt
import time
import json
import boto3
import yaml
import docker
import pathlib
import itertools
import subprocess


def binaries():
    HELM_URL = "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
    AWSCLI_URL = "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
    KUBECTL_URL = "https://storage.googleapis.com/kubernetes-release/release/v1.28.4/bin/linux/amd64/kubectl"

    # helm
    subprocess.run(["curl", "-fsSL", HELM_URL, "-o", "get_helm.sh"])
    subprocess.run(["chmod", "700", "get_helm.sh"])
    subprocess.run(["./get_helm.sh"])

    # awscli
    subprocess.run(["curl", "-fsSL", AWSCLI_URL, "-o", "awscliv2.zip"])
    subprocess.run(["unzip", "-q", "awscliv2.zip"])
    subprocess.run(["sudo", "./aws/install"])

    # kubectl
    subprocess.run(["curl", "-fsSL", KUBECTL_URL, "-o", "kubectl"])
    subprocess.run(["chmod", "+x", "./kubectl"])
    subprocess.run(["sudo", "mv", "./kubectl", "/usr/local/bin/kubectl"])


def deploy(deployment, chart, values=os.environ, dry_run=False, version=None):
    value_args = list(
        itertools.chain(
            *[
                ["--set-json", f"{k}={json.dumps(v)}"]
                if isinstance(v, dict)
                else ["--set", f"{k}={v}"]
                for k, v in values.items()
            ]
        )
    )

    return subprocess.run(
        ["helm", "upgrade", "--install", *value_args, deployment, chart]
        + (["--version", version] if version else [])
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

    # Grab vendor charts
    OAUTH2_CHART_URL = "https://oauth2-proxy.github.io/manifests"
    NGINX_CHART_URL = "https://kubernetes.github.io/ingress-nginx"
    CERT_MANAGER_CHART_URL = "https://charts.jetstack.io"

    subprocess.run(["helm", "repo", "add", "oauth2-proxy", OAUTH2_CHART_URL])
    subprocess.run(["helm", "repo", "add", "ingress-nginx", NGINX_CHART_URL])
    subprocess.run(["helm", "repo", "add", "jetstack", CERT_MANAGER_CHART_URL])


def apple_client_id():
    return jwt.encode(
        {
            "iss": os.environ["APPLE_TEAM_ID"],
            "iat": int(time.time()),
            "exp": int(time.time()) + 86400 * 180,  # 180 days
            "aud": "https://appleid.apple.com",
            "sub": os.environ["APPLE_BUNDLE_ID"],
        },
        pathlib.Path(os.environ["APPLE_KEY_PATH"]).read_bytes(),
        algorithm="ES256",
        headers={"kid": os.environ["APPLE_KEY_ID"], "alg": "ES256"},
    )


user = {
    "deploy": deploy,
    "init": init,
    "binaries": binaries,
    "apple_client_id": apple_client_id,
}
iam = boto3.client("iam")
ec2 = boto3.client("ec2")
eks = boto3.client("eks")
route53 = boto3.client("route53")
eks_waiter = eks.get_waiter("cluster_active")
image = docker.from_env().images
