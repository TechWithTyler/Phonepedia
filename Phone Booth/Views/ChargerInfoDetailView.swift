//
//  ChargerInfoDetailView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/16/23.
//

import SwiftUI

struct ChargerInfoDetailView: View {

	@Binding var charger: Charger

	var body: some View {
			Form {
				Section {
					TextField("Color", text: $charger.color)
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
			.formStyle(.grouped)
			.textFieldStyle(.roundedBorder)
	}
}

//#Preview {
//	ChargerInfoDetailView(charger: <#Binding<Charger>#>)
//}
