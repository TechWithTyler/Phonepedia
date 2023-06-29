//
//  HandsetInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct HandsetInfoRowView: View {

	@Binding var color: String

	@Binding var model: String

	var handsetNumber: Int

    var body: some View {
		HStack {
			Text("Handset \(handsetNumber)")
			TextField("Model", text: $model)
			Spacer()
			TextField("Color", text: $color)
		}
    }
}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}
