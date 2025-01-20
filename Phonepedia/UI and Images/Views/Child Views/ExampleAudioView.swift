//
//  ExampleAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/20/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct ExampleAudioView: View {

    @EnvironmentObject var audioManager: AudioManager

    var audioFile: AudioManager.AudioFile

    var title: String {
        switch audioFile {
        // Select the title based on the audio file.
        case .answeringSystemGreetingRecordMessage: return "Answering System \"Record Message\" Greeting"
        case .answeringSystemGreetingAnswerOnly: return "Answering System \"Answer Only\" Greeting"
        case .talkingCallerIDCNAM: return "Talking Caller ID (CNAM)"
        case .talkingCallerIDNumber: return "Talking Caller ID (Number)"
        case .talkingCallerIDPhonebook: return "Talking Caller ID (Phonebook Entry Name)"
        case .callBlockPreScreeningCallerName:
            return "Call Block Pre-Screening Greeting (Caller Name)"
        case .callBlockPreScreeningCode:
            return "Call Block Pre-Screening Greeting (Code)"
        case .callBlockMessage:
            return "Call Block Message"
        }
    }

    var isPlayingAudioFile: Bool {
        return audioManager.isPlaying && audioManager.audioFile == audioFile
    }

    var body: some View {
        HStack {
            Text("Example \(title)")
            Spacer()
            Button(isPlayingAudioFile ? "Stop" : "Play", systemImage: isPlayingAudioFile ? "stop.fill" : "play.fill") {
                audioManager.toggleAudio(audioFile: audioFile)
            }
            .accessibilityLabel(isPlayingAudioFile ? "Stop Example \(title)" : "Play Example \(title)")
            .accessibilityAddTraits(.startsMediaSession)
            .animatedSymbolReplacement()
            .buttonStyle(.borderless)
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
    ExampleAudioView(audioFile: .answeringSystemGreetingAnswerOnly)
        .environmentObject(AudioManager())
        .padding()
}
