import os
import jwt
import time
import boto3
import docker
import dotenv
import pbxproj
import pbxproj.pbxextensions
import pathlib
import subprocess

ecs = boto3.client("ecs")
ssm = boto3.client("ssm")
iam = boto3.client("iam")
acm = boto3.client("acm")
ec2 = boto3.client("ec2")
ec2r = boto3.resource("ec2")
rds = boto3.client("rds")
route53 = boto3.client("route53")
elb = boto3.client("elbv2")
secrets = boto3.client("secretsmanager")

ssm_waiter = ssm.get_waiter("command_executed")
acm_waiter = acm.get_waiter("certificate_validated")
ec2_waiter = ec2.get_waiter("instance_status_ok")
rds_waiter = rds.get_waiter("db_instance_available")
elb_waiter = elb.get_waiter("load_balancer_available")

image = None
try:
    image = docker.from_env().images
except:
    print("WARN: Docker not found")


def save_protos(files):
    project = pbxproj.XcodeProject.load("ios/Slide.xcodeproj/project.pbxproj")

    # Add protos
    proto_group = project.get_groups_by_name("Protos").pop()

    for proto in files:
        proto_file = project.get_files_by_name(proto, parent=proto_group)

        if proto_file:
            project.remove_file_by_id(proto_file.pop().get_id())

        project.add_file(
            proto, parent=proto_group, tree=pbxproj.pbxextensions.TreeType.GROUP
        )

    project.save()


def get_latest_repo_revision():
    # silence all safe.directory warnings
    subprocess.run(["git", "config", "--global", "--add", "safe.directory", "*"])

    return (
        subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True)
        .stdout.decode("utf-8")
        .strip()
    )


def apple_client_secret(team_id, bundle_id, key_id, key_path):
    return jwt.encode(
        {
            "iss": team_id,
            "iat": int(time.time()),
            "exp": int(time.time()) + 86400 * 180,  # 180 days
            "aud": "https://appleid.apple.com",
            "sub": bundle_id,
        },
        pathlib.Path(key_path).read_bytes(),
        algorithm="ES256",
        headers={"kid": key_id, "alg": "ES256"},
    )
