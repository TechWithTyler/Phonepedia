//
//  BaseRedialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct BaseRedialView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        FormNumericTextField(phone.isCordless ? "Capacity (Base)" : "Capacity", value: $phone.baseRedialCapacity, valueRange: .zeroToMax(phone.baseDisplayType > 2 ? 20 : 1), singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        if phone.baseRedialCapacity > 1 {
            Picker("During Call", selection: $phone.redialDuringCall) {
                RedialDuringCallPickerItems()
            }
        }
        if phone.baseRedialCapacity > 0 && (phone.isCordless || !phone.isLinePoweredCorded) {
            Picker("When Busy", selection: $phone.busyRedialMode) {
                RedialWhenBusyPickerItems()
            }
            RedialWhenBusyInfoView()
        }
        if phone.baseRedialCapacity > 1 && phone.basePhonebookCapacity > 0 {
            Picker("Name Display", selection: $phone.redialNameDisplay) {
                RedialNameDisplayPickerItems()
            }
            RedialNameDisplayInfoView()
        }
        InfoText("On many phones, the redial button has another function, pause. Inserting a pause in a dialing sequence tells the phone to wait for a few seconds before dialing more digits. This is often used if storing a number which requires more digits to be entered after the call connects, such as your voicemail access number and password. These functions are often the same button since they're both related to dialing.")
    }

}

// MARK: - Preview

#Preview {
    Form {
        BaseRedialView(phone: Phone(brand: "AT&T", model: "706"))
    }
    .formStyle(.grouped)
}
