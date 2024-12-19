//
//  BaseRingersView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseRingersView: View {

    @Bindable var phone: Phone

    var body: some View {
        if (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) || phone.hasBaseSpeakerphone {
            Stepper("Base Standard Ringtones: \(phone.baseRingtones)", value: $phone.baseRingtones, in: !phone.isCordless || phone.hasBaseSpeakerphone ? 1...50 : 0...50)
            if phone.baseRingtones > 0 {
                Stepper("Base Music/Melody Ringtones: \(phone.baseMusicRingtones)", value: $phone.baseMusicRingtones, in: 0...50)
            }
            Text("Total Ringtones: \(phone.totalBaseRingtones)")
            RingtoneInfoView()
        }
        else if !phone.isCordless && (phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2) {
            Picker("Ringer Type", selection: $phone.cordedRingerType) {
                Text("Bell/Mechanical").tag(0)
                Text("Electronic").tag(1)
            }
            .onChange(of: phone.cordedRingerType) { oldValue, newValue in
                phone.cordedRingerTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            if phone.cordedRingerType == 1 {
                Picker("Ringer Location", selection: $phone.cordedRingerLocation) {
                    Text("Base").tag(0)
                    Text("Receiver").tag(1)
                }
            }
            InfoText("A bell/mechanical ringer requires more power to ring, so it may not work properly on most VoIP lines, especially if multiple phones are ringing at once, as they're usually designed for modern phones which typically don't have mechanical ringers. Electronic ringers, especially those that are software-driven, don't require much power.\nThe amount of ringing power a phone requires is determined by the Ringer Equivalence Number (REN), usually found on the bottom of the phone. A higher REN means more power is required for the phone to ring properly. You can connect a device called a REN booster to your line to increase its REN and allow bell/mechanical ringers to ring.")
        }
        if phone.isCordless && phone.hasBaseIntercom && phone.baseRingtones > 0 {
            Picker("Base Intercom Ringtone", selection: $phone.baseIntercomRingtone) {
                Text("Intercom-Specific Ringtone/Beep").tag(0)
                if phone.totalBaseRingtones > 1 {
                    Text("Selectable Ringtone").tag(1)
                }
                ForEach(0..<phone.totalBaseRingtones, id: \.self) { ringtoneNumber in
                    Text("Tone \(ringtoneNumber+1)").tag(ringtoneNumber + 2)
                }
            }
            .onChange(of: phone.totalBaseRingtones) {
                oldValue, newValue in
                phone.totalBaseRingtonesChanged(oldValue: oldValue, newValue: newValue)
            }
        }
        if phone.baseBluetoothCellPhonesSupported > 0 && phone.totalBaseRingtones == 1 {
            Picker("Base Cell Line Ringtone", selection: $phone.baseCellRingtone) {
                if !phone.hasBaseKeypad {
                    Text("None").tag(0)
                }
                Text("Landline Ringtone").tag(1)
                Text("Cell Line-Specific Ringtone").tag(2)
                if phone.baseDisplayType >= 1 && phone.totalBaseRingtones > 1 {
                    Text("Selectable Ringtone").tag(3)
                }
            }
            .onChange(of: phone.hasBaseKeypad) {
                oldValue, newValue in
                phone.hasBaseKeypadChanged(oldValue: oldValue, newValue: newValue)
            }
            if phone.baseCellRingtone > 0 {
                Toggle("Can Play Cell Ringtone", isOn: $phone.supportsCellRingtone)
                InfoText("The phone can play your cell phone's ringtone instead of the ringtone selected for the cell line if the cell phone supports Bluetooth In-Band Ringtone.")
            }
        }
    }
}

#Preview {
    Form {
        BaseRingersView(phone: Phone(brand: "Panasonic", model: "KX-TG5632"))
    }
    .formStyle(.grouped)
}
