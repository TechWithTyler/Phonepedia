//
//  RedialWhenBusyPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/25/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct RedialWhenBusyPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Not Supported").tag(0)
        Text("Press Redial Button").tag(1)
        Text("Auto-Redial").tag(2)
    }

}

// MARK: - Preview

#Preview {
    RedialWhenBusyPickerItems()
}
