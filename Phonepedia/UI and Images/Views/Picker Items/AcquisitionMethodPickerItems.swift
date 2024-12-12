//
//  AcquisitionMethodPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/12/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AcquisitionMethodPickerItems: View {

    var handset: Bool = false

    var body: some View {
        if handset {
            Text("Included With Base/Set").tag(0)
            Divider()
        }
        Text("Thrift Store/Sale").tag(handset ? 1 : 0)
        Text("Electronics Store (New)").tag(handset ? 2 : 1)
        Text("Online (Used)").tag(handset ? 3 : 2)
        Text("Online (New)").tag(handset ? 4 : 3)
        Text("Gift").tag(handset ? 5 : 4)
    }
}

#Preview {
    AcquisitionMethodPickerItems()
}
