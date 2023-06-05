from flask import Flask, render_template, session, copy_current_request_context # request
from flask_socketio import SocketIO, emit, disconnect


async_mode = None
app = Flask(__name__)
app.config['SECRET_KEY'] = ''
socketio = SocketIO(app, async_mode=async_mode)


@app.route('/')
def index():
    return render_template('index.html', async_mode=socketio.async_mode)


@socketio.on('connection', namespace='/test')
def acknowledge_connection(msg):
    session['receive_count'] = session.get('receive_count', 0) + 1
    emit('log_connection', 
        {'data': msg['data'], 'count': session['receive_count'], 'client': msg['client']},
        broadcast=True)


@socketio.on('update-from-mobile', namespace='/test')
def mobile_counter_update(message):
    session['receive_count'] = session.get('receive_count', 0) + 1
    session['mobile_count'] = session.get('mobile_count', 0) + 1
    emit('response-to-mobile',
        {'data': message['data'], 'count': session['receive_count'], 'mobileCount': session['mobile_count']},
        broadcast=True)

# TODO: 2-way communication of `counter` (both, web and mobile counters) with centralized data storage in Flask session

@socketio.on('update-from-web', namespace='/test')
def web_counter_update(message):
    session['receive_count'] = session.get('receive_count', 0) + 1
    session['web_count'] = session.get('web_count', 0) + 1
    emit('response-to-web',
        {'data': message['data'], 'count': session['receive_count'], 'webCount': session['web_count']},
        broadcast=True)


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
    socketio.run(host='127.0.0.1', app=app, port=5000, debug=True)