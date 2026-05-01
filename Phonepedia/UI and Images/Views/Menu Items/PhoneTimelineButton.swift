//
//  PhoneTimelineButton.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 5/1/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct PhoneTimelineButton: View {

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        Button("Show Timeline…") {
            dialogManager.showingTimeline = true
        }
    }

}

// MARK: - Preview

#Preview {
    PhoneTimelineButton()
        .environmentObject(DialogManager())
}

