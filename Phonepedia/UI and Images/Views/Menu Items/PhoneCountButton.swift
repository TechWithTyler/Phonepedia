//
//  PhoneCountButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/18/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneCountButton: View {

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        Button("Phone Count…") {
            dialogManager.showingPhoneCount = true
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneCountButton()
        .environmentObject(DialogManager())
}
