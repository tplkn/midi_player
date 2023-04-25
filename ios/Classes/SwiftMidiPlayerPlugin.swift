import Flutter
import UIKit

public class SwiftMidiPlayerPlugin: NSObject, FlutterPlugin {
  var au: AudioUnitMIDISynth!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "midi_player", binaryMessenger: registrar.messenger())
    let instance = SwiftMidiPlayerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "load":
        let data = call.arguments as? String
        let url = URL(fileURLWithPath: data!)
        au = AudioUnitMIDISynth(soundfont: url)
        print("Valid URL: \(url)")
        let message = "Prepared Sound Font"
        result(message)
      case "play_note":
        if let args = call.arguments as? Dictionary<String, Any>,
          let note = args["note"] as? Int,
          let velocity = args["velocity"] as? Int {
            au.playPitch(midi: note, velocity: velocity)
            let message = "Playing: \(String(describing: note))"
            result(message)
        }
      case "stop_note":
        if let args = call.arguments as? Dictionary<String, Any>,
          let note = args["note"] as? Int {
            au.stopPitch(midi: note)
            let message = "Stopped: \(String(describing: note))"
            result(message)
        }
      case "dispose":
        result("done")
      default:
        result(FlutterMethodNotImplemented)
        break
      }
    }
}
