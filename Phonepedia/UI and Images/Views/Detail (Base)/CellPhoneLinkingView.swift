//
//  CellPhoneLinkingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct CellPhoneLinkingView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Section("Bluetooth Cell Phone Linking") {
            CountPicker("Maximum Supported", selection: $phone.baseBluetoothCellPhonesSupported, numbers: [1, 2, 4, 5, 10, 15], noneTitle: phone.basePhonebookCapacity >= phonebookTransferRequiredMaxCapacity ? "Phonebook Transfers Only" : "None")
            .onChange(of: phone.baseBluetoothCellPhonesSupported) { oldValue, newValue in
                phone.baseBluetoothCellPhonesSupportedChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("Pairing a cell phone to the base via Bluetooth allows you to make and receive cell calls on the base or handsets and transfer your cell phone contacts to the phonebook. Some phones support cell phonebook transfers but not full-on cell phone linking for calls.")
            if phone.baseBluetoothCellPhonesSupported > 0 {
                Picker("Cell Line In Use Status On Base", selection: $phone.cellLineInUseStatusOnBase) {
                    Text("None").tag(0)
                    Text("Light").tag(1)
                    if phone.baseDisplayType > 1 {
                        Text("Display").tag(2)
                        Text("Display and Light").tag(3)
                    }
                }
                InfoText("Cell line in use status indicates when the cell line on this phone is in use, not when the paired cell phone is in use.")
                Picker("Call Transfer From Cell To Phone", selection: $phone.cellCallTransferToPhone) {
                    Text("By Cell").tag(0)
                    Text("By This Phone").tag(1)
                }
                InfoText("• By Cell: Cell calls are transferred to the phone by selecting it in the audio device list. Upon doing this, the phone shows that the cell call is on hold and can be picked up. Attempting to pick up the call from the phone first may disconnect the current call.\n• By This Phone: The phone detects that the cell phone is on a call, and will pick it up when it tries to make a call from standby.")
                Toggle("Allows Transferring Calls To Cell", isOn: $phone.supportsTransferToCell)
                InfoText("Some phones allow you to transfer a cell call to the cell phone from the phone. This will cause the cell phone to switch the audio to it or another connected Bluetooth device.")
                Picker("Cell Line Only Behavior", selection: $phone.cellLineOnlyBehavior) {
                    Text("Optional \"No Line\" Alert").tag(0)
                    Text("Auto-Suppressed \"No Line\" Alert").tag(1)
                    Text("Cell Line Only Mode").tag(2)
                }
                InfoText("If you use only cell lines, the \"no line\" alert will be suppressed automatically once at least 1 cell phone is paired, or can be suppressed manually, depending on the phone. A dedicated cell line only mode allows the phone to disable most landline-related features and allows you to make calls as if it were connected to a landline.")
                Toggle("Supports Cell Phone Alerts", isOn: $phone.supportsCellAlerts)
                InfoText("The base and handsets can alert you when a paired cell phone receives a text message or other alerts by sounding a tone and/or displaying/announcing the alert.")
                Toggle("Has Cell Phone Voice Control", isOn: $phone.hasCellPhoneVoiceControl)
                InfoText("You can talk to your cell phone voice assistant using the base or cordless devices.")
            }
        }
        Section("Smartphones/Tablets As Handsets") {
            CountPicker("Maximum Supported", selection: $phone.smartphonesAsHandsetsOverWiFi, numbers: [1, 2, 4], noneTitle: "None")
            InfoText("When a smartphone or tablet is registered to a Wi-Fi-compatible base and both devices are on the same network, the smartphone can be used as a handset, and you can transfer its data to the base or handsets/desksets.")
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        CellPhoneLinkingView(phone: Phone(brand: "Panasonic", model: "KX-TG7642"))
    }
    .formStyle(.grouped)
}
