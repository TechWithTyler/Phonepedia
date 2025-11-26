//
//  KeypadLockInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/5/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct KeypadLockInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("The keypad can be locked so all functionality except answering calls is disabled.")
    }

}

// MARK: - Preview

#Preview {
    KeypadLockInfoView()
}
