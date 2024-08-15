from fastapi import FastAPI

app = FastAPI()

@app.post('\signup')
def signup_user():
    # extract the data from incoming request
    # check if the user already exists in the db
    # add user to the db
    pass


