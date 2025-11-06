//
//  HandsetRedialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetRedialView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        FormNumericTextField("Redial Capacity", value: $handset.redialCapacity, valueRange: .zeroToMax(handset.displayType > 0 ? 20 : 1), singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
        if handset.redialCapacity > 0 {
            Picker("Redial When Busy", selection: $handset.busyRedialMode) {
                Text("Not Supported").tag(0)
                Text("Press Redial Button").tag(1)
                Text("Auto-Redial").tag(2)
            }
            RedialWhenBusyInfoView()
        }
            if handset.hasPhonebookAndRedialList {
                Picker("Redial Name Display", selection: $handset.redialNameDisplay) {
                    Text("None").tag(0)
                    Text("Phonebook Match").tag(1)
                    Text("From Dialed Entry").tag(2)
                }
                RedialNameDisplayInfoView()
            }
            if handset.redialNameDisplay == 1 && handset.usesBasePhonebook && handset.phonebookCapacity == 0 {
                InfoText("Although the redial list is stored in the handset, it may still require you to be in range of the base if the handset doesn't have a fallback to display entries without their names.")
            }
    }
}

// MARK: - Preview

#Preview {
    Form {
        HandsetRedialView(handset: CordlessHandset(brand: "Uniden", model: "DCX320", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
    }
    .formStyle(.grouped)
}
