# copied from https://medium.com/swlh/implement-a-websocket-using-flask-and-socket-io-python-76afa5bbeae1
from flask import Flask, render_template, session, copy_current_request_context # request
from flask_socketio import SocketIO, emit, disconnect
from threading import Lock


async_mode = None
app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, async_mode=async_mode)


@app.route('/')
def index():
    return render_template('index.html', async_mode=socketio.async_mode)


@socketio.on('connection', namespace='/test')
def acknowledge_connection(msg):
    session['receive_count'] = session.get('receive_count', 0) + 1
    emit('log_connection', 
         {'data': msg['data'], 'count': session['receive_count'], 'client': msg['client']}, broadcast=True)


@socketio.on('my_event', namespace='/test')
def test_message(message):
    # print(request.sid)
    session['receive_count'] = session.get('receive_count', 0) + 1
    emit('my_response',
         {'data': message['data'], 'count': session['receive_count']}, broadcast=True)


@socketio.on('disconnect_request', namespace='/test')
def disconnect_request():
    @copy_current_request_context
    def can_disconnect():
        disconnect()

    session['receive_count'] = session.get('receive_count', 0) + 1
    emit('log_connection',
         {'data': 'Disconnected!', 'count': session['receive_count']},
         callback=can_disconnect, broadcast=True)


if __name__ == '__main__':
    socketio.run(host='127.0.0.1', app=app, port=3000, debug=True)