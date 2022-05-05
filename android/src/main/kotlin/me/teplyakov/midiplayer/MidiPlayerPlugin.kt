package me.teplyakov.midiplayer

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MidiPlayerPlugin */
class MidiPlayerPlugin: FlutterPlugin, MethodCallHandler {
  companion object {
      init {
          System.loadLibrary("native-lib")
      }

      @JvmStatic
      private external fun fluidsynthInit(path: String)

      @JvmStatic
      private external fun fluidsynthPlayNote(note: Int)
      
      @JvmStatic
      private external fun fluidsynthUnload()
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "midi_player")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "load") {
      val path = call.arguments() as String
      fluidsynthInit(path)
    } else if (call.method == "play_note") {
      fluidsynthPlayNote(call.arguments() as Int)
    } else if (call.method == "dispose") {
      fluidsynthUnload()
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
