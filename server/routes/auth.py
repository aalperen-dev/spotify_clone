import uuid

import bcrypt
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from models.user_model import User
from pydantic_schemas.user_create import UserCreate

router = APIRouter()


@router.post("/signup")
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    # extract the data from incoming request
    # print(user.name)
    # print(user.email)
    # print(user.password)
    # check if the user already exists in the db
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400, "Email already registered")

    password_hash = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt(16))

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
    return user_db
