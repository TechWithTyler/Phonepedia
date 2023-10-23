//
//  PhoneImage.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneImage: View {

	var phone: Phone

	var thumb: Bool

	var size: CGFloat {
		return thumb ? 50 : 300
	}

    var body: some View {
		#if os(iOS) || os(xrOS)
		if let image = UIImage(data: phone.photoData) {
			Image(uiImage: image)
				.renderingMode(phone.photoData == Phone.previewPhotoData ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
		} else {
			PhoneImageUnavailableView()
		}
		#elseif os(macOS)
		if let image = NSImage(data: phone.photoData) {
			Image(nsImage: image)
				.renderingMode(phone.photoData == Phone.previewPhotoData ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
		} else {
			PhoneImageUnavailableView()
		}
		#endif
    }
}

#Preview {
	PhoneImage(phone: Phone(brand: "Vtech", model: "DS6421-3"), thumb: false)
}

#Preview {
	PhoneImage(phone: Phone(brand: "Vtech", model: "DS6421-3"), thumb: true)
}

struct PhoneImageUnavailableView: View {

	var body: some View {
		Text("Phone image unavailable")
			.font(.largeTitle)
	}

}

#Preview {
	PhoneImageUnavailableView()
}
