//
//  ChargingContactInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct ChargingContactInfoView: View {

    var body: some View {
		InfoText("Press-down contacts are charging contacts where the entire contact piece, not just the metal contact itself, presses down. If the charging area doesn't have a tall-enough lip, there are one or more pieces that stick up, which help hold the handset in place.\nClick contacts are charging contacts where only the metal piece presses down, and there's a more substantial click when putting the handset on charge or taking it off charge. The part around the contacts holds the handset in place and therefore extra pieces to hold the handset in place typically aren't necessary.\nInductive contacts are the most ideal charging contacts for waterproof handsets, using electromagnetism instead of traditional charging contacts.")
    }
	
}

#Preview {
    ChargingContactInfoView()
}
