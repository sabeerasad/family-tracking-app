from flask import Flask

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = '' # ! DON'T SHARE SECRET KEY IN PROD (use environment variables)

    return app