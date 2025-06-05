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
                Text(phone.isCordless ? "Has Base Speakerphone" : "Has Speakerphone")
                if !phone.isCordless && !phone.isWiFiHandset && phone.cordedPowerSource == 0 {
                    InfoText("On a line-powered corded phone, speakerphone performance depends on the power the line provides to the phone while off-hook. If used on a line with very low off-hook power, you or your caller may have trouble hearing on the speakerphone, or it may not work at all, especially if more than one phone is off-hook.\nIf line power drops for long enough (this depends on the phone), the speakerphone won't come back on once line power comes back, so you don't have to hang up manually.")
                }
            }
            .onChange(of: phone.hasBaseSpeakerphone) { oldValue, newValue in
                phone.hasBaseSpeakerphoneChanged(oldValue: oldValue, newValue: newValue)
            }
        }
        if phone.hasBaseSpeakerphone && phone.isCordless && !phone.hasTransmitOnlyBase && !phone.hasCordedReceiver {
            Toggle("Supports Pick Up to Switch", isOn: $phone.hasPickUpToSwitch)
            InfoText("During a call on the base speakerphone with the handset placed on the base, you can pick up the handset to switch from the base speakerphone to the handset. This works in one of 3 ways:\n• If the base and handset both have 3 contacts (i.e., 2 charging contacts and a data contact), the call is immediately switched from the base to the handset since the presence of a call is passed through that data contact. The call will only switch over once the handset links to the base.\n• Through the charging contacts, the base detects that a handset is placed on it. When the handset is picked up, it links to the base, which then accepts the switchover since it's on speakerphone. If a handset is picked up from a charger (or a base it's not registered to), the handset will unlink and the call won't be switched, unless another handset is also being picked up from the base.\n• Through the charging contacts, both the base and handset detect that the handset is placed on the base, and picking up the handset switches the call to the handset. If the handset doesn't have a link to the base, an error tone may sound/an error message may be displayed and the call won't switch over. The call will only switch over once the handset links to the base.")
            if phone.hasPickUpToSwitch && phone.hasBaseIntercom {
                Picker("Handset<->Base Call Pickup Behavior", selection: $phone.handsetToBaseCallPickupBehavior) {
                    Text("Not Supported").tag(0)
                    Text("Move Call").tag(1)
                    Text("Conference Call").tag(2)
                }
                InfoText("• Not Supported: The base can't join a handset call, nor can the handset join a base call.\n• Move Call: When the base speakerphone is turned on during a call on the handset or vice versa, the call is moved to the handset/base and the other is dropped from the call. This is often seen on cordless hotel phones since they combine the best of both worlds: cordless convenience and corded familiarity.\n• Conference Call: The handset/base joins the call with the other.\nHandsets joining calls with other handsets will always create a conference call.")
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
            InfoText("Intercom allows you to have a conversation between 2 cordless devices/the base and a cordless device. It can also be used to transfer calls between cordless devices/the base and a cordless device, by allowing you to tell another person that you're transferring the call to them. When you hang your handset/base up or the other person accepts the call (this depends on the phone), the other person is connected to the call.\nSome phones have the option to transfer calls directly. When using the transfer option, or if using the intercom option and hanging up before the other person answers (this depends on the phone), the call rings at the base/cordless device the call was transferred to. This is how call transferring works on phones that don't have intercom.")
            if phone.hasIntercom {
                Picker("Call Privacy Mode", selection: $phone.callPrivacyMode) {
                    Text("Not Supported").tag(0)
                    Text("Per-Call Only").tag(1)
                    Text("All Calls").tag(2)
                }
                Text("Call privacy mode allows you to prevent the base and/or other cordless devices from joining a call. When call privacy is enabled for a call, the only way to create a conference call is once a call transfer intercom call is established between 2 cordless devices/the base and a cordless device, and the base/other cordless devices can't join that conference call. This feature is only useful when this cordless phone is the only phone on the line, since someone can still join the call using any other phone on the same line.")
            }
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
                InfoText("Push-To-Talk (PTT): You can use the handset/deskset/base like a walkie-talkie to talk with the base/another handset/deskset, or the base and all registered handsets/desksets, and anyone in the PTT session can respond.\nBroadcast to All: You can use a handset/deskset/base to broadcast a message to the base/all registered handsets/desksets, but no one can respond back unless someone answers to establish an intercom call (if answering a broadcast is supported).")
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
