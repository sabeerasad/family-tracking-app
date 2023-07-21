from flask import Flask

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = '' # ! DON'T SHARE SECRET KEY IN PROD (use environment variables)

    from .routes import routes
    from .auth import auth

    app.register_blueprint(routes, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    return app