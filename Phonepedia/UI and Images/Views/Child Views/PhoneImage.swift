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

    // MARK: - Image Mode Enum

    enum Mode {

        case thumbnail

        case full

        case backdrop

    }

    // MARK: - Properties - Phone

	@Bindable var phone: Phone

    // MARK: - Properties - Image Mode

    var mode: Mode

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.useDetailedPhoneImage) var useDetailedPhoneImage: Bool = false

    @State private var isAnimating: Bool = false

    @Environment(\.accessibilityReduceMotion) var reduceMotion

    // MARK: - Properties - System Theme

    @Environment(\.colorScheme) var systemTheme

    // MARK: - Properties - Floats

	var size: CGFloat {
        switch mode {
        case .thumbnail: return 100
        case .full: return 300
        case .backdrop: return .infinity
        }
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
                .opacity(isAnimating ? 1 : 0)
                .blur(radius: isAnimating ? 0 : 100)
                // Use the animation modifier with a value to animate a view when a property changes.
                .animation(.easeIn(duration: reduceMotion ? 0 : 0.5), value: isAnimating)
                .animation(.easeInOut(duration: 1.0), value: phone.photoData)
                .onAppear {
                    isAnimating = true
                }
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
