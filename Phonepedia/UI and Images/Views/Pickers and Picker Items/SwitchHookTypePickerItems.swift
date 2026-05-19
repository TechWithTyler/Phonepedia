//
//  SwitchHookTypePickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/6/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct SwitchHookTypePickerItems: View {

    // MARK: - Properties - Booleans

    var slim: Bool

    // MARK: - Body

    var body: some View {
        Text(slim ? "Press (On Base)" : "Press").tag(0)
        if slim {
            Text("Press (On Receiver)").tag(1)
        }
        Text("Magnetic").tag(2)
        Text("Contacts").tag(3)
    }

}

// MARK: - Preview

#Preview {
    SwitchHookTypePickerItems(slim: true)
}
