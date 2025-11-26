//
//  RedialNameDisplayInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/7/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct RedialNameDisplayInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("• None: Only the number is displayed.\n• Phonebook Match: If the number is stored in the phonebook, the name, if any, is displayed, even if the number wasn't dialed from the phonebook.\n• From Dialed Entry: The name of the entry that was dialed is displayed. If the same number is dialed from an entry with a different name, the name of the redial entry is changed. If the same number is dialed manually, the name is deleted.")
    }

}

// MARK: - Preview

#Preview {
    RedialNameDisplayInfoView()
}
