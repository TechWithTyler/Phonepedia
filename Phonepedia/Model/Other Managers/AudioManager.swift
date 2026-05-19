//
//  AudioManager.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/20/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import AVFoundation

class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {

    // MARK: - Audio File Enum

    enum AudioFile: String {

        // The audio file for the example answering system "record message" greeting.
        case answeringSystemGreetingRecordMessage = "answeringSystemGreetingRecordMessage"

        // The audio file for the example answering system "answer only" greeting.
        case answeringSystemGreetingAnswerOnly = "answeringSystemGreetingAnswerOnly"

        // The audio file for the example talking caller ID announcement for a caller ID name.
        case talkingCallerIDCNAM = "talkingCallerIDCNAM"

        // The audio file for the example talking caller ID announcement for a caller ID number.
        case talkingCallerIDNumber = "talkingCallerIDNumber"

        // The audio file for the example talking caller ID announcement for a phonebook entry
        case talkingCallerIDPhonebook = "talkingCallerIDPhonebook"

        // The audio file for the example call block pre-screening announcement asking for a caller name.
        case callBlockPreScreeningCallerName = "callBlockPreScreeningCallerName"

        // The audio file for the example call block pre-screening announcement asking for a code to be entered.
        case callBlockPreScreeningCode = "callBlockPreScreeningCode"

        // The audio file for the example call block message.
        case callBlockMessage = "callBlockMessage"

        // The audio file for a US stutter dial tone (voicemail tone).
        case stutterDialTone = "stutterDialTone"

        // The audio file for a US busy tone.
        case busyTone = "busyTone"

        // The audio file for a US call waiting tone.
        case callWaitingTone = "callWaitingTone"

        // The audio file for DTMF tones 0-9, star, and pound.
        case dtmfTones = "dtmfTones"

        // The audio file for DTMF tone D.
        case dtmfToneD = "dtmfToneD"

        // The audio file for DTMF tone A.
        case dtmfToneA = "dtmfToneA"

        // The audio file for pulse dialing.
        case pulseDialing = "pulseDialing"

        // The audio file for a US ring signal and caller ID FSK tone.
        case ringAndCallerIDFSK = "ringAndCallerIDFSK"

        // The audio file for DTMF caller ID.
        case dtmfCallerID = "dtmfCallerID"

        // The audio file for an analog cordless phone audio sample.
        case analogCordlessPhoneAudioSampleNormal = "analogCordlessPhoneAudioSampleNormal"

        // The audio file for an analog cordless phone audio sample that has had its frequencies inverted (frequency inversion voice scramble).
        case analogCordlessPhoneAudioSampleScrambled = "analogCordlessPhoneAudioSampleScrambled"

    }

    // MARK: - Properties - Booleans

    var isPlaying: Bool {
        return audioFile != nil
    }

    // MARK: - Properties - AVAudioPlayer

    @Published var audioPlayer: AVAudioPlayer?

    // MARK: - Properties - Audio File

    @Published var audioFile: AudioFile? = nil

    // MARK: - Play/Stop

    // This method starts or stops playing the audio file with the given name.
    func toggleAudio(audioFile: AudioFile) {
        // 1. If the audio file to be played is already playing, stop it and return.
        if isPlaying && self.audioFile == audioFile {
            stopAudio()
            return
        }
        // 2. Set the audio file to be played to the given audio file.
        self.audioFile = audioFile
        // 3. Make sure the audio file is present in the app bundle.
        guard let url = Bundle.main.url(forResource: audioFile.rawValue, withExtension: "wav") else {
            fatalError("Failed to find \(audioFile.rawValue).wav in bundle")
        }
        // 4. Try to load the file into the player and play it.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            fatalError("Error playing audio file \(audioFile.rawValue).wav: \(error.localizedDescription)")
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioFile = nil
    }

    // MARK: - AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully success: Bool) {
        audioFile = nil
        if !success {
            fatalError("Failed to play audio")
        }
    }

}

