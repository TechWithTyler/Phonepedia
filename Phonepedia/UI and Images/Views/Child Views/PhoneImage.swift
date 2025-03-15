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

    enum Mode: CGFloat {

        case thumbnail = 100

        case full = 300

        case backdrop = 500

    }

    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Properties - Booleans

    var mode: Mode

    @AppStorage(UserDefaults.KeyNames.useDetailedPhoneImage) var useDetailedPhoneImage: Bool = false

    @Environment(\.colorScheme) var systemTheme

    // MARK: - Properties - Floats

	var size: CGFloat {
        return mode.rawValue
	}
    
    // MARK: - View

    var body: some View {
            image
                .renderingMode(phone.photoData == nil && !useDetailedPhoneImage ? .template : .original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: mode == .backdrop ? 0 : SAContainerViewCornerRadius))
                .accessibilityLabel("\(phone.brand) \(phone.model)")
                .animation(.linear, value: image)
    }

    var image: Image {
        if let photoData = phone.photoData {
            #if os(macOS)
            Image(nsImage: NSImage(data: photoData)!)
            #else
            Image(uiImage: UIImage(data: photoData)!)
            #endif
        } else {
            if useDetailedPhoneImage {
                Image(mode == .thumbnail ? .phoneDetailedThumbnail : .phoneDetailed)
            } else {
                Image(.phone)
            }
        }
    }

}

#Preview("Full") {
    PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), mode: .full)
}

#Preview("Thumbnail") {
    PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), mode: .thumbnail)
    // Make the thumbnail preview large enough to show its window title.
        .frame(width: 200, height: 200)
}
