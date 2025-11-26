//
//  IntercomAutoAnswerPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/25/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct IntercomAutoAnswerPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Not Supported").tag(0)
        Divider()
        Text("With Ring").tag(1)
        Text("Without Ring").tag(2)
        Text("With or Without Ring").tag(3)
    }

}

// MARK: - Preview

#Preview {
    IntercomAutoAnswerPickerItems()
}
