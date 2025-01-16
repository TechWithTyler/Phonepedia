//
//  HandsetCallerIDView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetCallerIDView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            Toggle(isOn: $handset.hasTalkingCallerID) {
                Text("Talking Caller ID")
            }
            if handset.phonebookCapacity > 0 || (phone.basePhonebookCapacity > 0 && handset.usesBasePhonebook) && handset.handsetStyle < 3 {
                Toggle(isOn: $handset.callerIDPhonebookMatch) {
                    Text("Caller ID Uses Matching Phonebook Entry Name")
                }
            }
            if handset.handsetStyle < 3 {
                FormNumericTextField("Caller ID List Capacity", value: $handset.callerIDCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                    .scrollDismissesKeyboard(.interactively)
#endif
                    .onChange(of: handset.callerIDCapacity) { oldValue, newValue in
                        handset.callerIDCapacityChanged(oldValue: oldValue, newValue: newValue)
                    }
            }
            if handset.callerIDCapacity == 0 || handset.handsetStyle == 3 {
                Toggle("Uses Base Caller ID List", isOn: $handset.usesBaseCallerID)
            }
            InfoText("When handsets use the base caller ID list instead of having their own, the caller ID list, and the indication/number of missed calls, is shared by the base and all handsets. Only one can access it at a time.")
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetCallerIDView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGA551", mainColorRed: 180, mainColorGreen: 180, mainColorBlue: 180, secondaryColorRed: 180, secondaryColorGreen: 180, secondaryColorBlue: 180, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
