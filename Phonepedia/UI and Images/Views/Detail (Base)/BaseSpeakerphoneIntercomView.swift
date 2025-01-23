//
//  BaseSpeakerphoneIntercomView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseSpeakerphoneIntercomView: View {

    @Bindable var phone: Phone

    var body: some View {
        if !phone.isCordedCordless {
            Toggle(isOn: $phone.hasBaseSpeakerphone) {
                Text("Has Base Speakerphone")
            }
            .onChange(of: phone.hasBaseSpeakerphone) { oldValue, newValue in
                phone.hasBaseSpeakerphoneChanged(oldValue: oldValue, newValue: newValue)
            }
        }
        if phone.hasBaseSpeakerphone || (phone.isCordless && phone.hasBaseIntercom) || phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
            Picker("Speaker Volume Adjustment", selection: $phone.baseSpeakerVolumeAdjustmentType) {
                Text("Volume Switch/Dial").tag(0)
                Text("Volume Buttons").tag(1)
            }
        }
        if phone.isCordless {
            Toggle(isOn: $phone.hasIntercom) {
                Text("Has Intercom")
            }
            InfoText("Intercom allows you to have a conversation between 2 cordless devices/the base and a cordless device.")
            if phone.hasIntercom && !phone.hasBaseSpeakerphone && !phone.isCordedCordless {
                Toggle(isOn: $phone.hasBaseIntercom) {
                    Text("Has Base Intercom")
                }
            }
            if phone.hasIntercom && !phone.hasBaseIntercom && phone.cordlessHandsetsIHave.count <= 1 {
                WarningText("Intercom requires 2 or more handsets/desksets, or at least 1 handset/deskset and 1 headset/speakerphone, to be registered to the base.")
            }
        }
    }
}

#Preview {
    Form {
        BaseSpeakerphoneIntercomView(phone: Phone(brand: "AT&T", model: "CL82215"))
    }
    .formStyle(.grouped)
}
