//
//  BaseRingersView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct BaseRingersView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        Stepper(phone.isCordless ? "Base Standard Ringtones: \(phone.baseRingtones)" : "Standard Ringtones: \(phone.baseRingtones)", value: $phone.baseRingtones, in: !phone.isCordless || phone.hasBaseSpeakerphone ? .oneToMax(50) : .zeroToMax(50))
        if phone.hasElectronicRinger {
            Stepper(phone.isCordless ? "Base Music/Melody Ringtones: \(phone.baseMusicRingtones)" : "Music/Melody Ringtones: \(phone.baseMusicRingtones)", value: $phone.baseMusicRingtones, in: .zeroToMax(50))
        }
        Text("Total Ringtones: \(phone.totalBaseRingtones)")
        RingtoneInfoView()
        if phone.basePhoneType == 0 && phone.isPushButtonCorded && phone.baseRingtones <= 2 && phone.baseBluetoothCellPhonesSupported == 0 {
            Picker("Ringer Type", selection: $phone.cordedRingerType) {
                Text("Bell/Mechanical").tag(0)
                Text("Electronic").tag(1)
            }
            .onChange(of: phone.cordedRingerType) { oldValue, newValue in
                phone.cordedRingerTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("""
            Bell phones contain one or more bells and an electromagnet. The electromagnet causes a striker to move and strike the bell(s) when the phone rings.
            Some bell phones have two ringtone options. These models include an additional bell and a switch that turns its electromagnet on or off.
            Because a bell or other mechanical ringer requires more power than modern electronic ringers, it may not work properly on many VoIP lines, especially if multiple phones are ringing at once. Electronic ringers, particularly software-driven ones, need very little power by comparison.
            The amount of ringing power a phone requires is measured differently depending on the country. In the US and Canada, it's called the Ringer Equivalence Number (REN), usually printed on the bottom of the phone. A higher REN means the phone draws more power to ring. The total REN a line can support is usually 5 for a POTS line, but is usually less (around 2 or 3) for VoIP modems, ATAs, and cell-to-landline solutions.
            Other countries use different systems. In the UK, older phones were labeled with a Load Number (LN), where 4 LNs ≈ 1 REN. A UK POTS line typically supports up to 4 LNs. Australia and New Zealand also use REN, though with slightly different limits. Most of Europe, Asia, and South America follow ETSI (European Telecommunications Standards Institute)-style standards without REN labels, but the practical limit is usually 3–4 phones per line.
            If your line cannot provide enough power for mechanical ringers, you can connect a REN booster to increase ringing capacity and ensure bell/mechanical phones ring properly. Exceeding the REN (or equivalent) limit for your line or provider device can cause damage to it.
            """)
        }
        if phone.basePhoneType == 0 && phone.isMultiline && phone.cordedPhoneType == 0 && phone.cordedRingerType == 1 && phone.totalBaseRingtones == 1 {
            Picker("Ringer for Other Lines", selection: $phone.ringerForOtherLines) {
                Text("Same As Line 1").tag(0)
                Divider()
                Text("Different Cadence/Speed").tag(1)
                Text("Different Pitch").tag(2)
                Text("Different Tone").tag(3)
            }
            InfoText("• Same As Line 1: The ringtone is the same for all lines.\n• Different Cadence/Speed: The ring cadence or speed of the tone is different for each line. For example, a 2-line phone might have a fast ring for line 1, and a slow ring or double-ring for line 2.\n• Different Pitch: The pitch of the tone is different for each line. For example, a 2-line phone might have a low-pitch ring for line 1 and a higher-pitch ring for line 2.\n• Different Tone: The ringers are completely different for each line.")
        }
        if phone.totalBaseRingtones > 0 {
            Picker("Silent Mode", selection: $phone.silentMode) {
                Text("None").tag(0)
                Text("Number of Hours").tag(1)
                Text("Time Period").tag(2)
            }
            SilentModeInfoView()
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
        if (phone.totalBaseRingtones >= 1 || !phone.isCordless) && phone.basePhoneType == 0 {
            Picker(phone.isCordless ? "Base Ringer Volume Adjustment" : "Ringer Volume Adjustment", selection: $phone.baseRingerVolumeAdjustmentType) {
                Text("Ringer Switch/Dial").tag(0)
                Text("Volume Buttons").tag(1)
            }
            Toggle("Supports Ringer Off", isOn: $phone.baseSupportsRingerOff)
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        BaseRingersView(phone: Phone(brand: "Panasonic", model: "KX-TG5632"))
    }
    .formStyle(.grouped)
}
