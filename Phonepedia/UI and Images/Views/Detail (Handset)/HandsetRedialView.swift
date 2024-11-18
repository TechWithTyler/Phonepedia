//
//  HandsetRedialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetRedialView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            FormNumericTextField("Redial Capacity", value: $handset.redialCapacity, valueRange: .zeroToMax(20), singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
            if handset.redialCapacity > 1 && (handset.phonebookCapacity > 0 || (phone.basePhonebookCapacity > 0 && handset.usesBasePhonebook)) {
                Picker("Redial Name Display", selection: $handset.redialNameDisplay) {
                    Text("None").tag(0)
                    Text("Phonebook Match").tag(1)
                    Text("From Dialed Entry").tag(2)
                }
                RedialNameDisplayInfoView()
            }
            if handset.redialNameDisplay == 1 && handset.usesBasePhonebook {
                InfoText("Although the redial list is stored in the handset, it may still require you to be in range of the base if the handset doesn't have a fallback to display entries without their names.")
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetRedialView(handset: CordlessHandset(brand: "Uniden", model: "DCX320", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 200, secondaryColorGreen: 200, secondaryColorBlue: 200))
    }
    .formStyle(.grouped)
}
