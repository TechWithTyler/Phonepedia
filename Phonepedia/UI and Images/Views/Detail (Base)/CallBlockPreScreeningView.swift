//
//  CallBlockPreScreeningView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct CallBlockPreScreeningView: View {

    @Bindable var phone: Phone

    var body: some View {
        Picker("Mode", selection: $phone.callBlockPreScreening) {
            Text("Not Supported").tag(0)
            Text("Caller Name").tag(1)
            Text("Code").tag(2)
        }
        InfoText("Call block pre-screening picks up the line and plays a message asking callers to press a key so the phone can identify whether they're a human or a robot.\nCallers with numbers stored in the phone's allowed number list/database or phonebook, or callers whose caller ID names are stored in the phone's allowed name list, will always ring through.\nAsking for the caller name allows you to hear the caller's real name in their own voice when you pick up\(phone.hasTalkingCallerID ? " or as the caller ID announcement" : String()).")
        if phone.callBlockPreScreening > 0 {
            InfoText("Example screening message: \"Hello. Your call is being screened to make sure you're a person. Please \(phone.callBlockPreScreening == 2 ? "press \(Int.random(in: 0...999))" : "say your name after the \(AnsweringSystemGreetingComponents.beepOrTone()) then press the pound key") to be connected.\"")
            if phone.hasAnsweringSystem == 0 {
                InfoText("Calls can't go to a voicemail service once answered by a call block pre-screening system.")
            }
            Toggle("Supports Custom Greeting", isOn: $phone.callBlockPreScreeningCustomGreeting)
            FormNumericTextField("Allowed Numbers Capacity", value: $phone.callBlockPreScreeningAllowedNumberCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
            Toggle("Allowed Numbers List Visible To User", isOn: $phone.callBlockPreScreeningAllowedNumberListVisible)
            InfoText("Numbers saved to the allowed numbers list will always ring through.")
            FormNumericTextField("Allowed Names Capacity", value: $phone.callBlockPreScreeningAllowedNameCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
            InfoText("If you don't know a caller's phone number, saving their name as it appears in the incoming caller ID will allow their calls to always ring through. This is a good place to put names of businesses you want to receive automated messages from (e.g. schools, doctor's offices, pharmacies).")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
        }
    }
}

#Preview {
    Form {
        CallBlockPreScreeningView(phone: Phone(brand: "Panasonic", model: "KX-TGF775"))
    }
    .formStyle(.grouped)
}
