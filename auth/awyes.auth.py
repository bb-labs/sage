import jwt
import time
import pathlib


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
