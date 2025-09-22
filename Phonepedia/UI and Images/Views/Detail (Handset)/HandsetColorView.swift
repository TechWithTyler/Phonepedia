//
//  HandsetColorView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/22/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetColorView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Properties - Strings

    var mainColorLocation: String {
        switch handset.cordlessDeviceType {
        case 1: return "Top"
        default: return "Front"
        }
    }

    var secondaryColorLocation: String {
        switch handset.cordlessDeviceType {
        case 1: return "Bottom"
        default: return "Back"
        }
    }

    var body: some View {
            Section {
                ColorPicker("\(mainColorLocation) Color", selection: handset.mainColorBinding, supportsOpacity: false)
                ColorPicker("\(secondaryColorLocation) Color", selection: handset.secondaryColorBinding, supportsOpacity: false)
                Button("Use \(mainColorLocation) Color") {
                    handset.setSecondaryColorToMain()
                }
                ColorPicker("Accent Color", selection: handset.accentColorBinding, supportsOpacity: false)
                Button("Use \(mainColorLocation) Color") {
                    handset.setAccentColorToMain()
                }
                Button("Use \(secondaryColorLocation) Color") {
                    handset.setAccentColorToSecondary()
                }
                ClearSupportedColorPicker("Corded Receiver Outer Color", selection: handset.cordedReceiverMainColorBinding) {
                    Text("No Corded Receiver")
                }
                if handset.hasCordedReceiver {
                    ColorPicker("Corded Receiver Inner Color", selection: handset.cordedReceiverSecondaryColorBinding, supportsOpacity: false)
                    Button("Use Outer Color") {
                        handset.setCordedReceiverSecondaryColorToMain()
                    }
                    ColorPicker("Corded Receiver Accent Color", selection: handset.cordedReceiverAccentColorBinding, supportsOpacity: false)
                    Button("Use Outer Color") {
                        handset.setCordedReceiverAccentColorToMain()
                    }
                    Button("Use Inner Color") {
                        handset.setCordedReceiverAccentColorToSecondary()
                    }

                }
            }
    }

}

#Preview {
    @Previewable @State var handset = CordlessHandset(brand: "Panasonic", model: "KX-TGA552", mainColorRed: 120, mainColorGreen: 120, mainColorBlue: 120, secondaryColorRed: 120, secondaryColorGreen: 120, secondaryColorBlue: 120, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0)
    handset.phone = Phone(brand: "Panasonic", model: "KX-TG5583")
    return HandsetDetailView(handset: handset)
        .environmentObject(DialogManager())
}
