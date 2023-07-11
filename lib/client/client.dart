import 'package:socket_io_client/socket_io_client.dart';

final socket = io(
  'http://10.0.2.2:5000/test', // ? something something use 10.0.2.2 to "loopback" to 127.0.0.1 https://developer.android.com/studio/run/emulator-networking
  OptionBuilder().setTransports(['websocket']).build(),
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

void sendSocketCounter(int counter) => socket.emit(
      'update-from-mobile',
      {'data': counter},
    );

// TODO: 2-way communication of `counter` (both, web and mobile counters) with centralized data storage in Flask session