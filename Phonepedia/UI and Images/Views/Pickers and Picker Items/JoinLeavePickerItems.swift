//
//  JoinLeavePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/2/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct JoinLeaveTonePickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("None").tag(0)
        Text("When Joining").tag(1)
        Text("When Joining/Leaving").tag(2)
    }
}

// MARK: - Preview

#Preview {
    JoinLeaveTonePickerItems()
}
