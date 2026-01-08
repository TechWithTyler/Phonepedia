//
//  PhoneCollectionAchievementRow.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/8/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneCollectionAchievementRow: View {

    // MARK: - Properties - Strings

    var title: String

    var condition: Bool

    var body: some View {
        HStack {
            Image(systemName: condition ? "checkmark" : "xmark")
                .foregroundStyle(condition ? .green : .red)
            Text(title)
        }
    }
}

#Preview("True") {
    PhoneCollectionAchievementRow(title: "Achievement", condition: true)
}

#Preview("False") {
    PhoneCollectionAchievementRow(title: "Achievement", condition: false)
}

