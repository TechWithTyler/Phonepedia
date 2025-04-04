//
//  ExampleAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/20/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct ExampleAudioView: View {

    @EnvironmentObject var audioManager: AudioManager

    var audioFile: AudioManager.AudioFile

    var title: String {
        switch audioFile {
            // Select the title based on the audio file.
        case .answeringSystemGreetingRecordMessage: return "Answering System \"Record Message\" Greeting"
        case .answeringSystemGreetingAnswerOnly: return "Answering System \"Answer Only\" Greeting"
        case .talkingCallerIDCNAM: return "Talking Caller ID (CNAM)"
        case .talkingCallerIDNumber: return "Talking Caller ID (Number As Name)"
        case .talkingCallerIDPhonebook: return "Talking Caller ID (Phonebook Entry Name)"
        case .callBlockPreScreeningCallerName:
            return "Call Block Pre-Screening Greeting (Caller Name)"
        case .callBlockPreScreeningCode:
            return "Call Block Pre-Screening Greeting (Code)"
        case .callBlockMessage:
            return "Call Block Message"
        case .stutterDialTone: return "Stutter Dial Tone (Voicemail Tone)"
        case .busyTone: return "Busy Tone"
        case .callWaitingTone: return "Call Waiting/CPE Alert Signal Tones"
        case .dtmfTones: return "DTMF Tones"
        case .dtmfToneD: return "DTMF Tone D"
        case .dtmfToneA: return "DTMF Tone A"
        case .pulseDialing: return "Pulse Dialing"
        case .ringAndCallerIDFSK: return "Ring Signal and Caller ID FSK Tone"
        case .dtmfCallerID: return "DTMF Caller ID"
        case .analogCordlessPhoneAudioSampleNormal: return "Analog Cordless Phone Audio Sample (Normal)"
        case .analogCordlessPhoneAudioSampleScrambled: return "Analog Cordless Phone Audio Sample (Scrambled)"
        }
    }

    var isPlayingAudioFile: Bool {
        return audioManager.isPlaying && audioManager.audioFile == audioFile
    }

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            PlayButton(isPlaying: isPlayingAudioFile) {
                audioManager.toggleAudio(audioFile: audioFile)
            }
            .accessibilityLabel(isPlayingAudioFile ? "Stop \(title)" : "Play \(title)")
            .accessibilityAddTraits(.startsMediaSession)
        }
        .onDisappear {
            audioManager.stopAudio()
        }
        .onChange(of: audioFile) { oldValue, newValue in
            if newValue != oldValue {
                audioManager.stopAudio()
            }
        }
    }

}

#Preview {
    ExampleAudioView(audioFile: .dtmfTones)
        .environmentObject(AudioManager())
        .padding()
}
