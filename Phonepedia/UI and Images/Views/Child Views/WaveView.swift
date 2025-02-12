//
//  WaveView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct WaveView: View {

    var availableFrequencies = Phone.CordlessFrequency.allCases.compactMap { $0.waveFrequency != 0 ? $0 : nil }.sorted { $1.waveFrequency > $0.waveFrequency }

    @State var selectedFrequency: Phone.CordlessFrequency = .northAmericaDECT6

    var body: some View {
        VStack {
            Picker("Frequency", selection: $selectedFrequency) {
                ForEach(availableFrequencies, id: \.self) { frequency in
                    Text(frequency.waveName).tag(frequency.waveFrequency)
                }
            }
            Button("Random") {
                selectedFrequency = availableFrequencies.randomElement()!
            }
            Text("\(selectedFrequency.waveName)")
                .font(.caption)
            Wave(frequency: selectedFrequency)
                .stroke(Color.primary, lineWidth: 2)
                .animation(.linear, value: selectedFrequency)
                .frame(height: 100)
                .accessibilityLabel("\(selectedFrequency.waveName) Wave")
        }
    }
}

#Preview {
    WaveView()
}
