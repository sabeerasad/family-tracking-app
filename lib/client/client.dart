import 'package:socket_io_client/socket_io_client.dart' as IO;

class ClientSocket {
  final String hostname;
  final String namespace;

  late final _socket = _connect();

  ClientSocket(
    this.hostname, // * must include protocol and port
    this.namespace,
  ) {
    final _socket = _connect();
  }

  IO.Socket _connect() {
    IO.Socket socket = IO.io(
      '$hostname/$namespace',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    return socket;
  }

  void _emit(String eventName, Map<String, dynamic> data) {
    _socket.emit(eventName, data);
  }
}
