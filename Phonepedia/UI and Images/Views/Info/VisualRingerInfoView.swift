//
//  VisualRingerInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/15/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct VisualRingerInfoView: View {

    // MARK: - Body

    var body: some View {
        InfoText("A visual ringer or in use light that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. A visual ringer or in use light that ignores the ring signal flashes for as long as the phone is indicating an incoming call.")
    }

}

// MARK: - Preview

#Preview {
    VisualRingerInfoView()
}
