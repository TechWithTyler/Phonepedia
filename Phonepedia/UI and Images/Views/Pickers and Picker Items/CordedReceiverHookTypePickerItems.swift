//
//  CordedReceiverHookTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/6/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct CordedReceiverHookTypePickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Fixed").tag(0)
        Text("Flip/Rotate").tag(1)
        Text("Removable").tag(2)
    }
}

// MARK: - Preview

#Preview {
    CordedReceiverHookTypePickerItems()
}
