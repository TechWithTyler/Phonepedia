//
//  HandsetSpeedDialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetSpeedDialView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        Stepper("Dial-Key Speed Dial Capacity: \(handset.speedDialCapacity)", value: $handset.speedDialCapacity, in: handset.voicemailQuickDial == 2 ? 0...9 : 0...10)
        Stepper("One-Touch/Memory Dial: \(handset.oneTouchDialCapacity)", value: $handset.oneTouchDialCapacity, in: 0...4)
        Toggle("Uses Base Speed Dial", isOn: $handset.usesBaseSpeedDial)
        Toggle("Uses Base One-Touch Dial", isOn: $handset.usesBaseOneTouchDial)
        InfoText("The handset can use the speed dial/one-touch dial entries stored in the base, or its own entries if the base doesn't share the entries between the base/handsets.")
        Picker("Speed Dial Entry Mode", selection: $handset.speedDialPhonebookEntryMode) {
            Text("Manual or Phonebook (copy)").tag(0)
            Text("Phonebook Only (copy)").tag(1)
            Text("Phonebook Only (link)").tag(2)
        }
    }
}

#Preview {
    Form {
        HandsetSpeedDialView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGEA20", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 255, secondaryColorGreen: 255, secondaryColorBlue: 255))
    }
    .formStyle(.grouped)
}
