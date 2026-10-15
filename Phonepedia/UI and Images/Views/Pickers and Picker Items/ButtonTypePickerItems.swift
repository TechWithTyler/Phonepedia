//
//  ButtonTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/14/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ButtonTypePickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("All Spaced").tag(0)
        Text("All Spaced w/ Click Feel").tag(1)
        Text("Some Spaced, Some Diamond-Cut").tag(2)
        Text("Some Spaced w/ Click Feel, Some Diamond-Cut").tag(3)
        Text("Some Spaced, Some w/o Spacing").tag(6)
        Text("All Diamond-Cut").tag(4)
        Text("Touch Button Panel").tag(5)
    }
}

// MARK: - Preview

#Preview {
    ButtonTypePickerItems()
}
