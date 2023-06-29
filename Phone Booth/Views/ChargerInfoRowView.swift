//
//  ChargerInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/29/23.
//

import SwiftUI

struct ChargerInfoRowView: View {

	@Binding var color: String

	var chargerNumber: Int

	var body: some View {
		HStack {
			Text("Charger \(chargerNumber)")
			TextField("Color", text: $color)
		}
	}
}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}

