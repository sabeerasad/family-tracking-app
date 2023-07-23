from flask import Flask
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()
DB_NAME = 'database.db'


def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = '' # ! DON'T SHARE SECRET KEY IN PROD (use environment variables)
    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://root:81672943@localhost/{DB_NAME}' # ! use environment variables for username and password in prod
    db.init_app(app)

    from .routes import routes
    from .auth import auth

    app.register_blueprint(routes, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    return app