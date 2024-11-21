//
//  PhoneTypeDefinitionsButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/18/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneTypeDefinitionsButton: View {

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Button("Phone Type Definitions…") {
            dialogManager.showingPhoneTypeDefinitions = true
        }
    }
}

#Preview {
    PhoneTypeDefinitionsButton()
        .environmentObject(DialogManager())
}
