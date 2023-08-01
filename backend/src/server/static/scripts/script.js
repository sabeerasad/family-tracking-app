$(document).ready(function() {

    // namespace = '/test';
    var socket = io.connect('http://127.0.0.1:5000/test');

    socket.on('connect', function() {
        socket.emit('connection', {data: 'Web client connected', client: 'web'});
    });

    socket.on('log_connection', function(msg, callback) {
        $('#log').append('<br>' + $('<li/>').text('log: ' +  msg.data).html());
        if (callback) {
            callback();
        }
    });

    let counter = 0;

    $('#increment').click(function() {
        counter++;
        $('#web-count > span').text(counter);
        // socket.emit('update-from-web', {data: counter});
    });

    $('#decrement').click(function() {
        counter--;
        $('#web-count > span').text(counter);
        // socket.emit('update-from-web', {data: counter});
    });
});

//     socket.on('response-to-mobile', function(msg, callback) {
//         let count = msg.data;
//         $('#mobile-count > span').text(count);
//         if (callback)
//             callback();
//     })

//     $('form#disconnect').submit(function(event) {
//         socket.emit('disconnect_request');
//         return false;
//     });

// });