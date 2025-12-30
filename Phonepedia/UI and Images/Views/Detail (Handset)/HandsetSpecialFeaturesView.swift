//
//  HandsetSpecialFeaturesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetSpecialFeaturesView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
            if handset.handsetStyle < 3 {
                Picker("Alarm", selection: $handset.alarm) {
                    Text("Not Supported").tag(0)
                    Divider()
                    Text("Ringtones").tag(1)
                    Text("Ringtones or Voice").tag(2)
                }
                InfoText("The handset can be used as an alarm clock by playing a ringtone or voice announcement at the set time(s).")
            }
            if handset.cordlessDeviceType == 0 && phone.isDigitalCordless && phone.cordlessDeviceLinkingMethod == 4 {
                CountPicker("Key Finders Supported", selection: $handset.keyFindersSupported, numbers: [1, 2, 4], noneTitle: "None")
                InfoText("By registering a key finder to a handset, you can use the handset to find lost items easily. If the handset is registered to a compatible base, key finder registrations can be used by any handset. Handsets in range will access the base's registration information and store it in the handset, while handsets out of range will access the registration information stored in them.")
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }
}

// MARK: - Preview

#Preview {
    Form {
        HandsetSpecialFeaturesView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGFA72", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
