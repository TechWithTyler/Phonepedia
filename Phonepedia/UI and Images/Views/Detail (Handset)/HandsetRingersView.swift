//
//  HandsetRingersView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetRingersView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            Stepper("Standard Ringtones: \(handset.ringtones)", value: $handset.ringtones, in: 1...50)
            Stepper("Music/Melody Ringtones: \(handset.musicRingtones)", value: $handset.musicRingtones, in: 0...50)
            Text("Total Ringtones: \(handset.totalRingtones)")
            RingtoneInfoView()
            if handset.hasSpeakerphone {
                Picker("Custom Ringtones Source", selection: $handset.customRingtonesSource) {
                    Text("None").tag(0)
                    Text("Recording Only").tag(1)
                    Text("Audio Files Only").tag(2)
                    Text("Recording/Audio Files").tag(3)
                }
                InfoText("Some handsets allow you to record audio to use as ringtones, transfer audio files from a device to use as ringtones, or both.")
            }
            if phone.hasIntercom {
                Picker("Intercom Ringtone", selection: $handset.intercomRingtone) {
                    Text("Intercom-Specific Ringtone").tag(0)
                    if handset.totalRingtones > 1 {
                        Text("Selectable Ringtone").tag(1)
                    }
                    ForEach(0..<handset.totalRingtones, id: \.self) { ringtoneNumber in
                        Text("Tone \(ringtoneNumber+1)").tag(ringtoneNumber + 2)
                    }
                }
                .onChange(of: handset.totalRingtones) {
                    oldValue, newValue in
                    handset.totalRingtonesChanged(oldValue: oldValue, newValue: newValue)
                }
            }
            if handset.cordlessDeviceType == 0 {
                Toggle("Has Vibrator Motor", isOn: $handset.hasVibratorMotor)
                InfoText("Some cordless handsets have vibrator motors like cell phones.")
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetRingersView(handset: CordlessHandset(brand: "Vtech", model: "DS6401-16", mainColorRed: 255, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
    }
    .formStyle(.grouped)
}
