//
//  HandsetAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetAudioView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            if handset.handsetStyle == 0 && handset.sideVolumeButtons {
                Picker("Speaker/Earpiece Volume Adjustment", selection: $handset.volumeAdjustmentType) {
                    Text("Volume Dial").tag(0)
                    Text("Volume Buttons").tag(1)
                }
            }
            if handset.handsetStyle < 2 {
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
                    if phone.hasIntercom {
                        Picker("Intercom Auto-Answer", selection: $handset.intercomAutoAnswer) {
                            Text("Not Supported").tag(0)
                            Text("With Ring").tag(1)
                            Text("Without Ring").tag(2)
                            Text("With or Without Ring").tag(3)
                        }
                        IntercomAutoAnswerInfoView()
                    }
                } else {
                    InfoText("Handsets without speakerphone play their key tones and ringtones through a piezo speaker.")
                }
            }
            if handset.cordlessDeviceType == 0 && handset.maxBases == 1 {
                Toggle("Supports Direct Communication Between Handsets", isOn: $handset.hasDirectCommunication)
                InfoText("Direct communication allows you to make calls between handsets registered to the same base without the base being involved, allowing you to do so while out of range of the base. This is done by finding a nearby handset that's registered to the same base with the handset number that was selected. The handset either allows selection of any possible handset number (even those that aren't registered to the base) or gets the handset list from the base and stores it in the handset.")
            }
            Toggle("Supports Wired Headsets", isOn: $handset.supportsWiredHeadsets)
            if handset.handsetStyle < 3 {
                Picker("Maximum Number Of Bluetooth Headphones", selection: $handset.bluetoothHeadphonesSupported) {
                    Text("None").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("4").tag(4)
                }
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetAudioView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGDA99", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
