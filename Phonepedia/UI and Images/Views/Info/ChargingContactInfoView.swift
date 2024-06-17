//
//  ChargingContactInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/15/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct ChargingContactInfoView: View {

    var body: some View {
		InfoText("Press-down contacts are charging contacts where the entire contact assembly presses down. If the charging area doesn't have a tall-enough lip, there are one or more plastic pieces that stick up, which help hold the handset in place.\nClick contacts are charging contacts where only the metal piece presses down, and there's a more substantial click when putting the handset on charge or taking it off charge.\nInductive contacts are the most ideal charging contacts for waterproof handsets, using electromagnetism instead of traditional charging contacts.")
    }
	
}

#Preview {
    ChargingContactInfoView()
}
