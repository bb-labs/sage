import os
import jwt
import time
import boto3
import docker
import pathlib
import subprocess


def tag():
    return (
        subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True)
        .stdout.decode("utf-8")
        .strip()
    )


def apple_client_secret():
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


ssm = boto3.client("ssm")
ssm_waiter = ssm.get_waiter("command_executed")

iam = boto3.client("iam")

ec2 = boto3.client("ec2")
ec2r = boto3.resource("ec2")
ec2_waiter = ec2.get_waiter("instance_status_ok")

rds = boto3.client("rds")

route53 = boto3.client("route53")

elb = boto3.client("elbv2")

image = docker.from_env().images
