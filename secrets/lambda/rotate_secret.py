import os
import jwt
import time
import boto3
import logging
import pathlib


logger = logging.getLogger()
logger.setLevel(logging.INFO)

CREATE_SECRET = "createSecret"
FINISH_SECRET = "finishSecret"


def lambda_handler(event, context):
    print(event, context)

    arn = event["SecretId"]
    token = event["ClientRequestToken"]
    step = event["Step"]

    # Setup the client
    service_client = boto3.client("secretsmanager")

    if step == CREATE_SECRET:
        service_client.put_secret_value(
            SecretId=arn,
            ClientRequestToken=token,
            SecretString=jwt.encode(
                {
                    "iss": os.environ["APPLE_TEAM_ID"],
                    "iat": int(time.time()),
                    "exp": int(os.environ["APPLE_KEY_DURATION"]),
                    "aud": "https://appleid.apple.com",
                    "sub": os.environ["APPLE_BUNDLE_ID"],
                },
                pathlib.Path(os.environ["APPLE_KEY_PATH"]).read_bytes(),
                algorithm="ES256",
                headers={"kid": os.environ["APPLE_KEY_ID"], "alg": "ES256"},
            ),
            VersionStages=["AWSPENDING"],
        )

        logger.info(
            "createSecret: Successfully put secret for ARN %s and version %s."
            % (arn, token)
        )

    if step == FINISH_SECRET:
        # First describe the secret to get the current version
        metadata = service_client.describe_secret(SecretId=arn)

        # Finalize by staging the secret version current
        service_client.update_secret_version_stage(
            SecretId=arn,
            VersionStage="AWSCURRENT",
            MoveToVersionId=token,
            RemoveFromVersionId=[
                version
                for version in metadata["VersionIdsToStages"]
                if "AWSCURRENT" in metadata["VersionIdsToStages"][version]
            ].pop(),
        )
        logger.info(
            "finishSecret: Successfully set AWSCURRENT stage to version %s for secret %s."
            % (token, arn)
        )
