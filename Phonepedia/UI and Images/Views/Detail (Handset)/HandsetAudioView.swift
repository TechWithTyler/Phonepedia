//
//  HandsetAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetAudioView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        Toggle("Has Speakerphone", isOn: $handset.hasSpeakerphone)
        if handset.hasSpeakerphone {
            Picker("Speakerphone Button Coloring", selection: $handset.speakerphoneColorLayer) {
                Text("None").tag(0)
                Text("Foreground").tag(1)
                Text("Background").tag(2)
            }
            PhoneButtonLegendItem(button: .speakerphone, colorLayer: handset.speakerphoneColorLayer)
            if handset.speakerphoneColorLayer > 0 {
                Toggle("Speakerphone Button Light", isOn: $handset.hasSpeakerphoneButtonLight)
                InfoText("The speakerphone button lights up when speakerphone is on.")
            }
        }
        Toggle("Supports Wired Headsets", isOn: $handset.supportsWiredHeadsets)
        Picker("Maximum Number Of Bluetooth Headphones", selection: $handset.bluetoothHeadphonesSupported) {
            Text("None").tag(0)
            Text("1").tag(1)
            Text("2").tag(2)
            Text("4").tag(4)
        }
    }
}

#Preview {
    Form {
        HandsetAudioView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGDA99", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0))
    }
    .formStyle(.grouped)
}
