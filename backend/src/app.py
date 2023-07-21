from flask import Flask, render_template, session, request, copy_current_request_context
from flask_socketio import SocketIO, emit, disconnect


# async_mode = None
app = Flask(__name__)
app.config['SECRET_KEY'] = ''
socketio = SocketIO(app)


@app.route('/', methods=["POST", "GET"])
def index():
    return render_template('index.html')


@socketio.on('connection', namespace='/test')
def acknowledge_connection(msg):
    # Database initialization (temporarily using flask `session`)
    session['mobile_counter'] = 0
    session['web_counter'] = 0
    emit('log_connection', 
        {'data': msg['data'], 'client': msg['client']},
        broadcast=True)

# TODO: centralized data storage in Flask session
# ? Handling calculation logic on client side (for now; don't know what's the better approach)

# Handles display of mobileCount on web client
@socketio.on('update-from-mobile', namespace='/test')
def mobile_counter_update(message):
    session['mobile_counter'] = message['data']
    emit('response-to-mobile',
        {'data': session['mobile_counter']},
        broadcast=True)

# Handles display of webCount on mobile client
@socketio.on('update-from-web', namespace='/test')
def web_counter_update(message):
    session['web_counter'] = message['data']
    emit('response-to-web',
        {'data': session['web_counter']},
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