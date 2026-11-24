//
//  HeadsetPlugSizePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/15/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct HeadsetPlugSizePickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("2.5mm (Phone Headset)").tag(2.5)
        Text("3.5mm (Headphones)").tag(3.5)
    }
}

// MARK: - Preview

#Preview {
    HeadsetPlugSizePickerItems()
}
