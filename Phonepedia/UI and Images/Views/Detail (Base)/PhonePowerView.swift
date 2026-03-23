//
//  PhonePowerView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhonePowerView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Section("General") {
            if phone.landlineConnectionType == 2 {
                Toggle("Supports Power-over-Ethernet (PoE)", isOn: $phone.supportsPoE)
                InfoText("For phones that only use PoE, if the network hardware doesn't support PoE, you'll need to connect a PoE injector between the network and the phone. If you don't want to use it on a network, simply connect the PoE injector to the phone.")
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
                    Divider()
                    Text("AC Power").tag(2)
                    Divider()
                    Text("AC Power with Battery Backup (Non-Recharging)").tag(3)
                    Text("AC Power with Battery Backup (Recharging)").tag(4)
                }
                if phone.landlineConnectionType == 0 {
                    InfoText("When a phone is on-hook, the voltage on an analog line is ~48V DC. When a phone goes off-hook, this voltage is reduced to ~6V DC. These voltage levels make line power only good for basic corded phones, because the on-hook voltage is too high and the off-hook voltage is too low. The circuit (loop) is also open when on-hook, so loop current is 0mA.\nSome line-powered phones can take batteries, which stabilize the power required for features like speed dial and caller ID display. You can access the phone's features even when it isn't connected to a line. For slim/wall phones, their manuals often advise you to disconnect the phone from the line for programming to prevent accidental dialing or the line voltage from interfering with programming.\nMost line-powered or battery-powered corded phones will keep their memory intact for some time if line/battery power is lost (usually 72 hours).\nMost AC-powered corded phones can work on line power when the power is out. If the phone takes AC power and backup batteries, usually only the batteries will provide backup power--the phone won't work at all once the batteries run out.")
                }
            }
            if phone.landlineConnectionType < 2 && phone.takesACPower {
                Toggle("Uses Single Line + Power Feed", isOn: $phone.usesSingleLinePowerFeed)
                InfoText("A single line + power feed means the line and power connections are combined into a single cable which plugs into the phone. These kinds of phones often use an RJ45-style jack/cable.\nYou can tell if the phone is analog/digital or VoIP by unplugging it and plugging it back in, or by looking at the other end of the cable. If it takes a minute or so to boot up, or the other end of the cable connects to Ethernet, it's a VoIP phone with PoE. If it boots up immediately, or the other end of the cable connects to a splitter or brick with a phone jack on it, it's an analog/digital phone.\nYou MUST make sure you don't plug a line + power feed into a PoE-supported jack or vice versa otherwise equipment can be damaged!")
            }
            if phone.baseBluetoothCellPhonesSupported > 0 && phone.takesACPower {
                Toggle("Has USB Port(s) for Cell Charging", isOn: $phone.hasUSBCharging)
                if !phone.supportsPoE {
                    InfoText("The USB port(s) is/are powered separately from the base to prevent electrical interference, since the USB port(s) is/are for charging only, and require(s) different voltage/current amounts from the base. An RJ-style power cord feeds the base and USB port power using 2 separate sets of 2 contacts. As a result, the USB port(s) won't work during power backup. This design also allows the same circuitry to be shared with a model without USB ports but otherwise-identical features.\nThe power brick for this style of power cord is larger than normal, since it contains 2 separate step-down transformers, one for the base and one for the USB port(s).")
                }
            }
        }
        if phone.isCordless {
            Section("Cordless Phone Power Backup") {
                Picker("Method", selection: $phone.cordlessPowerBackupMode) {
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
                    InfoText("If available for your phone, you can plug an external battery/battery box into the base power port to use it when the power goes out. Plug the base power cord into the battery/battery box, then the battery/battery box into the base. Connecting the base power cord to the battery/battery box means you don't have to remember to switch to the battery/battery box when the power goes out, then switch back to the base power cord when the power comes back on.\nIf not available for your phone, or it's a PoE-only phone and PoE isn't available, it won't work when the power is out.")
                }
                if phone.cordlessPowerBackupMode == 1 {
                    if phone.baseChargesHandset {
                            InfoText("When the power goes out, placing a charged handset on the base can give it power. The base buttons might not work, and features like the answering system and base Bluetooth might not be available while the handset is powering the base, to help conserve handset battery power.\nRemember that when the handset is powering the base, the battery will drain faster than usual, because some of the battery power is being used to power the base. This is especially true if you're using the handset that's powering the base--you may find that the handset powering the base runs out of charge before the other handset(s), or that you can be on a call on the other handset(s) longer than you can on the one powering the base. For this reason, the manuals of such phones often advise you to leave a handset on the base specifically for power, and use the other handset(s), if you have more than one.\nIf using the handset placed on the base, only the speakerphone is available for calls, since holding the phone up to your ear would not only feel uncomfortable (since you'd have to hold it with the handset placed on the base), but the handset could lose connection with the base charging contacts too easily.")
                            Picker("When Power Returns", selection: $phone.cordlessPowerBackupReturnBehavior) {
                                Text("Reboot/Refresh Handset Menus").tag(0)
                                Text("Restore Full Functionality w/o Rebooting").tag(1)
                            }
                            if phone.noHandsetsForPlaceOnBasePowerBackup {
                                WarningText("To use place-on-base power backup, you must have at least one handset which:\n• Has speakerphone.\n• Fits on the base.\n• Supports place-on-base power backup.")
                            }
                    } else {
                        InfoText("When the power goes out, the corded base will work as a line-powered corded phone with basic features, and will often use a piezo speaker for the ringer since it's easier for the ring voltage to power a piezo speaker than the main speaker.")
                    }
                }
            }
        }
        if phone.cordlessPowerBackupMode > 1 || phone.cordedPowerSource > 2 {
            Section("Backup Batteries") {
                Picker("Functionality", selection: $phone.cordedFunctionalityOnBackupBatteries) {
                    Text("Full").tag(2)
                    Text("Basic").tag(1)
                    if !phone.isCordless {
                        Text("Memory Retention Only").tag(0)
                    }
                }
                InfoText(phone.isCordless ? "• Full: All functionality, including cordless handsets, is supported.\n• Basic: Only the corded receiver can be used." : "• Full: All functionality is supported.\n• Basic: The speakerphone and display (if the phone has those) won't work.\n• Memory Retention Only: The batteries are used only to retain memory (e.g. speed dials, clock) when the power is out.")
                if phone.cordlessPowerBackupMode == 3 {
                    Picker("Type", selection: $phone.baseBackupBatteryType) {
                        Text("Pack with Plug").tag(0)
                        Text("Pack with Contacts").tag(1)
                        Text("Standard Batteries").tag(2)
                    }
                    BatteryInfoView()
                }
                if phone.baseBackupBatteryType == 2 || phone.cordedPowerSource == 4 {
                    WarningText("If you use non-rechargeable batteries, you MUST remember to remove them from the \(phone.isCordless ? "base" : "phone") as soon as possible once power returns to prevent leakage if it can't detect non-rechargeable batteries!")
                }
            }
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        PhonePowerView(phone: Phone(brand: "AT&T", model: "CL83464"))
    }
    .formStyle(.grouped)
}
