# midi_player

A Flutter plugin to play midi on iOS and Android uses SoundFont (.sf2) files.

## Important notes

This plugin is still under development. Android code is based on [fluidsynth](https://github.com/FluidSynth/fluidsynth), iOS version is based on build-in iOS AudioUnit and flutter package [flutter_midi](https://pub.dev/packages/flutter_midi). Other platforms are planned.

## Installation

- Add sf2 file and include it in pubspec.yaml

``` ruby
assets:
   - assets/Piano.sf2
```

- Load the sound

``` ruby
_midiPlayer.load('assets/Piano.sf2');
```

- Play midi note

``` ruby
_midiPlayer.playNote(note: 60);
or
_midiPlayer.playNote(note: 62, velocity: 0.5);
```

- Dispose after usage

``` ruby
_midiPlayer.dispose();
```

## TDB

- macOS

- Windows

- Linux

- Web