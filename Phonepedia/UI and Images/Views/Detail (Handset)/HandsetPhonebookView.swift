//
//  HandsetPhonebookView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetPhonebookView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        if handset.handsetStyle < 3 {
            FormNumericTextField("Capacity", value: $handset.phonebookCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
            FormNumericTextField("Numbers Per Entry", value: $handset.numbersPerPhonebookEntry, valueRange: .oneToMax(5), singularSuffix: "number", pluralSuffix: "numbers")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
                MultiPhoneNumberInfoView()
        }
        Toggle("Uses Base Phonebook", isOn: $handset.usesBasePhonebook)
        Text("Phonebook Type: \(handset.phonebookTypeText)")
        InfoText("\(CordlessHandset.HandsetPhonebookType.shared.rawValue): The phonebook is stored in the base and is shared by the base (if it has a display) and all registered handsets/desksets. Changes made to the phonebook on the base or any registered, shared phonebook-supported handset/deskset will apply to the base and all registered, shared phonebook-supported handsets/desksets, and only one can access the phonebook at a time.\n\(CordlessHandset.HandsetPhonebookType.individual.rawValue): The phonebook is stored in the base/each handset/deskset separately. On some phones, entries can be copied between the base and handsets/desksets.\n\(CordlessHandset.HandsetPhonebookType.sharedAndIndividual.rawValue): The handset/deskset has its own phonebook but can also access the shared phonebook. On some phones, entries can be copied between the shared phonebook and the individual phonebook of a handset/deskset. The phonebook on the base, if any, always uses the shared phonebook.")
        if handset.phonebookCapacity > 0 {
            FormNumericTextField("Favorite Entry Capacity", value: $handset.favoriteEntriesCapacity, valueRange: .zeroToMax(10), singularSuffix: "entry", pluralSuffix: "entries")
            FavoriteEntriesInfoView()
        }
        if handset.hasPhonebook {
            Toggle("Supports Groups", isOn: $handset.supportsPhonebookGroups)
            PhonebookGroupInfoView()
            Toggle("Supports Phonebook Ringtones", isOn: $handset.supportsPhonebookRingtones)
            if handset.silentMode > 0 {
                Toggle("Supports Silent Mode Bypass", isOn: $handset.supportsSilentModeBypass)
            }
            PhonebookRingtoneInfoView()
            if handset.handsetStyle < 3 {
                Toggle(isOn: $handset.hasTalkingPhonebook) {
                    Text("Talking Phonebook")
                }
            }
        }
        if handset.phonebookCapacity >= phonebookTransferRequiredMaxCapacity && handset.handsetStyle < 3 {
            Toggle("Supports Bluetooth Phonebook Transfers", isOn: $handset.bluetoothPhonebookTransfers)
        }
    }
}

// MARK: - Preview

#Preview {
    Form {
        HandsetPhonebookView(handset: CordlessHandset(brand: "Vtech", model: "IS8101", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
