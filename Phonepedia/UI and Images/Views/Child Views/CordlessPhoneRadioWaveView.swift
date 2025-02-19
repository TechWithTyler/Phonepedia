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
    var availableFrequencies = Phone.CordlessFrequency.allCases.compactMap { $0.waveFrequency != 0 ? $0 : nil }.sorted { $1.waveFrequency > $0.waveFrequency }

    var selectedFrequency: Phone.CordlessFrequency {
        return availableFrequencies[selectedFrequencyIndex]
    }

    // MARK: - Properties - Booleans
    @State var isPlaying: Bool = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    // MARK: - Properties - Floats
    @State var phase: CGFloat = 0
    @State private var timer: Timer? = nil

    // MARK: - Properties - Doubles
    @State var selectedFrequencySliderValue: Double = 0

    // MARK: - Properties - Integers
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
            stopAnimation()
        }
        VStack {
            wave
                .onAppear {
                    if isPlaying {
                        startAnimation()
                    }
                }
                .onChange(of: isPlaying) { oldValue, newValue in
                    if newValue {
                        startAnimation()
                    } else {
                        stopAnimation()
                    }
                }
            PlayButton(playTitle: "Play Animation", stopTitle: "Stop Animation", isPlaying: isPlaying) {
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
            .frame(height: 100)
            .animation(isPlaying ? .linear(duration: 0.25) : nil, value: isPlaying ? phase : nil)
            .accessibilityLabel("\(selectedFrequency.waveName) Wave")
    }

    // MARK: - Wave Animation

    private func startAnimation() {
        stopAnimation()
        phase += 0.1
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            phase += 0.1
        }
    }

    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }

}

#Preview {
    CordlessPhoneRadioWaveView()
}
