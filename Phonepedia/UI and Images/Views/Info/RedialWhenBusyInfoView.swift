//
//  RedialWhenBusyInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/16/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct RedialWhenBusyInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("• Not Supported: You'll need to hang up (or press the flash button) and redial if the other end is busy.\n• Press Redial Button: If nothing has been dialed since the first redial, pressing the redial button will reset the line and redial. The phone will go on-hook for a bit longer than when pressing the flash button, to make sure the line is reset before trying again.\n• Auto-Redial: If the phone detects a repeating tone (which it assumes to be a busy/reorder tone), it will reset the line and try to redial again. If a busy/reorder tone is still detected, the phone tries again. Depending on the phone, this only works if redial was used in the first place.")
    }

}

// MARK: - Preview

#Preview {
    RedialWhenBusyInfoView()
}
