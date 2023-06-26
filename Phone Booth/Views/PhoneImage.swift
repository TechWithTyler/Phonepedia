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
		Image(uiImage: UIImage(data: phone.photoData!)!)
			.renderingMode(phone.photoData == getPNGDataFromUIImage(image: UIImage(named: "phone")!) ? .template : .original)
			.resizable()
			.scaledToFit()
			.frame(width: size, height: size)
		#elseif os(macOS)
		Image(nsImage: NSImage(data: phone.photoData!)!)
			.renderingMode(phone.photoData == getPNGDataFromNSImage(image: NSImage(named: "phone")!) ? .template : .original)
			.resizable()
			.scaledToFit()
			.frame(width: size, height: size)
		#endif
    }
}

//#Preview {
//	PhoneImage(phone: Phone.preview)
//}
