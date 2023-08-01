from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy_utils import database_exists, create_database
from flask_socketio import SocketIO


# Database Initialization
db = SQLAlchemy()
DB_NAME = 'Family_App'

# Socket Initialization
socket = SocketIO()

def create_app():
    # ! DON'T SHARE SECRET KEY IN PROD (use environment variables)
    # ! use environment variables for username and password in prod
    app = Flask(__name__)
    app.config['SECRET_KEY'] = ''

    uri = 'mysql+pymysql://{user}:{passwd}@{host}/{db_name}'.format(user='root',
                                                                    passwd='81672943',
                                                                    host='localhost',
                                                                    db_name=DB_NAME) 
    if not database_exists(uri):
        create_database(uri)

    app.config['SQLALCHEMY_DATABASE_URI'] = uri
    db.init_app(app)
    
    socket.init_app(app)

    from .routes import routes
    from .auth import auth

    app.register_blueprint(routes, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    from . import models

    with app.app_context():
        db.create_all()

    return socket, app