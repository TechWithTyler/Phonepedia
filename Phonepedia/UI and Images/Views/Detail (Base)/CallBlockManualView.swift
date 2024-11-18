//
//  CallBlockManualView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct CallBlockManualView: View {

    @Bindable var phone: Phone

    var body: some View {
        FormNumericTextField("Call Block List Capacity", value: $phone.callBlockCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        InfoText("When a call from a blocked number is received, the phone answers the call after the caller ID is received. The caller will hear silence, a busy tone, or a voice message.")
        if phone.callBlockCapacity > 0 {
            Toggle(isOn: $phone.callBlockSupportsPrefixes) {
                Text("Can Block Number Prefixes")
            }
            InfoText("When a number prefix (e.g. an area code) is stored in the call block list as a number prefix, all numbers beginning with that prefix are blocked.")
            if phone.callBlockPreScreening == 0 {
                Toggle(isOn: $phone.hasFirstRingSuppression) {
                    Text("Has First Ring Suppression")
                }
                InfoText("""
Suppressing the first ring means the phone won't ring:
• Until allowed caller ID is received.
• At all for calls from blocked numbers.
When the first ring is suppressed, the number of rings you hear will be one less than the number of rings of the answering system/voicemail service.
""")
            }
            Picker("Blocked Callers Hear", selection: $phone.blockedCallersHear) {
                Text("Silence").tag(0)
                Text("Busy Tone (custom)").tag(1)
                Text("Busy Tone (traditional)").tag(2)
                Text("Voice Message").tag(3)
            }
            InfoText("Silence can make callers think your number is broken, making them unlikely to try calling you again.\nA custom busy tone is often the same one used for the intercom busy tone on \(phone.brand)'s cordless phones.\nA traditional busy tone is that of one of the countries where the phone is sold.\nA voice message tells callers that their call is blocked or that their call can't be taken. Example: \"This number isn't accepting your call. Please hang up now.\"")
            Toggle(isOn: $phone.hasOneTouchCallBlock) {
                Text("Has One-Touch/Quick Call Block")
            }
            InfoText("One-touch/quick call block allows you to press the dedicated call block button or select the call block menu item to block an incoming call as it rings or while talking on the phone. On most phones, if it's not a soft key or menu option, it can also be used to access the call block menu.")
        }
        FormNumericTextField("Pre-Programmed Call Block Database Entry Count", value: $phone.callBlockPreProgrammedDatabaseEntryCount, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        if phone.callBlockPreProgrammedDatabaseEntryCount > 0 {
            InfoText("Numbers in the pre-programmed call block database are not visible to the user and might be excluded from the caller ID list. Numbers from this database can be saved to the phonebook if they happen to become safe in the future.")
        }
    }
}

#Preview {
    Form {
        CallBlockManualView(phone: Phone(brand: "Panasonic", model: "KX-TG9344"))
    }
    .formStyle(.grouped)
}
