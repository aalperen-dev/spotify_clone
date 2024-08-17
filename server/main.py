from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

app = FastAPI()
DATABASE_URL = "postgresql://postgres:Celcius.227282@localhost:5432/spotify"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
db = SessionLocal()


class UserCreate(BaseModel):
    name: str
    email: str
    password: str


Base = declarative_base()


class User(Base):
    __tablename__ = "users"

    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)


@app.post("/signup")
def signup_user(user: UserCreate):
    # extract the data from incoming request
    # print(user.name)
    # print(user.email)
    # print(user.password)
    # check if the user already exists in the db
    db.query(User).filter(User.email == user.email).first()
    # add user to the db
    pass


Base.metadata.create_all(engine)
