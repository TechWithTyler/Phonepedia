//
//  PhoneAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneAudioView: View {

    @Bindable var phone: Phone

    var body: some View {
        if phone.hasCordedReceiver || phone.hasBaseSpeakerphone {
            Toggle("Base Supports Wired Headsets", isOn: $phone.baseSupportsWiredHeadsets)
        }
        Picker("Maximum Number Of Bluetooth Headphones (base)", selection: $phone.baseBluetoothHeadphonesSupported) {
            Text("None").tag(0)
            Text("1").tag(1)
            Text("2").tag(2)
            Text("4").tag(4)
        }
    }
}

#Preview {
    Form {
        PhoneAudioView(phone: Phone(brand: "Panasonic", model: "KX-TG7873"))
    }
    .formStyle(.grouped)
}
