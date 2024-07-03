//
//  PhoneImage.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneImage: View {
    
    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Properties - Booleans

	var isThumbnail: Bool
    
    // MARK: - Properties - Floats

	var size: CGFloat {
		return isThumbnail ? 50 : 300
	}
    
    // MARK: - View

    var body: some View {
		#if os(iOS) || os(visionOS)
		if let image = UIImage(data: phone.photoData ?? getPNGDataFromUIImage(image: .phone)) {
			Image(uiImage: image)
				.renderingMode(phone.photoData == nil ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
		} else {
			PhoneImageUnavailableView()
		}
		#elseif os(macOS)
		if let image = NSImage(data: phone.photoData ?? getPNGDataFromNSImage(image: .phone)) {
			Image(nsImage: image)
				.renderingMode(phone.photoData == nil ? .template : .original)
				.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
                .accessibilityLabel("\(phone.brand) \(phone.model)")
		} else {
			PhoneImageUnavailableView()
		}
		#endif
    }
}

#Preview("Full") {
	PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), isThumbnail: false)
}

#Preview("Thumbnail") {
	PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), isThumbnail: true)
    // Make the thumbnail preview large enough to show its window title.
        .frame(width: 200, height: 200)
}
