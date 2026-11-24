//
//  ButtonTypeInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/14/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct ButtonTypeInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("• Spaced: Buttons have space between them.\n• Diamond-Cut: Buttons have no spacing between them and have a click feel.\n• No Spacing: Buttons have no spacing and no click feel.\n• Touch Button Panel: A flat, touch-sensitive panel of \"buttons\".")
    }
}

// MARK: - Preview

#Preview {
    ButtonTypeInfoView()
}
