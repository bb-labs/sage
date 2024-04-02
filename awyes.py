import time
import boto3
import base64
import docker
import pathlib

ssm = boto3.client("ssm")
iam = boto3.client("iam")
secrets = boto3.client("secretsmanager")

lmda = boto3.client("lambda")
function_active = lmda.get_waiter("function_active_v2")

s3 = boto3.client("s3")
bucket_exists = s3.get_waiter("bucket_exists")
object_exists = s3.get_waiter("object_exists")

ecs = boto3.client("ecs")
ecs_tasks_stopped = ecs.get_waiter("tasks_stopped")

ec2 = boto3.client("ec2")
ec2_waiter = ec2.get_waiter("instance_status_ok")

ecr = boto3.client("ecr")

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

sleep = lambda seconds: time.sleep(seconds)
read_text = lambda path: pathlib.Path(path).read_text()
read_bytes = lambda path: pathlib.Path(path).read_bytes()
b64decode = lambda data: base64.b64decode(data).decode()
