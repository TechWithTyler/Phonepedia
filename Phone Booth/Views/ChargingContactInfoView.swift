//
//  ChargingContactInfoView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/15/23.
//

import SwiftUI

struct ChargingContactInfoView: View {

    var body: some View {
		Text("Press-down contacts are charging contacts where the entire contact assembly presses down. Click contacts are charging contacts where only the metal piece presses down, and there's a more substantial click when putting the handset on charge or taking it off charge. Inductive contacts are the most ideal charging contacts for waterproof handsets, using electromagnetism instead of traditional charging contacts.")
			.font(.footnote)
			.foregroundStyle(.secondary)
    }
	
}

#Preview {
    ChargingContactInfoView()
}
