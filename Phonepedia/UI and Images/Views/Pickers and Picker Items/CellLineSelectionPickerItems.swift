//
//  CellLineSelectionPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct CellLineSelectionPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Not Supported").tag(0)
        Divider()
        Text("Based On Connected Cell").tag(1)
        Text("Specific Line or Manual").tag(2)
    }

}

// MARK: - Preview

#Preview {
    CellLineSelectionPickerItems()
}
