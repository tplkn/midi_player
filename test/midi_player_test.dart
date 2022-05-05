import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_player/midi_player.dart';

void main() {
  const MethodChannel channel = MethodChannel('midi_player');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // channel.setMockMethodCallHandler((MethodCall methodCall) async {
    //   return '42';
    // });
  });

  tearDown(() {
    // channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await MidiPlayer.platformVersion, '42');
  });
}
