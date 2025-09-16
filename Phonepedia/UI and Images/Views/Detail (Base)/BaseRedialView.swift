//
//  BaseRedialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseRedialView: View {

    @Bindable var phone: Phone

    var body: some View {
        FormNumericTextField(phone.isCordless ? "Redial Capacity (Base)" : "Redial Capacity", value: $phone.baseRedialCapacity, valueRange: .zeroToMax(phone.baseDisplayType > 2 ? 20 : 1), singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        if phone.baseRedialCapacity > 0 && (phone.isCordless || !phone.isLinePoweredCorded) {
            Picker("Redial When Busy", selection: $phone.busyRedialMode) {
                Text("Not Supported").tag(0)
                Text("Press Redial Button").tag(1)
                Text("Auto-Redial").tag(2)
            }
            RedialWhenBusyInfoView()
        }
        if phone.baseRedialCapacity > 1 && phone.basePhonebookCapacity > 0 {
            Picker("Redial Name Display", selection: $phone.redialNameDisplay) {
                Text("None").tag(0)
                Text("Phonebook Match").tag(1)
                Text("From Dialed Entry").tag(2)
            }
            RedialNameDisplayInfoView()
        }
        InfoText("On many phones, the redial button has another function, pause. Inserting a pause in a dialing sequence tells the phone to wait for a few seconds before dialing more digits. This is often used if storing a number which requires more digits to be entered after the call connects, such as your voicemail access number and password. These functions are often the same button since they're both related to dialing.")
    }
}

#Preview {
    Form {
        BaseRedialView(phone: Phone(brand: "AT&T", model: "706"))
    }
    .formStyle(.grouped)
}
