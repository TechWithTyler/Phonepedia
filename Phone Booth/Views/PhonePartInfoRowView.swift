//
//  PhoneColorInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct PhonePartInfoRowView: View {

	var color: String

	var part: String

    var body: some View {
		HStack {
			Text(part)
			Spacer()
			Text(color)
		}
    }
}

#Preview {
	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
}
