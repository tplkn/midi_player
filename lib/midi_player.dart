import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MidiPlayer {
  static const MethodChannel _channel = MethodChannel('midi_player');

  Future<void> load(String path) async {
    const tmpPath = "temporay_font.sf2";

    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/$tmpPath');
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    return _channel.invokeMethod('load', file.path);
  }

  Future<void> playNote(int note) {
    return _channel.invokeMethod('play_note', note);
  }

  Future<void> dispose() {
    return _channel.invokeMethod('dispose');
  }
}
