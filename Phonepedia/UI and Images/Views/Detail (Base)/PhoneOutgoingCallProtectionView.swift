//
//  PhoneOutgoingCallProtectionView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/5/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneOutgoingCallProtectionView: View {

    @Bindable var phone: Phone

    var body: some View {
        if phone.hasBaseKeypad {
            Toggle("Has Keypad Lock", isOn: $phone.hasKeypadLock)
            KeypadLockInfoView()
        }
        Picker("Call Restriction", selection: $phone.callRestriction) {
            Text("None").tag(0)
            Text("Disallow Specific Numbers").tag(1)
            Text("Emergency Calls Only").tag(2)
        }
        InfoText("Call restriction allows you to prevent outgoing calls to certain numbers, either by disallowing specific numbers and/or number prefixes, or by only allowing emergency calls. Depending on the phone, this means only the emergency number (e.g., 911 in the US or 999/112 in the UK) can be dialed, or numbers you want to designate as emergency numbers can be saved to the phonebook.\nOn some cordless phones, the list of disallowed numbers can be applied to specific handsets.")
    }

}

#Preview {
    PhoneOutgoingCallProtectionView(phone: Phone(brand: Phone.mockBrand, model: Phone.mockModel))
}
