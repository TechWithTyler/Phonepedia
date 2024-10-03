//
//  HandsetPhonebookView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetPhonebookView: View {
    
    @Bindable var handset: CordlessHandset
    
    var body: some View {
        FormNumericTextField("Phonebook Capacity", value: $handset.phonebookCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        Toggle("Uses Base Phonebook", isOn: $handset.usesBasePhonebook)
        Text("Phonebook Type: \(handset.phonebookTypeText)")
        InfoText("\(CordlessHandset.HandsetPhonebookType.shared.rawValue): The phonebook is stored in the base and is shared by the base (if it has a display) and all registered handsets/desksets. Changes made to the phonebook on the base or any registered, shared phonebook-supported handset/deskset will apply to the base and all registered, shared phonebook-supported handsets/desksets, and only one can access the phonebook at a time.\n\(CordlessHandset.HandsetPhonebookType.individual.rawValue): The phonebook is stored in the base/each handset/deskset separately. On some phones, entries can be copied between the base and handsets/desksets.\n\(CordlessHandset.HandsetPhonebookType.sharedAndIndividual.rawValue): The handset/deskset has its own phonebook but can also access the shared phonebook. On some phones, entries can be copied between the shared phonebook and the individual phonebook of a handset/deskset.")
        if handset.phonebookCapacity > 0 || handset.usesBasePhonebook {
            Toggle(isOn: $handset.hasTalkingPhonebook) {
                Text("Talking Phonebook")
            }
        }
        if handset.phonebookCapacity >= phonebookTransferRequiredMaxCapacity {
            Toggle("Supports Bluetooth Phonebook Transfers", isOn: $handset.bluetoothPhonebookTransfers)
        }
    }
}

#Preview {
    Form {
        HandsetPhonebookView(handset: CordlessHandset(brand: "Vtech", model: "IS8101", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0))
    }
    .formStyle(.grouped)
}
