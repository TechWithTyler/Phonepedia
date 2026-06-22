//
//  PhoneColorView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneColorView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Strings

    var mainColorLocation: String {
        switch phone.basePhoneType {
        case 1...2: return "Front"
        default: return "Top"
        }
    }

    var secondaryColorLocation: String {
        switch phone.basePhoneType {
        case 1...2: return "Back"
        default: return "Bottom"
        }
    }

    var body: some View {
        Picker("Casing Type", selection: $phone.baseCasingType) {
            CasingTypePickerItems()
        }
        if phone.baseCasingType == 0 {
            ColorPicker(phone.basePhoneType > 0 ? "Top Color" : "Base Top Color", selection: phone.baseMainColorBinding)
            ColorPicker(phone.basePhoneType > 0 ? "Bottom Color" : "Base Bottom Color", selection: phone.baseSecondaryColorBinding)
            Button("Use Top Color") {
                phone.setSecondaryColorToMain()
            }
            ColorPicker(phone.basePhoneType > 0 ? "Accent Color" : "Base Accent Color", selection: phone.baseAccentColorBinding)
            Button("Use \(mainColorLocation) Color") {
                phone.setAccentColorToMain()
            }
            Button("Use \(secondaryColorLocation) Color") {
                phone.setAccentColorToSecondary()
            }
            InfoText("The accent color is seen in various places, such as around the edges. Sometimes the bottom/back color is used as an additional accent color on the top/front.")
            if phone.basePhoneType == 0 {
                ClearSupportedColorPicker("Corded Receiver Outer Color", selection: phone.cordedReceiverMainColorBinding) {
                    Text("Cordless-Only")
                }
                .onChange(of: phone.cordedReceiverMainColorBinding.wrappedValue) { oldValue, newValue in
                    phone.cordedReceiverColorChanged(oldValue: oldValue, newValue: newValue)
                }
                Button("Use Base Main Color") {
                    phone.setCordedReceiverOuterColorToMain()
                }
                if phone.hasCordedReceiver {
                    ColorPicker("Corded Receiver Inner Color", selection: phone.cordedReceiverSecondaryColorBinding)
                    Button("Use Outer Color") {
                        phone.setCordedReceiverSecondaryColorToMain()
                    }
                    Button("Use Base Secondary Color") {
                        phone.setCordedReceiverInnerColorToSecondary()
                    }
                    ColorPicker("Corded Receiver Accent Color", selection: phone.cordedReceiverAccentColorBinding)
                    Button("Use Outer Color") {
                        phone.setCordedReceiverAccentColorToMain()
                    }
                    Button("Use Inner Color") {
                        phone.setCordedReceiverAccentColorToSecondary()
                    }
                    Button("Use Base Accent Color") {
                        phone.setCordedReceiverAccentColorToBaseAccent()
                    }
                }
            }
        } else {
            if phone.baseCasingType == 1 {
                ColorPicker("Tint Color", selection: phone.baseMainColorBinding)
            }
            Toggle("Has Corded Receiver", isOn: phone.transparentPhoneHasCordedReceiver)
                .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
                .onChange(of: phone.cordedReceiverMainColorBinding.wrappedValue) { oldValue, newValue in
                    phone.cordedReceiverColorChanged(oldValue: oldValue, newValue: newValue)
                }
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        PhoneColorView(phone: Phone(brand: "Vtech", model: "LS6425-4"))
    }
    .formStyle(.grouped)
}
