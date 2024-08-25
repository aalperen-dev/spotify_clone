import uuid

import bcrypt
from fastapi import APIRouter, Depends, HTTPException
import jwt
from sqlalchemy.orm import Session

from database import get_db
from models.user_model import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_login import UserLogin

router = APIRouter()


@router.post("/signup", status_code=201)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    # extract the data from incoming request
    # print(user.name)
    # print(user.email)
    # print(user.password)
    # check if the user already exists in the db
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400, "User with the same email already exists!")

    password_hash = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())

    user_db = User(
        id=str(uuid.uuid4()),
        name=user.name,
        email=user.email,
        password=password_hash,
    )
    # add user to the db
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    token = jwt.encode({"id": user_db.id}, "password_key")

    return {
        "token": token,
        "user": user_db,
    }


@router.post("/login")
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # check if user with same email already exists
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(400, "User with email does not exists!")

    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)

    if not is_match:
        raise HTTPException(400, "Incorrect password!")

    return user_db
