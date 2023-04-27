import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final IO.Socket socket = IO.io(
    'http://127.0.0.1:3000/test',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  connectSocket() {
    socket.onConnect((_) {
      print("CONNECTION ESTABLISHED");
      socket.emit('my_event', 'flutter connected');
    });
    socket.on('my_response', (msg) {
      print('CONNECTION ACKNOWLEDGED BY SERVER');
    });
  }

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() => _counter--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B2447),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              heroTag: null,
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              heroTag: null,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
