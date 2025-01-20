//
//  AudioManager.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/20/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

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

    }

    // MARK: - Properties - Booleans

    @Published var isPlaying: Bool = false

    // MARK: - Properties - AVAudioPlayer

    var audioPlayer: AVAudioPlayer?

    var audioFile: AudioFile? = nil

    // MARK: - Playing

    func toggleAudio(audioFile: AudioFile) {
        if isPlaying && self.audioFile == audioFile {
            stopAudio()
            return
        }
        self.audioFile = audioFile
        guard let url = Bundle.main.url(forResource: audioFile.rawValue, withExtension: "wav") else {
            fatalError("Failed to find \(audioFile.rawValue).wav in bundle")
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isPlaying = true
        } catch {
            fatalError("Error playing audio file \(audioFile.rawValue).wav: \(error.localizedDescription)")
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioFile = nil
        isPlaying = false
    }

    // MARK: - AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully success: Bool) {
        isPlaying = false
        audioFile = nil
        if !success {
            fatalError("Failed to play audio")
        }
    }

}

