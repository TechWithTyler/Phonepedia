//
//  BrightnessContrastAdjustmentPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct BrightnessContrastAdjustmentPickerItems: View {

    // MARK: - Properties - Booleans

    var colorDisplay: Bool

    var body: some View {
        Text("None").tag(0)
        Divider()
        Text("Contrast").tag(1)
        if colorDisplay {
            Text("Brightness").tag(2)
            Text("Brightness and Contrast").tag(3)
        }
    }

}

// MARK: - Preview

#Preview {
    BrightnessContrastAdjustmentPickerItems(colorDisplay: true)
}
