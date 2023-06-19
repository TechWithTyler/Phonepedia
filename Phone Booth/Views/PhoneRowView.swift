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
		VStack {
//			PhoneImage(phone: phone)
			Text(phone.brand)
				.font(.largeTitle)
			Text(phone.model)
				.font(.title2)
				.foregroundStyle(.secondary)
		}
    }
}

//#Preview {
//	PhoneRowView(phone: Phone.preview).modelContainer(for: Phone.self, inMemory: true)
//}
