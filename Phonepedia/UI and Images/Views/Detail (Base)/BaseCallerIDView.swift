//
//  BaseCallerIDView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseCallerIDView: View {

    @Bindable var phone: Phone

    var body: some View {
        if phone.basePhonebookCapacity > 0 {
            Toggle(isOn: $phone.callerIDPhonebookMatch) {
                Text("Caller ID Name Uses Matching Phonebook Entry Name")
            }
            let exampleName = names.randomElement()!
            InfoText("If the incoming caller ID phone number matches an entry in the phonebook, the entry name is displayed instead of the caller ID name. For example, if the incoming caller ID name is \"\(cnamForName(exampleName))\" and the number is 555-555-1234, and you store that number to the phonebook with name \"\(exampleName)\", the incoming caller ID will show as \"\(exampleName)\" instead of \"\(cnamForName(exampleName))\".")
        }
        Toggle(isOn: $phone.hasTalkingCallerID) {
            Text("Talking Caller ID")
        }
        InfoText("The phone can announce who's calling after each ring, so you don't have to look at the screen. Example: \"Call from \(names.randomElement()!)\".")
        if phone.isCordless || phone.baseDisplayType > 0 {
            FormNumericTextField(phone.isCordless ? "Caller ID List Capacity (base)" : "Caller ID List Capacity", value: $phone.baseCallerIDCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
        }
    }
}

#Preview {
    Form {
        BaseCallerIDView(phone: Phone(brand: "AT&T", model: "E5960"))
    }
    .formStyle(.grouped)
}
