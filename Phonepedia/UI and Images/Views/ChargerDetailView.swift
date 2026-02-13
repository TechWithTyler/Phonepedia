//
//  ChargerDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct ChargerDetailView: View {

    // MARK: - Properties - Objects

    @Bindable var charger: CordlessHandsetCharger
    
    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        if let phone = charger.phone {
            SlickBackdropView {
                Form {
                    Section {
                        HStack {
                            Spacer()
                            PhoneImage(phone: phone, displayMode: .full)
                            Spacer()
                        }
                    }
                    Section("Charger \(charger.actualChargerNumber) Actions") {
                        Button {
                            phone.chargersIHave.insert(charger.duplicate(), at: charger.chargerNumber)
                            dismiss()
                        } label: {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        }
                        Button {
                            dialogManager.showingDeleteCharger = true
                            dialogManager.chargerToDelete = charger
                            dismiss()
                        } label: {
                            Label("Delete", systemImage: "trash")
#if !os(macOS)
                                .foregroundStyle(.red)
#endif
                        }
                    }
                    Section("Basic Info") {
                        ColorPicker("Main Color", selection: charger.mainColorBinding)
                        ColorPicker("Secondary/Accent Color", selection: charger.secondaryColorBinding)
                        Button("Use Main Color") {
                            charger.setSecondaryColorToMain()
                        }
                        ColorPicker("Accent Color", selection: charger.accentColorBinding)
                        Button("Use Top Color") {
                            charger.setAccentColorToMain()
                        }
                        Button("Use Bottom Color") {
                            charger.setAccentColorToSecondary()
                        }
                        if phone.basePhoneType == 0 {
                            Picker("Charger For", selection: $charger.type) {
                                Text("Handset").tag(0)
                                Text("Headset/Speakerphone").tag(1)
                            }
                        }
                        Toggle("Has Charge Light", isOn: $charger.hasChargeLight)
                        if charger.hasChargeLight {
                            ColorPicker("Charge Light Color (Charging)", selection: charger.chargeLightColorChargingBinding)
                            ClearSupportedColorPicker("Charge Light Color (Charged)", selection: charger.chargeLightColorChargedBinding) {
                                Text("Off When Charged")
                            }
                            Button("Use Charging Color") {
                                charger.setChargeLightChargedColorToCharging()
                            }
                        }
                        if charger.type == 0 {
                            Picker("Charging Direction", selection: $charger.chargingDirection) {
                                ChargingDirectionPickerItems()
                            }
                            Picker("Charge Contact Placement", selection: $charger.chargeContactPlacement) {
                                ChargeContactPlacementPickerItems()
                            }
                            Picker("Charge Contact Type", selection: $charger.chargeContactType) {
                                ChargeContactTypePickerItems()
                            }
                            ChargingContactInfoView()
                            Picker("Wall Mounting", selection: $charger.wallMountability) {
                                Text("Not Supported").tag(0)
                                Divider()
                                Text("Holes On Back").tag(1)
                                Text("Bracket").tag(2)
                            }
                            Toggle("Has Hard-Wired AC Adaptor", isOn: $charger.hasHardWiredACAdaptor)
                        }
                    }
                    if charger.type == 0 && phone.basePhoneType == 0 {
                        Section("Special Features") {
                            if phone.supportsRangeExtenders {
                                Toggle("Has Built-In Range Extender", isOn: $charger.hasRangeExtender)
                                InfoText("A charger with a built-in range extender allows you to have a range extender where you have a charger, without having to place a separate range extender.")
                            }
                            Toggle("Has Clock/Radio/Alarm", isOn: $charger.hasClockRadioAlarm)
                            InfoText("Some chargers have a built-in clock/radio/alarm, which combines several nightstand devices (cordless handset charger, clock, radio, and alarm) into one.")
                        }
                    }
                }
            } backdropContent: {
                PhoneImage(phone: phone, displayMode: .backdrop)
            }
            .formStyle(.grouped)
            .scrollContentBackground(.hidden)
        } else {
            Text(chargerMissingPhoneText)
        }
    }

}

// MARK: - Preview

#Preview {
    @Previewable @State var charger = CordlessHandsetCharger(mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0)
    charger.phone = Phone(brand: "Panasonic", model: "KX-TGF675")
    return ChargerDetailView(charger: charger)
}
