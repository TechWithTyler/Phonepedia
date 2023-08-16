//
//  ChargerInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/29/23.
//

import SwiftUI

struct ChargerInfoRowView: View {

	@Binding var charger: Charger

	var chargerNumber: Int

	var body: some View {
		VStack {
			HStack {
				Text("Charger \(chargerNumber)")
				TextField("Color", text: $charger.color)
			}
			Picker("Charge Contact Placement", selection: $charger.chargeContactPlacement) {
				Text("Bottom").tag(0)
				Text("Back").tag(1)
				Text("One On Each Side").tag(2)
			}
			Picker("Charge Contact Mechanism", selection: $charger.chargeContactMechanism) {
				Text("Press Down").tag(0)
				Text("Click").tag(1)
				Text("Inductive").tag(2)
			}
			ChargingContactInfoView()
		}
	}
}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}

