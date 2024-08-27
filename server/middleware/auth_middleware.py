from fastapi import HTTPException, Header
import jwt


def auth_middleware(x_auth_token=Header()):
    try:
        # get user token
        if not x_auth_token:
            raise HTTPException(401, "No auth token. Access Denied!")

        # decode token
        verified_token = jwt.decode(x_auth_token, "password_key", ["HS256"])

        if not verified_token:
            raise HTTPException(401, "Token verification failed. Authorization Denied!")

        # get id from the token
        uid = verified_token.get("id")
        return {"uid": uid, "token": x_auth_token}

        # get user info from db
    except jwt.PyJWKError:
        raise HTTPException(401, "Token is not valid. Authorization Failed!")
