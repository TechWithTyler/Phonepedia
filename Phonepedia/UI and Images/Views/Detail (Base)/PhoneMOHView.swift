//
//  PhoneMOHView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneMOHView: View {

    @Bindable var phone: Phone

    var body: some View {
        Toggle("Preset Audio", isOn: $phone.musicOnHoldPreset)
        Toggle("User-Recorded", isOn: $phone.musicOnHoldRecord)
        if phone.supportsWiredHeadsets {
            Toggle("Live Input", isOn: $phone.musicOnHoldLive)
        }
        InfoText("When a call is put on hold, the caller can hear music or a message, which can be audio built into the phone, recorded by the user, or a live feed of a connected audio device for phones that support wired headsets. For phones without MOH, the caller just hears silence.")
    }
}

#Preview {
    Form {
        PhoneMOHView(phone: Phone(brand: "Panasonic", model: "KX-TGW420"))
    }
    .formStyle(.grouped)
}
