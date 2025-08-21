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
            FormNumericTextField(
                "Call Block List Capacity",
                value: $phone.callBlockCapacity,
                valueRange: .allPositivesIncludingZero,
                singularSuffix: "entry",
                pluralSuffix: "entries"
            )
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
            .onChange(of: phone.callBlockCapacity) { oldValue, newValue in
                phone.callBlockCapacityChanged(oldValue: oldValue, newValue: newValue)
            }

            InfoText("When a call from a blocked number is received, the phone answers the call after the caller ID is received. The caller will hear silence, a busy tone, or a voice message.")

            if phone.callBlockCapacity > 0 {
                Toggle("Can Block Numberless Calls", isOn: $phone.canBlockNumberlessCalls)

                InfoText("""
Numberless calls are those from private or unknown callers. Since you won't know who these callers are until you answer, you may wish to block them.
Private callers are calls where the caller has chosen to block their caller ID. Outgoing caller ID blocking can be enabled for all calls from the caller's number by changing a setting at the provider level, or per-call by the caller prefixing a code (e.g. *67) to the number they're calling.
Unknown callers are calls where the caller ID cannot be determined. This can happen if you have caller ID but the caller doesn't.
Out of area calls are calls from an area that doesn't provide caller ID.
""")

                Toggle(isOn: $phone.callBlockSupportsPrefixes) {
                    Text("Can Block Number Prefixes")
                }

                InfoText("When a number prefix (e.g. an area code) is stored in the call block list as a number prefix, all numbers beginning with that prefix are blocked.")

                // MARK: Auto-delete policy (enum-backed)
                Picker(
                    "Auto-Deletes Oldest Entry",
                    selection: Binding(
                        get: { AutoDeletePolicy(rawValue: phone.callBlockAutoDeletesOldestEntry) ?? .never },
                        set: { phone.callBlockAutoDeletesOldestEntry = $0.rawValue }
                    )
                ) {
                    ForEach(AutoDeletePolicy.allCases) { policy in
                        Text(policy.label).tag(policy)
                    }
                }

                InfoText("""
Never: The phone will never delete entries from the call block list automatically.
Without Protection: The phone will delete the oldest entry when the list is full and a new one is added.
With Protection: Entries can be specified as protected, which prevents them from being deleted when the list is full. In this case, the oldest non-protected entry will be deleted when the list is full and a new one is added. If the list is full and all entries are protected, the auto-delete feature is effectively disabled.
""")

                if phone.basePhonebookCapacity > 0 {
                    Toggle("Can Block Everyone Not In Phonebook", isOn: $phone.canBlockEveryoneNotInPhonebook)
                    InfoText("Enabling the option to block everyone not in the phonebook will block all calls except those from numbers stored in the phonebook. For phones without call block pre-screening, this is your next best option to make sure only calls from people you know ring through.")
                }

                // MARK: First ring suppression (pre-screening == not supported)
                if (PreScreeningMode(rawValue: phone.callBlockPreScreening) ?? .notSupported) == .notSupported {
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

                // MARK: What blocked callers hear (enum-backed)
                Picker(
                    "Blocked Callers Hear",
                    selection: Binding(
                        get: { BlockedCallersHear(rawValue: phone.blockedCallersHear) ?? .silence },
                        set: { phone.blockedCallersHear = $0.rawValue }
                    )
                ) {
                    ForEach(BlockedCallersHear.allCases) { option in
                        Text(option.label).tag(option)
                    }
                }

                InfoText("""
Silence can make callers think your number is broken, making them unlikely to try calling you again.
A custom busy tone is often the same one used for the intercom busy tone on \(phone.brand)'s cordless phones.
A traditional busy tone is that of one of the countries where the phone is sold (e.g., a US busy tone in the US or Canada).
A voice message tells callers that their call is blocked or that their call can't be taken. Example: "This number isn't accepting your call. Please hang up now."
""")

                // Example audio without magic numbers
                switch (BlockedCallersHear(rawValue: phone.blockedCallersHear) ?? .silence) {
                case .busyTraditional:
                    ExampleAudioView(audioFile: .busyTone)
                case .voiceMessage:
                    ExampleAudioView(audioFile: .callBlockMessage)
                default:
                    EmptyView()
                }

                Toggle(isOn: $phone.hasOneTouchCallBlock) {
                    Text("Has One-Touch/Quick Call Block")
                }
                InfoText("One-touch/quick call block allows you to press the dedicated call block button or select the call block menu item to block an incoming call as it rings or while talking on the phone. On most phones, if it's not a soft key or menu option, it can also be used to access the call block menu in standby.")

                FormNumericTextField(
                    "Pre-Blocked",
                    value: $phone.callBlockPreProgrammedDatabaseEntryCount,
                    valueRange: .allPositivesIncludingZero,
                    singularSuffix: "number",
                    pluralSuffix: "numbers"
                )
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif

                if phone.callBlockPreProgrammedDatabaseEntryCount > 0 {
                    InfoText("Some phones have an invisible database of pre-blocked phone numbers. These numbers might be excluded from the caller ID list. Numbers from this database can be saved to the phonebook if they happen to become safe in the future.")
                }
            }

            // MARK: Cell call rejection (enum-backed, options filtered by capability)
            if phone.baseBluetoothCellPhonesSupported > 0 {
                Picker(
                    "Cell Call Rejection",
                    selection: Binding(
                        get: { CellCallRejection(rawValue: phone.cellCallRejection) ?? .notSupported },
                        set: { phone.cellCallRejection = $0.rawValue }
                    )
                ) {
                    ForEach(
                        phone.callBlockCapacity > 0
                            ? CellCallRejection.allCases
                            : [.notSupported, .button]
                    ) { option in
                        Text(option.label).tag(option)
                    }
                }
                InfoText("When a cell call is rejected, the phone will send the Bluetooth \"call reject\" command to the cell phone, which typically sends the call to voicemail.")
            }
        }

        if phone.callBlockCapacity > 0 {
            Section("Pre-Screening") {
                // MARK: Pre-screening mode (enum-backed)
                Picker(
                    "Mode",
                    selection: Binding(
                        get: { PreScreeningMode(rawValue: phone.callBlockPreScreening) ?? .notSupported },
                        set: { phone.callBlockPreScreening = $0.rawValue }
                    )
                ) {
                    ForEach(PreScreeningMode.allCases) { mode in
                        Text(mode.label).tag(mode)
                    }
                }

                InfoText("""
Call block pre-screening answers an incoming call and plays a message asking the caller to press a key so the phone can identify whether they're a human or a robot.
Callers with numbers stored in the phone's allowed number list/database or phonebook, or callers whose caller ID names are stored in the phone's allowed name list, will always ring through.
Asking for the caller name allows you to hear the caller's real name in their own voice when you pick up\(phone.hasTalkingCallerID ? " or as the caller ID announcement" : String()).
Callers blocked by other call block features won't hear the pre-screening message or be able to get through.
""")

                if (PreScreeningMode(rawValue: phone.callBlockPreScreening) ?? .notSupported) != .notSupported {
                    InfoText("""
Example screening message: "Hello. Your call is being screened to make sure you're a person. Please \(((PreScreeningMode(rawValue: phone.callBlockPreScreening) ?? .notSupported) == .askForCode ? "press \(Int.random(in: .zeroToMax(999)))" : "say your name after the \(AnsweringSystemGreetingComponents.beepOrTone()) then press the pound key")) to be connected."
""")

                    ExampleAudioView(
                        audioFile: ((PreScreeningMode(rawValue: phone.callBlockPreScreening) ?? .notSupported) == .askForCode)
                            ? .callBlockPreScreeningCode
                            : .callBlockPreScreeningCallerName
                    )

                    if phone.hasAnsweringSystem == 0 {
                        InfoText("Calls can't go to a voicemail service once answered by a call block pre-screening system.")
                    }

                    Toggle("Supports Custom Greeting", isOn: $phone.callBlockPreScreeningCustomGreeting)

                    FormNumericTextField(
                        "Allowed Numbers Capacity",
                        value: $phone.callBlockPreScreeningAllowedNumberCapacity,
                        valueRange: .allPositivesIncludingZero,
                        singularSuffix: "entry",
                        pluralSuffix: "entries"
                    )
#if !os(visionOS)
                    .scrollDismissesKeyboard(.interactively)
#endif

                    if phone.callBlockPreScreeningAllowedNumberCapacity > 0 {
                        Toggle("Allowed Numbers List Visible To User", isOn: $phone.callBlockPreScreeningAllowedNumberListVisible)
                    }

                    InfoText("Numbers saved to the allowed numbers list will always ring through. If you want to be able to quickly dial these numbers or give them a name or ringtone, save them to the phonebook instead.")

                    FormNumericTextField(
                        "Allowed Names Capacity",
                        value: $phone.callBlockPreScreeningAllowedNameCapacity,
                        valueRange: .allPositivesIncludingZero,
                        singularSuffix: "entry",
                        pluralSuffix: "entries"
                    )
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
