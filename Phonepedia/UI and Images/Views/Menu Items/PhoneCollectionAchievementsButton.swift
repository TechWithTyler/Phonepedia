//
//  PhoneCollectionAchievementsButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/8/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

import SwiftUI

// MARK: - Imports

import SwiftUI

struct PhoneCollectionAchievementsButton: View {

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        Button("Phone Collection Achievements…") {
            dialogManager.showingPhoneCollectionAchievements = true
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneCollectionAchievementsButton()
        .environmentObject(DialogManager())
}
