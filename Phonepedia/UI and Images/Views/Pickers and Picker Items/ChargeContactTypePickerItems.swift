//
//  ChargeContactTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/29/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ChargeContactTypePickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Press Down").tag(0)
        Text("Click").tag(1)
        Text("Inductive").tag(2)
    }

}

// MARK: - Preview

#Preview {
    ChargeContactTypePickerItems()
}
