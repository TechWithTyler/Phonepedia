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
        FormNumericTextField(phone.isCordless ? "Redial Capacity (base)" : "Redial Capacity", value: $phone.baseRedialCapacity, valueRange: .zeroToMax(20), singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        if phone.baseRedialCapacity > 1 && phone.basePhonebookCapacity > 0 {
            Picker("Redial Name Display", selection: $phone.redialNameDisplay) {
                Text("None").tag(0)
                Text("Phonebook Match").tag(1)
                Text("From Dialed Entry").tag(2)
            }
            RedialNameDisplayInfoView()
        }
    }
}

#Preview {
    Form {
        BaseRedialView(phone: Phone(brand: "AT&T", model: "706"))
    }
    .formStyle(.grouped)
}
