//
//  BasePhonebookView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BasePhonebookView: View {

    @Bindable var phone: Phone

    var body: some View {
        FormNumericTextField(phone.isCordless ? "Phonebook Capacity (Base)" : "Phonebook Capacity", value: $phone.basePhonebookCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
        FormNumericTextField(phone.isCordless ? "Numbers Per Phonebook Entry (Base)" : "Numbers Per Phonebook Entry", value: $phone.numbersPerPhonebookEntry, valueRange: .oneToMax(5), singularSuffix: "number", pluralSuffix: "numbers")
#if !os(visionOS)
            .scrollDismissesKeyboard(.interactively)
#endif
            .onChange(of: phone.basePhonebookCapacity) {
                oldValue, newValue in
                phone.basePhonebookCapacityChanged(oldValue: oldValue, newValue: newValue)
            }
        InfoText("Depending on the phone, each number assigned to a phonebook entry may count as an individual phonebook entry. For example, for a 150-entry phonebook where 3 phone numbers can be assigned per entry, if you assigned 3 phone numbers for all of your 150 entries, you can only save 50 individual entries, each with 3 numbers. Doing it this way allows compatibility with handsets which can only display a single number per entry at a time.")
        if phone.callBlockPreScreening > 0 {
            InfoText("Numbers saved to the base's home phonebook will always ring through. Save frequently-dialed numbers you want to always ring through to the phonebook instead of the allowed numbers list.")
        }
        if phone.basePhonebookCapacity > 0 {
            Toggle("Supports Phonebook Groups", isOn: $phone.baseSupportsPhonebookGroups)
            PhonebookGroupInfoView()
            FormNumericTextField(phone.isCordless ? "Favorite Entry Capacity (Base)" : "Favorite Entry Capacity", value: $phone.baseFavoriteEntriesCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
            FavoriteEntriesInfoView()
            if phone.baseDisplayType > 0 {
                Toggle("Supports Phonebook Ringtones", isOn: $phone.baseSupportsPhonebookRingtones)
                PhonebookRingtoneInfoView()
                Toggle(isOn: $phone.hasTalkingPhonebook) {
                    Text("Talking Phonebook")
                }
                InfoText("The phone can announce the names of phonebook entries as you scroll through them.")
            }
        }
        if phone.basePhonebookCapacity >= phonebookTransferRequiredMaxCapacity {
            Picker("Bluetooth Cell Phone Phonebook Transfers", selection: $phone.bluetoothPhonebookTransfers) {
                Text("Not Supported").tag(0)
                Text("To Home Phonebook").tag(1)
                if phone.baseBluetoothCellPhonesSupported > 0 {
                    Text("To Separate Cell Phonebook").tag(2)
                }
            }
            .onChange(of: phone.bluetoothPhonebookTransfers) { oldValue, newValue in
                phone.bluetoothPhonebookTransfersChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("Storing transferred cell phonebook entries in the home phonebook allows those entries to work with features such as home line caller ID phonebook match and call block pre-screening. It also allows you to view all your phonebook entries in one place. If transferred cell phonebooks are stored separately from the home phonebook, caller ID phonebook match usually only works with the corresponding cell line.\nSome phones support Bluetooth cell phone phonebook transfers even if they don't support cell phone linking.")
            if phone.bluetoothPhonebookTransfers > 0 && phone.isCordless {
                Toggle("Can Transfer Using Base/In Background", isOn: $phone.baseOrInBackgroundPhonebookTransfer)
                InfoText("Depending on the phone, the phonebook transfer can be initiated using just the base, just the handset, or both. In-background transfer allows you to leave the phonebook transfer screen once started, so you can do other things on that handset or put it back to charge. For phones where phonebook transfers can only be initiated from the handset and that don't support in-background transfer, the handset may not be able to be put back on charge without cancelling the transfer.")
            }
        }
    }
}

#Preview {
    Form {
        BasePhonebookView(phone: Phone(brand: "Uniden", model: "D1789"))
    }
    .formStyle(.grouped)
}
