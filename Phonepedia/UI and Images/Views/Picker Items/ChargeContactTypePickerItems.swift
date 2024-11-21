//
//  ChargeContactTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct ChargeContactTypePickerItems: View {
    var body: some View {
        Text("Press Down").tag(0)
        Text("Click").tag(1)
        Text("Inductive").tag(2)
    }
}

#Preview {
    ChargeContactTypePickerItems()
}
