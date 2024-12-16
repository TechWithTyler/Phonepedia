//
//  PhonePowerView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhonePowerView: View {

    @Bindable var phone: Phone

    var body: some View {
        if phone.landlineConnectionType == 2 {
            Toggle("Supports Power-over-Ethernet (PoE)", isOn: $phone.supportsPoE)
            InfoText("If an Ethernet phone gets its power only via the Ethernet port instead of a separate power cord, the phone won't work without plugging it into the network.\nFor phones that only use PoE, if the network hardware doesn't support PoE, you'll need to connect a PoE injector between the network and the phone.")
                .onChange(of: phone.supportsPoE) { oldValue, newValue in
                    phone.supportsPoEChanged(oldValue: oldValue, newValue: newValue)
                }
        }
            if !phone.isCordless {
                Picker(phone.supportsPoE ? "When PoE Isn't Available" : "Power Source", selection: $phone.cordedPowerSource) {
                    if phone.landlineConnectionType < 2 {
                        Text("Line Power Only").tag(0)
                        Text("Line + Batteries").tag(1)
                    } else if phone.supportsPoE {
                        Text("No Power").tag(0)
                    }
                    Text("AC Power").tag(2)
                    Text("AC Power with Battery Backup (Non-Recharging)").tag(3)
                    Text("AC Power with Battery Backup (Recharging)").tag(4)
                }
                if phone.landlineConnectionType == 0 {
                    InfoText("When a phone is on-hook, the voltage on an analog line is ~48V DC. When a phone goes off-hook, this voltage is reduced to ~6V DC. These voltage levels make line power only good for basic corded phones, because the on-hook voltage is too high and the off-hook voltage is too low.\nSome line-powered phones can take batteries, which stabilize the power required for features like speed dial and caller ID display. You can access the phone's features even when it isn't connected to a line.\nMost line-powered or battery-powered corded phones will keep their memory intact for some time if line/battery power is lost (usually 72 hours).\nMost AC-powered corded phones can work on line power when the power is out. If the phone takes AC power and backup batteries, usually only the batteries will provide backup power--the phone won't work at all once the batteries run out.")
                }
            }
            if phone.isCordless {
                Picker("Power Backup", selection: $phone.cordlessPowerBackupMode) {
                    Text("External Battery Backup (If Available)").tag(0)
                    if phone.isCordedCordless && phone.landlineConnectionType < 2 {
                        Text("Line Power").tag(1)
                    } else {
                        if !phone.hasTransmitOnlyBase {
                            Text("Place Handset On Base").tag(1)
                        }
                    }
                    Text("Batteries in Base (Non-Recharging)").tag(2)
                    Text("Batteries in Base (Recharging)").tag(3)
                }
                .onChange(of: phone.cordlessPowerBackupMode) { oldValue, newValue in
                    phone.cordlessPowerBackupModeChanged(oldValue: oldValue, newValue: newValue)
                }
                if phone.cordlessPowerBackupMode == 0 {
                    InfoText("If available for your phone, you can plug an external battery into the base power port to use it when the power goes out. Plug the base power cord into the battery/battery box, then the battery/battery box into the base. If not available for your phone, or it's a PoE-only phone and PoE isn't available, it won't work when the power is out.")
                }
                if phone.cordlessPowerBackupMode == 3 {
                    Picker("Base Backup Battery Type", selection: $phone.baseBackupBatteryType) {
                        Text("Pack with Plug").tag(0)
                        Text("Pack with Contacts").tag(1)
                        Text("Standard Batteries").tag(2)
                    }
                    BatteryInfoView()
                    if phone.baseBackupBatteryType == 2 {
                        WarningText("If you use non-rechargeable batteries, you MUST remember to remove them from the base as soon as possible once power returns to prevent leakage if the base can't detect non-rechargeable batteries!")
                    }
                }
                if phone.cordlessPowerBackupMode == 1 && phone.isCordedCordless {
                    InfoText("When the power goes out, the corded base will work as a line-powered corded phone with basic features, and will often use a piezo speaker for the ringer.")
                }
                if phone.cordlessPowerBackupMode == 1 && !phone.hasTransmitOnlyBase && !phone.isCordedCordless {
                    Picker("When Power Returns", selection: $phone.cordlessPowerBackupReturnBehavior) {
                        Text("Reboot/Refresh Handset Menus").tag(0)
                        Text("Restore Full Functionality Without Rebooting").tag(1)
                    }
                    VStack(alignment: .leading) {
                        InfoText("When the power goes out, placing a charged handset on the base can give it power. The base buttons might not work, and features like the answering system and base Bluetooth might not be available while the handset is powering the base, to help conserve handset battery power.\nRemember that when the handset is powering the base, the battery will drain faster than normal, because some of the battery power is being used to power the base. This is especially true if you're using the handset that's powering the base--you may find that the handset powering the base runs out of charge before the other handset(s). For this reason, the manuals of such phones often advise you to leave a handset on the base specifically for power, and use the other handsets, if you have more than one.")
                        if phone.cordlessHandsetsIHave.filter({$0.fitsOnBase}).isEmpty {
                            WarningText("You must have at least one handset which fits on the base to use place-on-base power backup!")
                        }
                    }
                }
        }
    }
}

#Preview {
    Form {
        PhonePowerView(phone: Phone(brand: "AT&T", model: "CL83464"))
    }
    .formStyle(.grouped)
}
