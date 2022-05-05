#import "MidiPlayerPlugin.h"
#if __has_include(<midi_player/midi_player-Swift.h>)
#import <midi_player/midi_player-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "midi_player-Swift.h"
#endif

@implementation MidiPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMidiPlayerPlugin registerWithRegistrar:registrar];
}
@end
