//
//  ChargeContactPlacementPickerItems.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct ChargeContactPlacementPickerItems: View {
    var body: some View {
        Text("Bottom").tag(0)
        Text("Back").tag(1)
        Text("One On Each Side").tag(2)
        Text("Hook").tag(3)
    }
}

#Preview {
    ChargeContactPlacementPickerItems()
}
