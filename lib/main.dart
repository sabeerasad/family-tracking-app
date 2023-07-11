import 'package:flutter/material.dart';

import './client/client.dart';

void main() => runApp(const MyApp());

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
  int _mobCount = 0;
  int _webCount = 0;

  @override
  void initState() {
    super.initState();
    connectSocket();
    initListeners();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() => _mobCount++);
    sendSocketCounter(_mobCount);
  }

  void _decrementCounter() {
    setState(() => _mobCount--);
    sendSocketCounter(_mobCount);
  }

  void disconnect() => socket.emit('disconnect_request');

  void initListeners() {
    socket.on('response-to-web', updateWebCountDisplay);
  }

  void updateWebCountDisplay(message) {
    setState(() => _webCount = message['data'] as int);
 
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
              'Mobile Count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_mobCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Web Count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_webCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: disconnect,
              child: const Text('Disconnect'),
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
