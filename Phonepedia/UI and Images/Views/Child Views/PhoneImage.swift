//
//  PhoneImage.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneImage: View {
    
    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Properties - Booleans

	var isThumbnail: Bool

    @AppStorage(UserDefaults.KeyNames.useDetailedPhoneImage) var useDetailedPhoneImage: Bool = false

    // MARK: - Properties - Floats

	var size: CGFloat {
		return isThumbnail ? 50 : 300
	}
    
    // MARK: - View

    var body: some View {
		#if os(iOS) || os(visionOS)
        let image = UIImage(data: phone.photoData ?? getPNGDataFromUIImage(image: useDetailedPhoneImage ? .phoneDetailed : .phone))!
			Image(uiImage: image)
                .renderingMode(phone.photoData == nil && !useDetailedPhoneImage ? .template : .original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: SAContainerViewCornerRadius))
                .accessibilityLabel("\(phone.brand) \(phone.model)")
		#elseif os(macOS)
		let image = NSImage(data: phone.photoData ?? getPNGDataFromNSImage(image: useDetailedPhoneImage ? .phoneDetailed : .phone))!
			Image(nsImage: image)
            .renderingMode(phone.photoData == nil && !useDetailedPhoneImage ? .template : .original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: SAContainerViewCornerRadius))
                .accessibilityLabel("\(phone.brand) \(phone.model)")
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
