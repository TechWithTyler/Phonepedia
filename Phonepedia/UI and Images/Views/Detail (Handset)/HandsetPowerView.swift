//
//  HandsetPowerView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/25/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetPowerView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
            if handset.cordlessDeviceType == 0 {
                Section("On/Off/Charging/Picking Up") {
                    Toggle("Can Power Off", isOn: $handset.canPowerOff)
                    InfoText("Some handsets allow you to turn them off, just like a cell phone. This allows you to save battery or transport the handset powered off without removing the battery/ies. If the handset doesn't turn on when inserting charged batteries and it doesn't have the ability to turn on/off, it can be placed on charge to turn on.")
                    Toggle("Has Charge Light", isOn: $handset.hasChargeLight)
                    if handset.hasChargeLight {
                        ColorPicker("Charge Light Color (Charging)", selection: handset.chargeLightColorChargingBinding)
                        ClearSupportedColorPicker("Charge Light Color (Charged)", selection: handset.chargeLightColorChargedBinding) {
                            Text("Off When Charged")
                        }
                        Button("Use Charging Color") {
                            handset.setChargeLightChargedColorToCharging()
                        }
                    }
                    Toggle("Has Auto-Answer", isOn: $handset.hasAutoAnswer)
                    InfoText("Auto-answer, sometimes called auto talk, allows you to answer calls by simply picking up the handset from charge without having to press any buttons.")
                    Toggle("Has Charge Tone", isOn: $handset.hasChargeTone)
                    InfoText("A charge tone sounds when the handset is placed on charge.")
                    if (handset.hasSpeakerphone || handset.talkOffButtonType == 0) && handset.handsetStyle < 2 {
                        Picker("Charge During Call", selection: $handset.chargeDuringCall) {
                            Text("Auto-Hangup").tag(0)
                            Text(handset.hasSpeakerphone ? "Switch to Speakerphone" : "Stay On Call")
                            .tag(1)
                        }
                        if handset.bluetoothHeadphonesSupported > 0 {
                            InfoText("During a call with Bluetooth headphones, the call continues on the Bluetooth headphones when placed on charge.")
                        }
                    }
                }
                if handset.fitsOnBase && handset.hasSpeakerphone && phone.cordlessPowerBackupMode == 1 && phone.baseChargesHandset {
                    Section("Place-On-Base Power Backup") {
                        Toggle("Supported", isOn: $handset.supportsPlaceOnBasePowerBackup)
                        InfoText("Even if a handset with speakerphone can fit on the base and that base has place-on-base power backup, it doesn't mean the handset supports it. If a handset doesn't come with any models with place-on-base power backup, the feature is often left out of the handset since it wouldn't work on the base it came with.")
                        if handset.supportsPlaceOnBasePowerBackup {
                            Toggle("Can Dial Before Placing On Base", isOn: $handset.canDialThenPlaceOnBase)
                            InfoText("If you must use the handset that's powering the base (e.g. you only have 1 handset), you can pick up the handset, dial a number or select it from a list, then place the handset back on the base. This makes it easier to make a call without the handset's charge contacts unexpectedly disconnecting from the base's charge contacts. As soon as the handset finds the base, the call is placed using the speakerphone.")
                            if handset.buttonPressOnChargeBehavior == 0 {
                                Toggle("Keypad Locked If Power Returns During Call", isOn: $handset.keyLockWhenPowerReturns)
                                InfoText("If power returns during a call on the handset that's powering the base, the handset's keypad may be locked just as it is while charging. Depending on the phone and other items around you (e.g. lights in the room turning back on or the handset's prompt to not pick it up disappearing), you can see that it's safe to pick up the handset to continue the call normally.")
                            }
                        }
                    }
                }
            }
            Section("Batteries") {
                if handset.cordlessDeviceType == 1 {
                    Toggle("Supports Backup Batteries", isOn: $handset.desksetSupportsBackupBatteries)
                }
                if handset.takesBatteries {
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
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }

}

// MARK: - Preview

#Preview {
    HandsetPowerView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TC1723", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
}
