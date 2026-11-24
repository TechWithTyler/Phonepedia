//
//  PhoneImage.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneImage: View, ImageMasterDetailable {

    // MARK: - Properties - Objects

	@Bindable var phone: Phone

    @EnvironmentObject var phonePhotoManager: PhonePhotoManager

    // MARK: - Properties - Current Phone Photo

    // The current phone photo decoded from phone's photo data.
    @State private var currentPhonePhoto: PlatformImage? = nil

    // MARK: - Properties - Image Mode

    var displayMode: MasterDetailImageDisplayMode

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.useDetailedPhoneImage) var useDetailedPhoneImage: Bool = false

    @State private var isAnimating: Bool = false

    @Environment(\.accessibilityReduceMotion) var reduceMotion

    // MARK: - Properties - System Theme

    @Environment(\.colorScheme) var systemTheme

    // MARK: - Properties - Floats

	var size: CGFloat {
        switch displayMode {
        case .thumbnail: return 100
        case .full: return 300
        case .backdrop: return 3000
        }
	}

    var maxPixelSize: CGFloat {
        switch displayMode {
        case .thumbnail:
            return 200
        case .full:
            return 800
        case .backdrop:
            return 2500
        }
    }

    // MARK: - Body

    var body: some View {
            image
                .renderingMode(currentPhonePhoto == nil && !useDetailedPhoneImage ? .template : .original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: SAContainerViewCornerRadius))
                .accessibilityLabel("\(phone.brand) \(phone.model)")
                .opacity(isAnimating ? 1 : 0)
                .blur(radius: isAnimating ? 0 : 100)
                // Use the animation modifier with a value to animate a view when a property changes.
                .animation(reduceMotion ? nil : .easeIn(duration: 0.5), value: isAnimating)
                .animation(reduceMotion ? nil : .easeInOut(duration: 1.0), value: currentPhonePhoto)
                .onAppear {
                    loadPhonePhoto()
                }
                .onChange(of: phone.photoData, { oldValue, newValue in
                    if newValue == nil {
                        currentPhonePhoto = nil
                    } else {
                        loadPhonePhoto()
                    }
                })
    }

    // MARK: - Image

    var image: Image {
        if let currentPhonePhoto {
            Image(platformImage: currentPhonePhoto)
        } else {
            if useDetailedPhoneImage {
                Image(displayMode == .thumbnail
                      ? .phoneDetailedThumbnail
                      : .phoneDetailed)
            } else {
                Image(.phone)
            }
        }
    }

    func loadPhonePhoto() {
        Task {
            currentPhonePhoto = await phonePhotoManager.decodePhonePhoto(for: phone, to: maxPixelSize)
            isAnimating = true
            }
    }

}

// MARK: - Preview

#Preview("Full") {
    PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), displayMode: .full)
}

#Preview("Thumbnail") {
    PhoneImage(phone: Phone(brand: "Panasonic", model: "KX-TGU432"), displayMode: .thumbnail)
    // Make the thumbnail preview large enough to show its window title.
        .frame(width: 200, height: 200)
}
