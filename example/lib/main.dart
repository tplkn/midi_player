import 'package:flutter/material.dart';
import 'package:midi_player/midi_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _midiPlayer = MidiPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
              onPressed: () async {
                _midiPlayer.load('assets/FlorestanPiano.sf2');
              },
              child: const Text('Init'),
            ),
            ElevatedButton(
              onPressed: () {
                _midiPlayer.playNote(60);
              },
              child: const Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                _midiPlayer.dispose();
              },
              child: const Text('Dispose'),
            ),
          ]),
        ),
      ),
    );
  }
}
