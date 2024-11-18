//
//  BaseSpeakerphoneKeypadView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseSpeakerphoneKeypadView: View {

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
        if !phone.isCordless || (phone.isCordless && phone.hasBaseSpeakerphone) {
            Toggle(isOn: $phone.hasBaseKeypad) {
                Text(phone.isCordless ? "Has Base Keypad" : "Has User-Accessible Keypad")
            }
            InfoText("Some cordless phones have a base speakerphone and keypad, which allows you to make calls if the handset isn't nearby or if it needs to charge. Bases with keypads are a great option for office spaces as they combine a cordless-only phone with the design people expect from an office phone.\nSome corded phones, such as those found in hotel lobbies, don't have a user-accessible keypad and are used only for answering calls, checking voicemail, or calling a specific number when picking it up. The keypad and other programming controls are hidden behind a removable faceplate or within the phone's casing.")
            if phone.hasBaseKeypad {
                Toggle(isOn: $phone.hasTalkingKeypad) {
                    Text("Talking Keypad")
                }
                InfoText("The phone can announce the keys you press when dialing numbers. Sometimes, this announcement plays instead of the DTMF tones (the tones heard when you dial numbers) on your end.")
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
        BaseSpeakerphoneKeypadView(phone: Phone(brand: "AT&T", model: "CL82215"))
    }
    .formStyle(.grouped)
}
