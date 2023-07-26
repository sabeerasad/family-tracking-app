from . import socket
from flask_socketio import emit

@socket.on('connection', namespace='/test')
def recv_conn(data):
    pass