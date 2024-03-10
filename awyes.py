import boto3
import docker
import subprocess

ecs = boto3.client("ecs")
ssm = boto3.client("ssm")
iam = boto3.client("iam")
ec2 = boto3.client("ec2")
secrets = boto3.client("secretsmanager")

ecs_tasks_stopped = ecs.get_waiter("tasks_stopped")
ssm_waiter = ssm.get_waiter("command_executed")
ec2_waiter = ec2.get_waiter("instance_status_ok")


route53 = boto3.client("route53")
record_sets_changed = route53.get_waiter("resource_record_sets_changed")

acm = boto3.client("acm")
certificate_validated = acm.get_waiter("certificate_validated")

elb = boto3.client("elbv2")
load_balancer_deleted = elb.get_waiter("load_balancers_deleted")
load_balancer_available = elb.get_waiter("load_balancer_available")

rds = boto3.client("rds")
rds_instance_deleted = rds.get_waiter("db_instance_deleted")
rds_instance_availiable = rds.get_waiter("db_instance_available")

image = {"build": lambda: "unimplemented", "push": lambda: "unimplemented"}
try:
    image = docker.from_env().images
except:
    pass
