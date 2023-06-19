//
//  PhoneDetailView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//

import SwiftUI
import SwiftData

struct PhoneDetailView: View {

	@Model var phone: Phone

	var body: some View {
		VStack {
			Text(phone.brand)
				.font(.largeTitle)
			Text(phone.model)
				.font(.title2)
				.foregroundStyle(.secondary)
		}
	}
}

//#Preview {
//	PhoneDetailView(phone: Phone.preview)
//}
