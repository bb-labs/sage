import os
import subprocess


def update_kube_config():
    env = os.environ.copy()
    env["KUBECONFIG"] = "./back/kube/config"

    proc = subprocess.Popen(["aws", "eks", "update-kubeconfig",
                             "--region", "us-west-2", "--name", "sage"], env=env)
    proc.wait()
    proc.kill()
