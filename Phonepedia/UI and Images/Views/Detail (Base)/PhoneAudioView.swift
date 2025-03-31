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
            Toggle(phone.isCordless ? "Base Supports Wired Headsets" : "Supports Wired Headsets", isOn: $phone.baseSupportsWiredHeadsets)
        }
        Picker(phone.isCordless ? "Maximum Number Of Bluetooth Headphones (base)" : "Maximum Number Of Bluetooth Headphones", selection: $phone.baseBluetoothHeadphonesSupported) {
            Text("None").tag(0)
            Divider()
            Text("1").tag(1)
            Text("2").tag(2)
            Text("4").tag(4)
            Divider()
            Text("Unlimited").tag(Int.max)
        }
    }
}

#Preview {
    Form {
        PhoneAudioView(phone: Phone(brand: "Panasonic", model: "KX-TG7873"))
    }
    .formStyle(.grouped)
}
