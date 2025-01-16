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
        ColorPicker("Base Top Color", selection: phone.baseMainColorBinding, supportsOpacity: false)
        ColorPicker("Base Bottom Color", selection: phone.baseSecondaryColorBinding, supportsOpacity: false)
            Button("Use Top Color") {
                phone.setBaseSecondaryColorToMain()
        }
        ColorPicker("Base Accent Color", selection: phone.baseAccentColorBinding, supportsOpacity: false)
            Button("Use Top Color") {
                phone.setBaseAccentColorToMain()
        }
        Button("Use Bottom Color") {
            phone.setBaseAccentColorToSecondary()
    }
        InfoText("The accent color is seen in various places, such as around the edges. Sometimes the bottom/back color is used as an additional accent color on the top/front.")
        ClearSupportedColorPicker("Corded Receiver Outer Color", selection: phone.cordedReceiverMainColorBinding) {
            Text("Make Cordless-Only")
        }
            .onChange(of: phone.cordedReceiverMainColorBinding.wrappedValue) { oldValue, newValue in
                phone.cordedReceiverColorChanged(oldValue: oldValue, newValue: newValue)
            }
        if phone.hasCordedReceiver {
            ColorPicker("Corded Receiver Inner Color", selection: phone.cordedReceiverSecondaryColorBinding, supportsOpacity: false)
            Button("Use Outer Color") {
                phone.setCordedReceiverSecondaryColorToMain()
        }
            ColorPicker("Corded Receiver Accent Color", selection: phone.cordedReceiverAccentColorBinding, supportsOpacity: false)
                Button("Use Outer Color") {
                    phone.setCordedReceiverAccentColorToMain()
            }
            Button("Use Inner Color") {
                phone.setCordedReceiverAccentColorToSecondary()
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
