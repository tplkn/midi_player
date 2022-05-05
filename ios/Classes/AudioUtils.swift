import Foundation
import AudioToolbox
import CoreAudio

#if os(OSX)
    // for UTCreateStringForOSType
    import CoreServices
    
#endif

#if os(tvOS)
#elseif os(iOS)
    import CoreMIDI
#endif

import AVFoundation

open class AudioUtils {
    
    fileprivate init() {
    }
    
    class func stringFrom4(_ n: Int) -> String {
        
        var scalar = UnicodeScalar((n >> 24) & 255)
        if !scalar!.isASCII {
            return ""
        }
        var s = String(describing: scalar)
        
        scalar = UnicodeScalar((n >> 16) & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        scalar = UnicodeScalar((n >> 8) & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        scalar = UnicodeScalar(n & 255)
        if !scalar!.isASCII {
            return ""
        }
        s.append(String(describing: scalar))
        
        
        return s
    }
    
    class func stringFrom4(_ status: OSStatus) -> String {
        let n = Int(status)
        return stringFrom4(n)
    }
    
    class func valueFromString4(_ s: String) -> Int {
        var n = 0
        var r = ""
        
        if s.count > 4 {
            let startIndex = s.index(s.startIndex, offsetBy: 4)
            r = String(s[startIndex...])
        } else {
            r = s + "    "
            let startIndex = s.index(s.startIndex, offsetBy: 4)
            r = String(r[...startIndex])
        }
        
        for UniCodeChar in r.unicodeScalars {
            n = (n << 8) + (Int(UniCodeChar.value) & 255)
        }
        
        return n
    }
        
    #if os(tvOS)
    class func CheckError(status: OSStatus) {
    if status == noErr {
    print("no error")
    return
    }
    print("error \(status)")
    }
    #elseif os(iOS)
    class func CheckError(_ status: OSStatus) {
    
    if status == noErr {
    return
    }
    
    let s = stringFrom4(status)
    print("error chars '\(s)'")
    
    
    switch status {
    case kAUGraphErr_NodeNotFound:
    print("kAUGraphErr_NodeNotFound")
    
    case kAUGraphErr_OutputNodeErr:
    print("kAUGraphErr_OutputNodeErr")
    
    case kAUGraphErr_InvalidConnection:
    print("kAUGraphErr_InvalidConnection")
    
    case kAUGraphErr_CannotDoInCurrentContext:
    print("kAUGraphErr_CannotDoInCurrentContext")
    
    case kAUGraphErr_InvalidAudioUnit:
    print("kAUGraphErr_InvalidAudioUnit")
    
    case kMIDIInvalidClient :
    print("kMIDIInvalidClient ")  
    
    case kMIDIInvalidPort :
    print("kMIDIInvalidPort ")
  
    case kMIDIWrongEndpointType :
    print("kMIDIWrongEndpointType")
    
    case kMIDINoConnection :
    print("kMIDINoConnection ")

    case kMIDIUnknownEndpoint :
    print("kMIDIUnknownEndpoint ")

    case kMIDIUnknownProperty :
    print("kMIDIUnknownProperty ")

    case kMIDIWrongPropertyType :
    print("kMIDIWrongPropertyType ")

    case kMIDINoCurrentSetup :
    print("kMIDINoCurrentSetup ")

    case kMIDIMessageSendErr :
    print("kMIDIMessageSendErr ")

    case kMIDIServerStartErr :
    print("kMIDIServerStartErr ")

    case kMIDISetupFormatErr :
    print("kMIDISetupFormatErr ")

    case kMIDIWrongThread :
    print("kMIDIWrongThread ")

    case kMIDIObjectNotFound :
    print("kMIDIObjectNotFound ")

    case kMIDIIDNotUnique :
    print("kMIDIIDNotUnique ")

    case kAudioToolboxErr_InvalidSequenceType :
    print("kAudioToolboxErr_InvalidSequenceType ")
    
    case kAudioToolboxErr_TrackIndexError :
    print("kAudioToolboxErr_TrackIndexError ")
    
    case kAudioToolboxErr_TrackNotFound :
    print("kAudioToolboxErr_TrackNotFound ")
    
    case kAudioToolboxErr_EndOfTrack :
    print("kAudioToolboxErr_EndOfTrack ")
    
    case kAudioToolboxErr_StartOfTrack :
    print("kAudioToolboxErr_StartOfTrack ")
    
    case kAudioToolboxErr_IllegalTrackDestination:
    print("kAudioToolboxErr_IllegalTrackDestination")
    
    case kAudioToolboxErr_NoSequence :
    print("kAudioToolboxErr_NoSequence ")
    
    case kAudioToolboxErr_InvalidEventType    :
    print("kAudioToolboxErr_InvalidEventType")
    
    case kAudioToolboxErr_InvalidPlayerState:
    print("kAudioToolboxErr_InvalidPlayerState")
    
    case kAudioUnitErr_InvalidProperty    :
    print("kAudioUnitErr_InvalidProperty")
    
    case kAudioUnitErr_InvalidParameter    :
    print("kAudioUnitErr_InvalidParameter")
    
    case kAudioUnitErr_InvalidElement :
    print("kAudioUnitErr_InvalidElement")
    
    case kAudioUnitErr_NoConnection    :
    print("kAudioUnitErr_NoConnection")
    
    case kAudioUnitErr_FailedInitialization    :
    print("kAudioUnitErr_FailedInitialization")
    
    case kAudioUnitErr_TooManyFramesToProcess:
    print("kAudioUnitErr_TooManyFramesToProcess")
    
    case kAudioUnitErr_InvalidFile:
    print("kAudioUnitErr_InvalidFile")
    
    case kAudioUnitErr_FormatNotSupported :
    print("kAudioUnitErr_FormatNotSupported")
    
    case kAudioUnitErr_Uninitialized:
    print("kAudioUnitErr_Uninitialized")
    
    case kAudioUnitErr_InvalidScope :
    print("kAudioUnitErr_InvalidScope")
    
    case kAudioUnitErr_PropertyNotWritable :
    print("kAudioUnitErr_PropertyNotWritable")
    
    case kAudioUnitErr_InvalidPropertyValue :
    print("kAudioUnitErr_InvalidPropertyValue")
    
    case kAudioUnitErr_PropertyNotInUse :
    print("kAudioUnitErr_PropertyNotInUse")
    
    case kAudioUnitErr_Initialized :
    print("kAudioUnitErr_Initialized")
    
    case kAudioUnitErr_InvalidOfflineRender :
    print("kAudioUnitErr_InvalidOfflineRender")
    
    case kAudioUnitErr_Unauthorized :
    print("kAudioUnitErr_Unauthorized")
    
    case kAudioUnitErr_CannotDoInCurrentContext:
    print("kAudioUnitErr_CannotDoInCurrentContext")
    
    case kAudioUnitErr_FailedInitialization:
    print("kAudioUnitErr_FailedInitialization")
    
    case kAudioUnitErr_FileNotSpecified:
    print("kAudioUnitErr_FileNotSpecified")
    
    case kAudioUnitErr_FormatNotSupported:
    print("kAudioUnitErr_FormatNotSupported")
    
    case kAudioUnitErr_IllegalInstrument:
    print("kAudioUnitErr_IllegalInstrument")
    
    case kAudioUnitErr_Initialized:
    print("kAudioUnitErr_Initialized")
    
    case kAudioUnitErr_InstrumentTypeNotFound:
    print("kAudioUnitErr_InstrumentTypeNotFound")
    
    case kAudioUnitErr_InvalidElement:
    print("kAudioUnitErr_InvalidElement")
    
    case kAudioUnitErr_InvalidFile:
    print("kAudioUnitErr_InvalidFile")
    
    case kAudioUnitErr_InvalidOfflineRender:
    print("kAudioUnitErr_InvalidOfflineRender")
    
    case kAudioUnitErr_InvalidParameter:
    print("kAudioUnitErr_InvalidParameter")
    
    case kAudioUnitErr_InvalidProperty:
    print("kAudioUnitErr_InvalidProperty")
    
    case kAudioUnitErr_InvalidPropertyValue:
    print("kAudioUnitErr_InvalidPropertyValue")
    
    case kAudioUnitErr_InvalidScope:
    print("kAudioUnitErr_InvalidScope")
    
    case kAudioUnitErr_NoConnection:
    print("kAudioUnitErr_NoConnection")
    
    case kAudioUnitErr_PropertyNotInUse:
    print("kAudioUnitErr_PropertyNotInUse")
    
    case kAudioUnitErr_PropertyNotWritable:
    print("kAudioUnitErr_PropertyNotWritable")
    
    case kAudioUnitErr_TooManyFramesToProcess:
    print("kAudioUnitErr_TooManyFramesToProcess")
    
    case kAudioUnitErr_Unauthorized:
    print("kAudioUnitErr_Unauthorized")
    
    case kAudioUnitErr_Uninitialized:
    print("kAudioUnitErr_Uninitialized")
    
    case kAudioUnitErr_UnknownFileType:
    print("kAudioUnitErr_UnknownFileType")
    
    case kAudioComponentErr_InstanceInvalidated:
    print("kAudioComponentErr_InstanceInvalidated ")
    
    case kAudioComponentErr_DuplicateDescription:
    print("kAudioComponentErr_DuplicateDescription ")
    
    case kAudioComponentErr_UnsupportedType:
    print("kAudioComponentErr_UnsupportedType ")
    
    case kAudioComponentErr_TooManyInstances:
    print("kAudioComponentErr_TooManyInstances ")
    
    case kAudioComponentErr_NotPermitted:
    print("kAudioComponentErr_NotPermitted ")
    
    case kAudioComponentErr_InitializationTimedOut:
    print("kAudioComponentErr_InitializationTimedOut ")
    
    case kAudioComponentErr_InvalidFormat:
    print("kAudioComponentErr_InvalidFormat ")
    
    // in CoreAudioTypes
    case kAudio_UnimplementedError :
    print("kAudio_UnimplementedError")
    
    case kAudio_FileNotFoundError :
    print("kAudio_FileNotFoundError")
    
    case kAudio_FilePermissionError :
    print("kAudio_FilePermissionError")
    
    case kAudio_TooManyFilesOpenError :
    print("kAudio_TooManyFilesOpenError")
    
    case kAudio_BadFilePathError :
    print("kAudio_BadFilePathError")
    
    case kAudio_ParamError :
    print("kAudio_ParamError") // the infamous -50
    
    case kAudio_MemFullError :
    print("kAudio_MemFullError")
    
    
    default:
    print("huh?")
    print("bad status \(status)")
    //print("\(__LINE__) bad status \(error)")
    }
    }
    
    #endif
    
    
}
