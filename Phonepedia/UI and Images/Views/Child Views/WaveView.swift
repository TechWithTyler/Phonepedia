//
//  WaveView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct WaveView: View {
    var body: some View {
        VStack {
            Text("Shorter wavelength, higher frequency, less range")
                .font(.caption)
            Wave(frequency: .highLessRange)
                .stroke(Color.primary, lineWidth: 2)
                .frame(height: 100)
                .accessibilityLabel("High-Frequency Wave")
        }
        VStack {
            Text("Longer wavelength, lower frequency, more range")
                .font(.caption)
            Wave(frequency: .lowMoreRange)
                .stroke(Color.primary, lineWidth: 2)
                .frame(height: 100)
                .accessibilityLabel("Low-Frequency Wave")
        }
    }
}

#Preview {
    WaveView()
}
