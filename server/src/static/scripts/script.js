// copied from https://medium.com/swlh/implement-a-websocket-using-flask-and-socket-io-python-76afa5bbeae1
$(document).ready(function() {

    // namespace = '/test';
    var socketio = io.connect('http://127.0.0.1:3000/test');

    socketio.on('connect', function() {
        socketio.emit('connection', {data: 'Web client connected', client: 'web'});
    });

    socketio.on('log_connection', function(msg, callback) {
        $('#log').append('<br>' + $('<li/>').text('log #' + ' (' + msg.client + ') ' + ': ' + msg.data).html());
        if (callback) {
            callback();
        }
    });

    socketio.on('my_response', function(msg, callback) {
        let count = msg.data;
        $('h1 span').text(count);
        if (callback)
            callback();
    })

    $('form#disconnect').submit(function(event) {
        socketio.emit('disconnect_request');
        return false;
    });
});
//     $('form#emit').submit(function(event) {
//         socketio.emit('my_event', {data: $('#emit_data').val()});
//         return false;
//     });
//     $('form#broadcast').submit(function(event) {
//         socketio.emit('my_broadcast_event', {data: $('#broadcast_data').val()});
//         return false;
//     });