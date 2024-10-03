//
//  CellPhoneLinkingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct CellPhoneLinkingView: View {

    @Bindable var phone: Phone

    var body: some View {
        Picker("Maximum Number Of Bluetooth Cell Phones", selection: $phone.baseBluetoothCellPhonesSupported) {
            Text("None").tag(0)
            Text("1").tag(1)
            Text("2").tag(2)
            Text("4").tag(4)
            Text("5").tag(5)
            Text("10").tag(10)
            Text("15").tag(15)
        }
        .onChange(of: phone.baseBluetoothCellPhonesSupported) { oldValue, newValue in
            phone.baseBluetoothCellPhonesSupportedChanged(oldValue: oldValue, newValue: newValue)
        }
        InfoText("Pairing a cell phone to the base via Bluetooth allows you to make and receive cell calls on the base or handsets and transfer your cell phone contacts to the phonebook.")
        if phone.baseBluetoothCellPhonesSupported > 0 {
            Picker("Cell Line In Use Status On Base", selection: $phone.cellLineInUseStatusOnBase) {
                Text("None").tag(0)
                Text("Light").tag(1)
                if phone.baseDisplayType > 1 {
                    Text("Display and Light").tag(2)
                }
            }
            Picker("Cell Line Only Behavior", selection: $phone.cellLineOnlyBehavior) {
                Text("Optional \"No Line\" Alert").tag(0)
                Text("Auto-Suppressed \"No Line\" Alert").tag(1)
                Text("Cell Line Only Mode").tag(2)
            }
            InfoText("If you use only cell lines, the \"no line\" alert will be suppressed automatically once at least 1 cell phone is paired, or can be supressed manually, depending on the phone. A dedicated cell line only mode allows the phone to disable most landline-related features.")
            Toggle("Supports Cell Phone Alerts", isOn: $phone.supportsCellAlerts)
            InfoText("The base and handsets can alert you when a paired cell phone receives a text message or other alerts by sounding a tone and/or displaying/announcing the alert.")
            Toggle("Has Cell Phone Voice Control", isOn: $phone.hasCellPhoneVoiceControl)
            InfoText("You can talk to your cell phone voice assistant (e.g. Siri or Google Now) using the base or handset.")
        }
        Picker("Maximum Number Of Smartphones As Handsets", selection: $phone.smartphonesAsHandsetsOverWiFi) {
            Text("None").tag(0)
            Text("1").tag(1)
            Text("2").tag(2)
            Text("4").tag(4)
        }
        InfoText("When a smartphone is registered to a Wi-Fi-compatible base and both devices are on the same network, the smartphone can be used as a handset, and you can transfer its data to the base or handsets.")
    }
}

#Preview {
    Form {
        CellPhoneLinkingView(phone: Phone(brand: "Panasonic", model: "KX-TG7642"))
    }
    .formStyle(.grouped)
}
