//
//  ButtonColorInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/7/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct ButtonColorInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("On many phones, different sets of buttons have different colors. Choose the background/foreground/backlight colors used on the majority of the buttons. For example, if the keypad has black text on a clear background with a blue backlight, you would select black for the foreground color and blue for the backlight color.")
    }
}

// MARK: - Preview

#Preview {
    ButtonColorInfoView()
}
