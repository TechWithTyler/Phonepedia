//
//  ChargeContactPlacementPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct ChargeContactPlacementPickerItems: View {

    // MARK: - Body

    var body: some View {
        Text("Bottom of Handset").tag(0)
        Text("Back of Handset").tag(1)
        Text("One On Each Side").tag(2)
        Text("Hook").tag(3)
    }
    
}

// MARK: - Preview

#Preview {
    ChargeContactPlacementPickerItems()
}
