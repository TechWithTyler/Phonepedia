//
//  ChargingContactInfoView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/15/23.
//

import SwiftUI

struct ChargingContactInfoView: View {

    var body: some View {
		HStack {
			Image(systemName: "info.circle")
		Text("Press-down contacts are charging contacts where the entire contact assembly presses down. If the charging area doesn't have a tall-enough lip, there are one or more plastic pieces that stick up, which help hold the handset in place. Click contacts are charging contacts where only the metal piece presses down, and there's a more substantial click when putting the handset on charge or taking it off charge. Inductive contacts are the most ideal charging contacts for waterproof handsets, using electromagnetism instead of traditional charging contacts.")
		}
			.font(.footnote)
			.foregroundStyle(.secondary)
    }
	
}

#Preview {
    ChargingContactInfoView()
}
