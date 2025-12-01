//
//  PhoneTypeDefinitionsButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/18/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneTypeDefinitionsButton: View {

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        Button("Phone Type Definitions…") {
            dialogManager.showingPhoneTypeDefinitions = true
        }
    }
}

// MARK: - Preview

#Preview {
    PhoneTypeDefinitionsButton()
        .environmentObject(DialogManager())
}
