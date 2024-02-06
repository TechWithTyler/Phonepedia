//
//  PhoneRowView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneRowView: View {
    
    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Body

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
				Text(phone.phoneTypeText)
					.font(.subheadline)
					.foregroundStyle(.secondary)
			}
			Spacer()
		}
    }
}

#Preview {
	PhoneRowView(phone: Phone(brand: "Panasonic", model: "KX-TGF975")).modelContainer(for: Phone.self, inMemory: true)
}
