import os

from flask import Flask
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy import MetaData

from dotenv import load_dotenv
load_dotenv("../.env")


class Base(DeclarativeBase):
    metadata = MetaData(naming_convention={
        "ix": 'ix_%(column_0_label)s',
        "uq": "uq_%(table_name)s_%(column_0_name)s",
        "ck": "ck_%(table_name)s_%(constraint_name)s",
        "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
        "pk": "pk_%(table_name)s"
    })



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

db = SQLAlchemy(app, model_class=Base)
socketio = SocketIO(app)