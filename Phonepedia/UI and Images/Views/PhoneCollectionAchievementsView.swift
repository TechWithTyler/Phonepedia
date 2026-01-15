//
//  PhoneCollectionAchievementsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/8/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneCollectionAchievementsView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Phones

    // All phones in the catalog.
    var phones: [Phone]

    // MARK: - Properties - Achievements

    var achievements: PhoneCollectionAchievementTracker { PhoneCollectionAchievementTracker(phones: phones) }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                ForEach(achievements.all) { item in
                    PhoneCollectionAchievementRow(title: item.title, condition: item.isUnlocked)
                }
            }
            .navigationTitle("Achievements")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }
}

// MARK: - Preview

#Preview {
    PhoneCollectionAchievementsView(phones: [Phone(brand: "Panasonic", model: "KX-TG994SK")])
}
