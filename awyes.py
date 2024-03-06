import boto3
import docker
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


def get_latest_repo_revision():
    # silence all safe.directory warnings
    subprocess.run(["git", "config", "--global", "--add", "safe.directory", "*"])

    return (
        subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True)
        .stdout.decode("utf-8")
        .strip()
    )
