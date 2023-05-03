import 'package:socket_io_client/socket_io_client.dart' as IO;

final IO.Socket socket = IO.io(
  'http://127.0.0.1:3000/test',
  IO.OptionBuilder().setTransports(['websocket']).build(),
);

void connectSocket() {
  socket.onConnect((_) {
    print("CONNECTION ESTABLISHED");
    socket.emit('connection', {
      'data': 'Flutter client connected',
      'client': 'flutter',
    });
  });
}

void sendSocketCounter(int counter) {
  socket.emit('my_event', {
    'data': counter,
  });
}
