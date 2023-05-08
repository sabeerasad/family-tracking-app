import 'package:socket_io_client/socket_io_client.dart';

final Socket socket = io(
  'http://127.0.0.1:3000/test',
  OptionBuilder().setTransports(['websocket']).build(),
);

void connectSocket() => socket.onConnect((_) {
      print("CONNECTION ESTABLISHED");
      socket.emit('connection', {
        'data': 'Flutter client connected',
        'client': 'flutter',
      });
    });

void sendSocketCounter(int counter) => socket.emit(
      'update-from-mobile',
      {'data': counter},
    );

receiveSocketCounter() => socket.on('', (_) {
      return; // TODO: 2-way communication of `counter` (both, web and mobile counters) with centralized data storage in Flask session
    });
