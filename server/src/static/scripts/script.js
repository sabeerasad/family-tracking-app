// copied from https://medium.com/swlh/implement-a-websocket-using-flask-and-socket-io-python-76afa5bbeae1
$(document).ready(function() {

    namespace = '/test';
    var socketio = io(namespace);

    socketio.on('connect', function() {
        socketio.emit('my_event', {data: 'connected to the SocketServer...'});
    });

    socketio.on('my_response', function(msg, callback) {
        $('#log').append('<br>' + $('<div/>').text('logs #' + msg.count + ': ' + msg.data).html());
        if (callback)
            callback();
    })
});
//     $('form#emit').submit(function(event) {
//         socketio.emit('my_event', {data: $('#emit_data').val()});
//         return false;
//     });
//     $('form#broadcast').submit(function(event) {
//         socketio.emit('my_broadcast_event', {data: $('#broadcast_data').val()});
//         return false;
//     });
//     $('form#disconnect').submit(function(event) {
//         socketio.emit('disconnect_request');
//         return false;
//     });
// });