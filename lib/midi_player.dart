import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MidiPlayer {
  static const MethodChannel _channel = MethodChannel('midi_player');

  /// Init engine with specific .sf2 file
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

  /// Play the note wirh specific velocity.
  /// velocity should be between 0.0 and 1.0
  /// if velocity is omitted maximum value is used
  Future<void> playNote({
    required int note,
    double? velocity,
  }) {
    final normalizedVelocity = 127.0 * (velocity ?? 1.0);
    return _channel.invokeMethod(
      'play_note',
      {
        'note': note,
        'velocity': normalizedVelocity.toInt(),
      },
    );
  }

  /// Dispose engine
  Future<void> dispose() {
    return _channel.invokeMethod('dispose');
  }
}
