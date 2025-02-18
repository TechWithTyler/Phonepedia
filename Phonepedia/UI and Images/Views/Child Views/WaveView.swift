//
//  WaveView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct WaveView: View {

    var availableFrequencies = Phone.CordlessFrequency.allCases.compactMap { $0.waveFrequency != 0 ? $0 : nil }.sorted { $1.waveFrequency > $0.waveFrequency }

    @Environment(\.accessibilityReduceMotion) var reduceMotion

    @State var phase: CGFloat = 0

    @State var isPlaying: Bool = false

    @State var selectedFrequencySliderValue: Double = 0

    var selectedFrequencyIndex: Int {
        return Int(selectedFrequencySliderValue)
    }

    var selectedFrequency: Phone.CordlessFrequency {
        return availableFrequencies[selectedFrequencyIndex]
    }

    var body: some View {
        VStack {
            Text("Select different frequencies and see how the wavelength changes.")
            Slider(value: $selectedFrequencySliderValue, in: .zeroToMax(Double(availableFrequencies.count-1)), step: 1) {
                Text("Frequency")
            } minimumValueLabel: {
                Text("Low")
            } maximumValueLabel: {
                Text("High")
            }
            .accessibilityValue(selectedFrequency.waveName)
            Text(selectedFrequency.waveName)
        }
        .onAppear {
            isPlaying = !reduceMotion
            selectedFrequencySliderValue = Double(availableFrequencies.firstIndex(of: .northAmericaDECT6)!)
        }
        .onDisappear {
            isPlaying = false
            phase = 0
        }
        VStack {
            if isPlaying {
                wave
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                            phase = 1
                        }
                    }
            } else {
                wave
            }
            Button(isPlaying ? "Stop Animation" : "Play Animation", systemImage: isPlaying ? "stop.fill" : "play.fill") {
                phase = 0
                isPlaying.toggle()
            }
            .buttonStyle(.borderless)
        }
    }

    @ViewBuilder
    var wave: some View {
        Wave(frequency: selectedFrequency, phase: phase)
            .stroke(Color.accentColor, lineWidth: 2)
            .animation(.linear, value: selectedFrequencySliderValue)
            .frame(height: 100)
            .accessibilityLabel("\(selectedFrequency.waveName) Wave")
    }

}

#Preview {
    WaveView()
}
