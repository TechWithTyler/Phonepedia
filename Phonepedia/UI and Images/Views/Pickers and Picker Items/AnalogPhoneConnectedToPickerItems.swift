//
//  AnalogPhoneConnectedToPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/12/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct AnalogPhoneConnectedToPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("No Line (Not Recommended)").tag(0)
        Divider()
        Text("Copper (POTS) Line").tag(1)
        Text("VoIP Modem/ATA").tag(2)
        Text("Cell-to-Landline Bluetooth").tag(3)
        Text("Cellular Jack/Gateway").tag(4)
        Text("PBX").tag(5)
        Text("Phone Line Simulator").tag(6)
        Divider()
        Text("Multiple").tag(7)
    }

}

// MARK: - Preview

#Preview {
    AnalogPhoneConnectedToPickerItems()
}
