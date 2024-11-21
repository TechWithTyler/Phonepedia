//
//  PhoneCountButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/18/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneCountButton: View {

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Button("Phone Count…") {
            dialogManager.showingPhoneCount = true
        }
    }
}

#Preview {
    PhoneCountButton()
        .environmentObject(DialogManager())
}
