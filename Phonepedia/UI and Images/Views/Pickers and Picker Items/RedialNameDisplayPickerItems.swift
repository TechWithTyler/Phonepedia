//
//  RedialNameDisplayPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/25/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct RedialNameDisplayPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("None").tag(0)
        Text("Phonebook Match").tag(1)
        Text("From Dialed Entry").tag(2)
    }

}

// MARK: - Preview

#Preview {
    RedialNameDisplayPickerItems()
}
