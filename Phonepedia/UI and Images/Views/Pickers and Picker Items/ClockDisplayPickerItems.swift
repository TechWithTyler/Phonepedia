//
//  ClockDisplayPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ClockDisplayPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("None").tag(0)
        Divider()
        Text("Time Only").tag(1)
        Text("Day and Time").tag(2)
        Text("Date and Time (w/o Year)").tag(3)
        Text("Date and Time (w/ Year)").tag(4)
    }
}

// MARK: - Preview

#Preview {
    ClockDisplayPickerItems()
}
