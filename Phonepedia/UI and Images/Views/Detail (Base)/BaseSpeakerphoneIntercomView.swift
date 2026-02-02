//
//  BaseSpeakerphoneIntercomView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct BaseSpeakerphoneIntercomView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Section("Speaker/Speakerphone") {
            if !phone.isCordedCordless && phone.basePhoneType == 0 {
                Toggle(isOn: $phone.hasBaseSpeakerphone) {
                    Text(phone.isCordless ? "Has Base Speakerphone" : "Has Speakerphone")
                }
                .onChange(of: phone.hasBaseSpeakerphone) { oldValue, newValue in
                    phone.hasBaseSpeakerphoneChanged(oldValue: oldValue, newValue: newValue)
                }
                if phone.isLinePoweredCorded {
                    InfoText("On a line-powered corded phone, speakerphone performance depends on the power the line provides to the phone while off-hook. If used on a line with very low off-hook power, or multiple phones on the line are off-hook, you may have trouble hearing the caller and they might have trouble hearing you, or it may not work at all.\nIf line power drops for long enough, depending on the phone, the speakerphone won't come back on once line power comes back, so you don't have to hang up manually.")
                }
            }
            if phone.hasBaseSpeaker {
                Picker("Speaker Volume Adjustment", selection: $phone.baseSpeakerVolumeAdjustmentType) {
                    Text("Volume Switch/Dial").tag(0)
                    Text("Volume Buttons").tag(1)
                }
            }
        }
        if phone.isCordless {
            Section("Multi-Device Calls") {
                if phone.hasBaseSpeakerphone && phone.baseChargesHandset {
                    Toggle("Supports Pick Up to Switch", isOn: $phone.hasPickUpToSwitch)
                    InfoText("During a call on the base speakerphone with the handset placed on the base, you can pick up the handset to switch from the base speakerphone to the handset. This works in one of 3 ways:\n• If the base and handset both have 3 contacts (i.e., 2 charging contacts and a data contact), the call is immediately switched from the base to the handset since the presence of a call is passed through that data contact. The call will only switch over once the handset links to the base.\n• Through the charging contacts, the base detects that a handset is placed on it. When the handset is picked up, it links to the base, which then accepts the switchover since it's on speakerphone. If a handset is picked up from a charger (or a base it's not registered to), the handset will unlink and the call won't be switched, unless another handset is also being picked up from the base.\n• Through the charging contacts, both the base and handset detect that the handset is placed on the base, and picking up the handset switches the call to the handset. If the handset doesn't have a link to the base, an error tone may sound/an error message may be displayed and the call won't switch over.\nThe call will only switch over once the handset links to the base.")
                    if phone.hasPickUpToSwitch && phone.hasBaseIntercom {
                        Picker("Handset <-> Base Call Pickup Behavior", selection: $phone.handsetToBaseCallPickupBehavior) {
                            Text("Not Supported").tag(0)
                            Text("Move Call").tag(1)
                            Text("Conference Call").tag(2)
                        }
                        InfoText("• Not Supported: The base can't join a handset call, nor can the handset join a base call.\n• Move Call: When the base speakerphone is turned on during a call on the handset or vice versa, the call is moved to the handset/base and the other is dropped from the call. Depending on the phone, picking up the call on the base may create a conference call instead of moving the call to the base if the last handset to pick up/make a call isn't the one last placed on the base. This is often seen on cordless hotel phones since they combine the best of both worlds: cordless convenience and corded familiarity.\n• Conference Call: The handset/base joins the call with the other.\nHandsets joining calls with other handsets will always create a conference call.")
                    }
                }
                Toggle(isOn: $phone.hasIntercom) {
                    Text("Has Intercom")
                }
                InfoText("Intercom allows you to have a conversation between 2 cordless devices/the base and a cordless device. It can also be used to transfer calls between cordless devices/the base and a cordless device, by allowing you to tell another person that you're transferring the call to them.\nManuals for cordless phones with intercom often use the term \"outside call\". This refers to regular calls made over the phone line/network or a paired Bluetooth cell phone.")
                if phone.hasIntercom {
                    Picker("Call Transfer Type", selection: $phone.callTransferType) {
                        Text("Blind Only").tag(0)
                        Text("Intercom Only").tag(1)
                        Text("Intercom or Blind").tag(2)
                    }
                    InfoText("Call transfer allows you to transfer a call between cordless devices/the base and a cordless device, just like how phones (extensions) on a PBX system can transfer calls between each other. The terminology between cordless phone call transfer and PBX call transfer is similar.\n• Blind Only: The destination base/cordless device rings, and is connected to the outside call upon answering. Depending on the phone, you can hang up while the destination is ringing, and the call will ring back to you if the destination doesn't answer. This method of call transfer is sometimes called \"unattended transfer\".\n• Intercom Only: An intercom call is established between your base/cordless device and the destination. You can then have an intercom call and let the other person know you're transferring the call to them. This method of call transfer is sometimes called \"attended transfer\". The way the transfer is completed depends on the phone. Some allow you to hang up your base/cordless device, while others require the destination to pick up (or end the intercom call and then pick up).\n• Intercom or Blind: You can transfer the call either via intercom or via blind transfer. On some phones, these are separate in-call options, while on others, blind transfer is done by hanging up your base/cordless device while the destination rings for intercom.")
                    Picker("Call Privacy Mode", selection: $phone.callPrivacyMode) {
                        Text("Not Supported").tag(0)
                        Text("Per-Call Only").tag(1)
                        Text("All Calls").tag(2)
                    }
                    InfoText("Call privacy mode allows you to prevent the base and/or other cordless devices from joining a call. When call privacy is enabled for a call, the only way to create a conference call is once a call transfer intercom call is established between 2 cordless devices/the base and a cordless device, and the base/other cordless devices can't join that conference call. This feature is only useful when this cordless phone is the only phone on the line, since someone can still join the call using any other phone on the same line.")
                }
                if phone.hasIntercom && !phone.canTalkOnBase {
                    Toggle(isOn: $phone.hasBaseIntercom) {
                        Text("Has Base Intercom")
                    }
                    .onChange(of: phone.hasBaseIntercom) { oldValue, newValue in
                        phone.hasBaseIntercomChanged(oldValue: oldValue, newValue: newValue)
                    }
                }
                if phone.hasBaseIntercom {
                    Picker("Intercom Auto-Answer", selection: $phone.intercomAutoAnswer) {
                        IntercomAutoAnswerPickerItems()
                    }
                    IntercomAutoAnswerInfoView()
                }
                if phone.hasIntercom {
                    Picker("Call Join/Leave Tone", selection: $phone.joinLeaveTone) {
                        JoinLeaveTonePickerItems()
                    }
                    JoinLeaveToneInfoView()
                    Picker("Push-To-Talk (PTT) or Broadcast", selection: $phone.pushToTalkOrBroadcastToAll) {
                        Text("None").tag(0)
                        Text("Push-To-Talk (PTT)").tag(1)
                        Text("Broadcast to \(phone.hasBaseIntercom ? "Base/All HS" : "All HS")").tag(2)
                    }
                    InfoText("Push-To-Talk (PTT): You can use the handset/deskset/base like a walkie-talkie to talk with the base/another handset/deskset, or the base and all registered handsets/desksets, and anyone in the PTT session can respond. Depending on the phone, there may be an option to switch a PTT session to an intercom call.\nBroadcast to All: You can use a handset/deskset/base to broadcast a message to the base/all registered handsets/desksets, but no one can respond back unless someone answers to establish an intercom call (if answering a broadcast is supported).")
                }
                if phone.hasIntercom && !phone.hasBaseIntercom && phone.cordlessHandsetsIHave.count <= 1 {
                    WarningText("Intercom requires 2 or more cordless devices to be registered to the base.")
                }
            }
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        BaseSpeakerphoneIntercomView(phone: Phone(brand: "AT&T", model: "CL82215"))
    }
    .formStyle(.grouped)
}
