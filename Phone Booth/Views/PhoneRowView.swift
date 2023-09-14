//
//  PhoneRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//

import SwiftUI

struct PhoneRowView: View {

	var phone: Phone

    var body: some View {
		HStack {
			Spacer()
			PhoneImage(phone: phone, thumb: true)
			VStack {
				Text(phone.brand)
					.font(.largeTitle)
				Text(phone.model)
					.font(.title2)
					.foregroundStyle(.secondary)
			}
			Spacer()
		}
    }
}

#Preview {
	PhoneRowView(phone: Phone(brand: "Panasonic", model: "KX-TGF975")).modelContainer(for: Phone.self, inMemory: true)
}
