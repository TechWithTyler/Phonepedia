//
//  HandsetSpeedDialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetSpeedDialView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        Toggle("Has One-Touch Emergency Calling", isOn: $handset.hasOneTouchEmergencyCalling)
        OneTouchEmergencyCallingInfoView()
        Stepper("Dial-Key Speed Dial Capacity: \(handset.speedDialCapacity)", value: $handset.speedDialCapacity, in: .zeroToMax(handset.voicemailQuickDial == 2 ? 9 : 10))
        if handset.handsetStyle < 3 {
            Toggle("Uses Base Speed Dial", isOn: $handset.usesBaseSpeedDial)
            Stepper("One-Touch Dial Buttons: \(handset.oneTouchDialCapacity)", value: $handset.oneTouchDialCapacity, in: .zeroToMax(4))
        Toggle("Uses Base One-Touch Dials", isOn: $handset.usesBaseOneTouchDial)
            InfoText("The handset can use the speed dials/one-touch dials stored in the base, or its own entries if the base doesn't share the entries between the base/handsets.")
            if handset.speedDialCapacity > 0 && (handset.phonebookCapacity > 0 || handset.usesBasePhonebook) {
                Picker("Speed Dial Entry Mode", selection: $handset.speedDialPhonebookEntryMode) {
                    Text("Manual or Phonebook (Copy)").tag(0)
                    Text("Phonebook Only (Copy)").tag(1)
                    Text("Phonebook Only (Link)").tag(2)
                }
            }
            SpeedDialEntryModeInfoView()
        }
    }
}

#Preview {
    Form {
        HandsetSpeedDialView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGEA20", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 255, secondaryColorGreen: 255, secondaryColorBlue: 255, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
    }
    .formStyle(.grouped)
}
