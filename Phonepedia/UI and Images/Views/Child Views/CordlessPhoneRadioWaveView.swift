//
//  CordlessPhoneRadioWaveView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct CordlessPhoneRadioWaveView: View {

    // MARK: - Properties - Cordless Phone Frequencies

    // The cordless phone frequencies that can be selected using the slider, which excludes variants of a frequency (e.g. 5.8GHz over 900MHz).
    var availableFrequencies = Phone.CordlessFrequency.allCases.compactMap { $0.waveFrequency != 0 ? $0 : nil }.sorted { $1.waveFrequency > $0.waveFrequency }

    // The selected frequency.
    var selectedFrequency: Phone.CordlessFrequency {
        // The selected frequency is the item at selectedFrequencyIndex in the availableFrequencies array.
        return availableFrequencies[selectedFrequencyIndex]
    }

    // MARK: - Properties - Booleans

    // Whether the wave animation is playing.
    @State var isPlaying: Bool = false

    // Whether the device's Reduce Motion setting is enabled.
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    // MARK: - Properties - Floats

    // The wave animation phase.
    @State var phase: CGFloat = 0

    // MARK: - Properties - Doubles

    // The value of the frequency slider.
    @State var selectedFrequencySliderValue: Double = 0

    // MARK: - Properties - Integers

    // The index of the selected frequency, which is the selectedFrequencySliderValue Double value converted to Int.
    var selectedFrequencyIndex: Int {
        return Int(selectedFrequencySliderValue)
    }

    // MARK: - Body

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

    // MARK: - Wave

    @ViewBuilder
    var wave: some View {
        CordlessPhoneRadioWave(frequency: selectedFrequency, phase: phase)
            .stroke(Color.accentColor, lineWidth: 2)
            .animation(.linear, value: selectedFrequencySliderValue)
            .frame(height: 100)
            .accessibilityLabel("\(selectedFrequency.waveName) Wave")
    }

}

#Preview {
    CordlessPhoneRadioWaveView()
}
