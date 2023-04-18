from flask import Flask, render_template
from flask_socketio import SocketIO

app = Flask(__name__)
async_mode = None
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, async_mode=async_mode)




if __name__ == "__main__":
    socketio.run(app)