$(document).ready(function() {

    // namespace = '/test';
    var socketio = io.connect('http://127.0.0.1:5000/test');

    socketio.on('connect', function() {
        socketio.emit('connection', {data: 'Web client connected', client: 'web'});
    });

    socketio.on('log_connection', function(msg, callback) {
        $('#log').append('<br>' + $('<li/>').text('log #' + ' (' + msg.client + ') ' + ': ' + msg.data).html());
        if (callback) {
            callback();
        }
    });

    socketio.on('response-to-mobile', function(msg, callback) {
        let count = msg.data;
        $('#mobile-count > span').text(count);
        if (callback)
            callback();
    })

    $('form#disconnect').submit(function(event) {
        socketio.emit('disconnect_request');
        return false;
    });

    // let counter = 0; // TODO: 2-way communication of `counter` (both, web and mobile counters) with centralized data storage in Flask session

    $('#increment').click(function() {
        counter++;
        $('#web-count > span').text(counter);
        socketio.emit('update-from-web', {data: counter});
    });

    $('#decrement').click(function() {
        counter--;
        $('#web-count > span').text(counter);
        socketio.emit('update-from-web', {data: counter});
    });
});