//
//  CallBlockView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct CallBlockView: View {

    @Bindable var phone: Phone

    var body: some View {
        Section("Manual") {
            FormNumericTextField("Call Block List Capacity", value: $phone.callBlockCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
                .onChange(of: phone.callBlockCapacity) { oldValue, newValue in
                    phone.callBlockCapacityChanged(oldValue: oldValue, newValue: newValue)
                }
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
                    Text("Busy Tone (Custom)").tag(1)
                    Text("Busy Tone (Traditional)").tag(2)
                    Text("Voice Message").tag(3)
                }
                InfoText("Silence can make callers think your number is broken, making them unlikely to try calling you again.\nA custom busy tone is often the same one used for the intercom busy tone on \(phone.brand)'s cordless phones.\nA traditional busy tone is that of one of the countries where the phone is sold.\nA voice message tells callers that their call is blocked or that their call can't be taken. Example: \"This number isn't accepting your call. Please hang up now.\"")
                if phone.blockedCallersHear == 2 {
                    ExampleAudioView(audioFile: .busyTone)
                } else if phone.blockedCallersHear == 3 {
                    ExampleAudioView(audioFile: .callBlockMessage)
                }
                Toggle(isOn: $phone.hasOneTouchCallBlock) {
                    Text("Has One-Touch/Quick Call Block")
                }
                InfoText("One-touch/quick call block allows you to press the dedicated call block button or select the call block menu item to block an incoming call as it rings or while talking on the phone. On most phones, if it's not a soft key or menu option, it can also be used to access the call block menu in standby.")
            FormNumericTextField("Pre-Blocked", value: $phone.callBlockPreProgrammedDatabaseEntryCount, valueRange: .allPositivesIncludingZero, singularSuffix: "number", pluralSuffix: "numbers")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
            if phone.callBlockPreProgrammedDatabaseEntryCount > 0 {
                InfoText("Some phones have an invisible database of pre-blocked phone numbers. These numbers might be excluded from the caller ID list. Numbers from this database can be saved to the phonebook if they happen to become safe in the future.")
            }
            }
            if phone.baseBluetoothCellPhonesSupported > 0 {
                Picker("Cell Call Rejection", selection: $phone.cellCallRejection) {
                    Text("Not Supported").tag(0)
                    Text("Button").tag(1)
                    if phone.callBlockCapacity > 0 {
                        Text("When Blocking").tag(2)
                        Text("Button/When Blocking").tag(3)
                    }
                }
                InfoText("When a cell call is rejected, the phone will send the Bluetooth \"call reject\" signal to the cell phone, which typically sends the call to voicemail.")
            }
        }
        if phone.callBlockCapacity > 0 {
            Section("Pre-Screening") {
                Picker("Mode", selection: $phone.callBlockPreScreening) {
                    Text("Not Supported").tag(0)
                    Text("Ask for Caller Name").tag(1)
                    Text("Ask for Code Entry").tag(2)
                }
                InfoText("Call block pre-screening answers the call and plays a message asking callers to press a key so the phone can identify whether they're a human or a robot.\nCallers with numbers stored in the phone's allowed number list/database or phonebook, or callers whose caller ID names are stored in the phone's allowed name list, will always ring through.\nAsking for the caller name allows you to hear the caller's real name in their own voice when you pick up\(phone.hasTalkingCallerID ? " or as the caller ID announcement" : String()).")
                if phone.callBlockPreScreening > 0 {
                    InfoText("Example screening message: \"Hello. Your call is being screened to make sure you're a person. Please \(phone.callBlockPreScreening == 2 ? "press \(Int.random(in: .zeroToMax(999)))" : "say your name after the \(AnsweringSystemGreetingComponents.beepOrTone()) then press the pound key") to be connected.\"")
                    ExampleAudioView(audioFile: phone.callBlockPreScreening == 2 ? .callBlockPreScreeningCode : .callBlockPreScreeningCallerName)
                    if phone.hasAnsweringSystem == 0 {
                        InfoText("Calls can't go to a voicemail service once answered by a call block pre-screening system.")
                    }
                    Toggle("Supports Custom Greeting", isOn: $phone.callBlockPreScreeningCustomGreeting)
                    FormNumericTextField("Allowed Numbers Capacity", value: $phone.callBlockPreScreeningAllowedNumberCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                        .scrollDismissesKeyboard(.interactively)
#endif
                    if phone.callBlockPreScreeningAllowedNumberCapacity > 0 {
                        Toggle("Allowed Numbers List Visible To User", isOn: $phone.callBlockPreScreeningAllowedNumberListVisible)
                    }
                    InfoText("Numbers saved to the allowed numbers list will always ring through.")
                    FormNumericTextField("Allowed Names Capacity", value: $phone.callBlockPreScreeningAllowedNameCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
                    InfoText("If you know a caller's name but not a caller's phone number or their number changes frequently, saving their name as it appears in the incoming caller ID will allow their calls to always ring through. This is a good place to put names of businesses you want to receive automated messages from (e.g. schools, doctor's offices, pharmacies).")
#if !os(visionOS)
                        .scrollDismissesKeyboard(.interactively)
#endif
                }
            }
        }
    }
}

#Preview {
    Form {
        CallBlockView(phone: Phone(brand: "Panasonic", model: "KX-TG9344"))
    }
    .formStyle(.grouped)
}
