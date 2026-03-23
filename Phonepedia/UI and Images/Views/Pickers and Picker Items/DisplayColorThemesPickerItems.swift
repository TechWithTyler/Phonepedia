//
//  DisplayColorThemesPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct DisplayColorThemesPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("White/Black").tag(0)
        Text("Colors").tag(1)
        Text("Colors/White").tag(2)
        Text("Colors/Black").tag(3)
        Text("Colors/White/Black").tag(4)
    }

}

// MARK: - Preview

#Preview {
    DisplayColorThemesPickerItems()
}
