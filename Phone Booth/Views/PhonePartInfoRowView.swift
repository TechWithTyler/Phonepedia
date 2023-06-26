//
//  PhoneColorInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct PhoneColorInfoRowView: View {

	@Binding var color: String

	var part: String

    var body: some View {
		TextField("\(part) Color", text: $color)
    }
}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}
