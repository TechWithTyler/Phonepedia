//
//  PhoneImage.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//

import SwiftUI

struct PhoneImage: View {

	var phone: Phone

	var thumb: Bool

	var size: CGFloat {
		return thumb ? 50 : 100
	}

    var body: some View {
		#if os(iOS) || os(xrOS)
		if let image = UIImage(data: phone.photoData) {
			Image(uiImage: image)
				.renderingMode(phone.photoData == getPNGDataFromUIImage(image: UIImage(named: "phone")!) ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
		} else {
			PhoneImageUnavailableView()
		}
		#elseif os(macOS)
		if let image = NSImage(data: phone.photoData) {
			Image(nsImage: image)
				.renderingMode(phone.photoData == getPNGDataFromNSImage(image: NSImage(named: "phone")!) ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
		} else {
			PhoneImageUnavailableView()
		}
		#endif
    }
}

//#Preview {
//	PhoneImage(phone: Phone.preview)
//}

struct PhoneImageUnavailableView: View {

	var body: some View {
		Text("Phone image unavailable")
			.font(.largeTitle)
	}

}
