//
//  HandsetCallerIDView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetCallerIDView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        Section("Features") {
            if handset.hasPhonebook && handset.handsetStyle < 3 {
                Toggle(isOn: $handset.callerIDPhonebookMatch) {
                    Text("Caller ID Name Uses Matching Phonebook Entry Name")
                }
            }
            Toggle(isOn: $handset.hasTalkingCallerID) {
                Text("Talking Caller ID")
            }
            if handset.hasTalkingCallerID {
                if handset.callerIDPhonebookMatch {
                    ExampleAudioView(audioFile: .talkingCallerIDPhonebook)
                }
                ExampleAudioView(audioFile: .talkingCallerIDCNAM)
                ExampleAudioView(audioFile: .talkingCallerIDNumber)
            }
        }
        Section("List") {
            if handset.handsetStyle < 3 {
                FormNumericTextField("Capacity", value: $handset.callerIDCapacity, valueRange: 0...Int.max, singularSuffix: "entry", pluralSuffix: "entries")
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
        }
    }
}

// MARK: - Preview

#Preview {
    Form {
        HandsetCallerIDView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGA551", mainColorRed: 180, mainColorGreen: 180, mainColorBlue: 180, secondaryColorRed: 180, secondaryColorGreen: 180, secondaryColorBlue: 180, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
