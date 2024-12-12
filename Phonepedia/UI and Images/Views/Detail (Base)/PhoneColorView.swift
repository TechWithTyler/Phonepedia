//
//  PhoneColorView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneColorView: View {

    @Bindable var phone: Phone

    var body: some View {
        ColorPicker("Base Main Color", selection: phone.baseMainColorBinding, supportsOpacity: false)
        ColorPicker("Base Secondary/Accent Color", selection: phone.baseSecondaryColorBinding, supportsOpacity: false)
            Button("Use Main Color") {
                phone.setBaseSecondaryColorToMain()
        }
        InfoText("The main color is the top color of a base/charger or the front color of a handset. The secondary color is the color for the sides of a base/charger/handset and the back of a handset.\nSometimes, the base/charger/handset is all one color, with the secondary color used as an accent color in various places such as around the edges.")
        ClearSupportedColorPicker("Corded Receiver Main Color", selection: phone.cordedReceiverMainColorBinding) {
            Text("Make Cordless-Only")
        }
            .onChange(of: phone.cordedReceiverMainColorBinding.wrappedValue) { oldValue, newValue in
                phone.cordedReceiverColorChanged(oldValue: oldValue, newValue: newValue)
            }
        if phone.hasCordedReceiver {
            ColorPicker("Corded Receiver Secondary/Accent Color", selection: phone.cordedReceiverSecondaryColorBinding, supportsOpacity: false)
            Button("Use Main Color") {
                phone.setCordedReceiverSecondaryColorToMain()
        }
        }
    }
}

#Preview {
    Form {
        PhoneColorView(phone: Phone(brand: "Vtech", model: "LS6425-4"))
    }
    .formStyle(.grouped)
}
