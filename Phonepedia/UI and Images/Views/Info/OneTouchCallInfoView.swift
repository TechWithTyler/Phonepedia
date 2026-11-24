//
//  OneTouchCallInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/2/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct OneTouchCallInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("Some phones have the option to set a number to be dialed when any button is pressed. This is often used with young children who don't yet know how to use a phone.")
    }
}

// MARK: - Preview

#Preview {
    OneTouchCallInfoView()
}
