//
//  HandsetAudioView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetAudioView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
            if handset.handsetStyle < 2 {
            Section("Earpiece/Speakerphone") {
                if handset.handsetStyle == 0 && handset.sideVolumeButtons {
                    Picker("Speaker/Earpiece Volume Adjustment", selection: $handset.volumeAdjustmentType) {
                        Text("Volume Dial").tag(0)
                        Text("Volume Buttons").tag(1)
                    }
                }
                if handset.cordlessDeviceType == 0 {
                    Toggle("Has Speakerphone", isOn: $handset.hasSpeakerphone)
                }
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
                    } else {
                        InfoText("Handsets without speakerphone play their key tones and ringtones through a piezo speaker.")
                    }
                }
            }
            Section("Headsets") {
                Toggle("Supports Wired Headsets", isOn: $handset.supportsWiredHeadsets)
                if handset.handsetStyle < 3 {
                    CountPicker("Maximum Number of Bluetooth Headphones", selection: $handset.bluetoothHeadphonesSupported, startNumber: 1, multipliedBy: 2, endNumber: 4, singularSuffix: "Bluetooth Headphone", pluralSuffix: "Bluetooth Headphones", noneTitle: "None", unlimitedTitle: "Unlimited")
                }
            }
            if phone.hasIntercom {
                Section("Intercom") {
                    if handset.hasSpeakerphone || handset.handsetStyle > 2 {
                        Picker("Intercom Auto-Answer", selection: $handset.intercomAutoAnswer) {
                            IntercomAutoAnswerPickerItems()
                        }
                        IntercomAutoAnswerInfoView()
                    }
                    if handset.cordlessDeviceType == 0 && phone.maxCordlessHandsets != 1 {
                        Toggle("Supports Direct Communication Between Handsets", isOn: $handset.hasDirectCommunication)
                        InfoText("Direct communication allows you to make calls between handsets registered to the same base without the base being involved, allowing you to do so while out of range of the base. This is done by finding a nearby handset that's registered to the same base with the handset number that was selected. When a handset is registered to a base, it stores information about the base, so it can compare that information to that stored in the selected handset to check if they're both registered to the same base. The handset either allows selection of any possible handset number (even those that aren't registered to the base) or gets the handset list from the base and stores it in the handset.\nIf the handset(s) is/are registered to more than one base, you must set both handsets to use the same base.\nHandsets in direct communication mode can't communicate with the base. If such handsets are deregistered from the base, the handset won't know that until direct communication mode is disabled and the handset finds the base. Deregistered handsets can't use this feature.")
                    }
                }
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }
}

// MARK: - Preview

#Preview {
    Form {
        HandsetAudioView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGDA99", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
