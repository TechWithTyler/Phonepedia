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
        if !phone.isCordedCordless && !phone.isWiFiHandset {
            Toggle(isOn: $phone.hasBaseSpeakerphone) {
                Text("Has Base Speakerphone")
            }
            .onChange(of: phone.hasBaseSpeakerphone) { oldValue, newValue in
                phone.hasBaseSpeakerphoneChanged(oldValue: oldValue, newValue: newValue)
            }
        }
        if phone.hasBaseSpeakerphone && phone.isCordless && !phone.hasTransmitOnlyBase && !phone.hasCordedReceiver {
            Toggle("Supports Pick Up to Switch", isOn: $phone.hasPickUpToSwitch)
            InfoText("During a call on the base speakerphone with the handset placed on the base, you can pick up the handset to switch from the base speakerphone to the handset.")
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
            InfoText("Intercom allows you to have a conversation between 2 cordless devices/the base and a cordless device. It can also be used to transfer calls between cordless devices/the base and a cordless device, by allowing you to tell another person that you're transferring the call to them. When you hang your handset/base up or the other person accepts the call (this depends on the phone), the other person is connected to the call.\nSome phones have the option to transfer calls directly. When using the transfer option, or if using the intercom option and hanging up before the other person (this depends on the phone), the call rings at the base/cordless device the call was transferred to. This is how call transferring works on phones that don't have intercom.")
            if phone.hasIntercom && !phone.hasBaseSpeakerphone && !phone.isCordedCordless {
                Toggle(isOn: $phone.hasBaseIntercom) {
                    Text("Has Base Intercom")
                }
            }
            if phone.hasBaseIntercom {
                Picker("Intercom Auto-Answer", selection: $phone.intercomAutoAnswer) {
                    Text("Not Supported").tag(0)
                    Text("With Ring").tag(1)
                    Text("Without Ring").tag(2)
                    Text("With or Without Ring").tag(3)
                }
                IntercomAutoAnswerInfoView()
            }
            if phone.hasIntercom {
                Picker("Push-To-Talk (PTT) or Broadcast", selection: $phone.pushToTalkOrBroadcastToAll) {
                    Text("None").tag(0)
                    Text("Push-To-Talk (PTT)").tag(1)
                    Text("Broadcast to \(phone.hasBaseIntercom ? "Base/All HS" : "All HS")").tag(2)
                }
                InfoText("Push-To-Talk (PTT): You can use the handset/base like a walkie-talkie.\nBroadcast to All: You can use a handset/deskset/base to broadcast a message to the base/all registered handsets/desksets.")
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
