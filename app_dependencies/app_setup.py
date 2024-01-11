import os

from flask import Flask
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv


load_dotenv("../.env")

def getHost():
    HOST = os.environ.get("DEV_HOST")
    return HOST

def getPort():
    PORT = os.environ.get("DEV_PORT")
    return PORT

def getDbCreds():
    db_username = os.environ.get("db_username")
    db_password = os.environ.get("db_password")
    db_name = os.environ.get("db_name")
    return db_username, db_password, db_name


# Constants
HOST = getHost()
db_username, db_password, db_name = getDbCreds()

app = Flask('app', static_folder='static', template_folder='templates')
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql://{db_username}:{db_password}@{HOST}/{db_name}'

db = SQLAlchemy(app)
socketio = SocketIO(app)