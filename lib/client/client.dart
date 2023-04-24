import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../main.dart';

class MyClientSocket {
  IO.Socket socketio = IO.io('http://127.0.0.1:3000');

  void mobileSocket(counter) {
    socketio.onConnect(
      (_) {
        print("Connected!");
        socketio.emit(
          'my event',
          {
            'data': 'Flutter client connected',
          },
        );
      },
    );

    socketio.emit(
      'my event',
      {
        'data': counter,
      },
    );
  }
}
