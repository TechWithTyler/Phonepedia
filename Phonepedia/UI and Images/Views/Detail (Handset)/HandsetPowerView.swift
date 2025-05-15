//
//  HandsetPowerView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/25/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetPowerView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if handset.cordlessDeviceType == 0 {
            Toggle("Has Charge Light", isOn: $handset.hasChargeLight)
            ColorPicker("Charge Light Color (Charging)", selection: handset.chargeLightColorChargingBinding, supportsOpacity: false)
            ClearSupportedColorPicker("Charge Light Color (Charged)", selection: handset.chargeLightColorChargedBinding) {
                Text("Off When Charged")
            }
            Button("Use Charging Color") {
                handset.setChargeLightChargedColorToCharging()
            }
            Toggle("Has Auto-Answer", isOn: $handset.hasAutoAnswer)
            InfoText("Auto-answer, sometimes called auto talk, allows you to answer calls by simply picking up the handset from charge.")
            Toggle("Has Charge Tone", isOn: $handset.hasChargeTone)
            InfoText("A charge tone sounds when the handset is placed on charge.")
            if handset.hasSpeakerphone && handset.handsetStyle < 2 {
                Picker("Charge During Call", selection: $handset.chargeDuringCall) {
                    Text("Auto-Hangup").tag(0)
                    Text("Switch to Speakerphone").tag(1)
                }
                if handset.bluetoothHeadphonesSupported > 0 {
                    InfoText("During a call with Bluetooth headphones, the call continues on the Bluetooth headphones when placed on charge.")
                }
            }
        }
        if handset.cordlessDeviceType == 1 {
            Toggle("Supports Backup Batteries", isOn: $handset.desksetSupportsBackupBatteries)
        }
        if handset.cordlessDeviceType == 0 || (handset.cordlessDeviceType == 1 && handset.desksetSupportsBackupBatteries) {
            Picker(handset.cordlessDeviceType == 0 ? "Battery Type" : "Backup Battery Type", selection: $handset.batteryType) {
                Text("Pack with Plug").tag(0)
                Text("Pack with Contacts").tag(1)
                Text("Standard Rechargeable").tag(2)
            }
            BatteryInfoView()
        }
        if handset.cordlessDeviceType == 0 {
            Picker("Audible Low Battery Alert", selection: $handset.audibleLowBatteryAlert) {
                Text("In-Call Beep").tag(0)
                Text("Hangup Beep").tag(1)
                Text("Standby Beep").tag(2)
                Text("Hangup Beep/Voice").tag(3)
                Text("Standby/Hangup Voice").tag(4)
            }
            InfoText("The handset can audibly alert you when the battery is low or needs to be charged.")
        }
    }

}

#Preview {
    HandsetPowerView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TC1723", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
}
