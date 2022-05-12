#include <jni.h>
#include <string>
#include <fluidsynth.h>
#include <unistd.h>

fluid_synth_t *synthSingleton;
fluid_audio_driver_t *adriverSingleton;
fluid_settings_t *settingsSingleton;

extern "C" JNIEXPORT void JNICALL Java_me_teplyakov_midiplayer_MidiPlayerPlugin_fluidsynthInit(JNIEnv* env, jobject, jstring jSoundfontPath) {
    // Setup synthesizer
    settingsSingleton = new_fluid_settings();
    synthSingleton = new_fluid_synth(settingsSingleton);
    adriverSingleton = new_fluid_audio_driver(settingsSingleton, synthSingleton);

    // Load sample soundfont
    const char* soundfontPath = env->GetStringUTFChars(jSoundfontPath, nullptr);
    fluid_synth_sfload(synthSingleton, soundfontPath, 1);
}

extern "C" JNIEXPORT void JNICALL Java_me_teplyakov_midiplayer_MidiPlayerPlugin_fluidsynthPlayNote(JNIEnv* env, jobject, jint note, jint velocity) {
    fluid_synth_noteon(synthSingleton, 0, note, velocity);
}

extern "C" JNIEXPORT void JNICALL Java_me_teplyakov_midiplayer_MidiPlayerPlugin_fluidsynthUnload(JNIEnv* env, jobject) {
    // Clean up
    delete_fluid_audio_driver(adriverSingleton);
    delete_fluid_synth(synthSingleton);
    delete_fluid_settings(settingsSingleton);
}