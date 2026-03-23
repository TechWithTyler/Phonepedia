//
//  CellLineSelectionInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct CellLineSelectionInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("The cell line selection determines which cell line is selected when pressing speakerphone or when picking up the corded receiver (if the phone has a dedicated cell line only mode and it's enabled), or when pressing the cell button (unless it has a separate one for each cell line).\n• Based On Connected Cell: The cell list is displayed only if 2 or more cell phones are connected.\n• Specific Line: That line is selected automatically.\n• Manual: The cell list is always displayed.")
    }

}

// MARK: - Preview

#Preview {
    CellLineSelectionInfoView()
}
