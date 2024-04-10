import boto3


def deregister_task_definitions(taskDefinitions):
    ecs = boto3.client("ecs")
    for task_definition in taskDefinitions:
        ecs.deregister_task_definition(taskDefinition=task_definition)
