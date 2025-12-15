//
//  RedialDuringCallPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct RedialDuringCallPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Not Supported").tag(0)
        Divider()
        Text("Last Number").tag(1)
        Text("List").tag(2)
    }

}

// MARK: - Preview

#Preview {
    RedialDuringCallPickerItems()
}
