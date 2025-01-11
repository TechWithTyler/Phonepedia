//
//  Globals.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/23/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

// MARK: - Properties - Strings

// The application name.
let appName: String? = (Bundle.main.infoDictionary?[String(kCFBundleNameKey)] as? String)!

// The sample text to display above the phone description text view and when previewing the current font size in Settings.
var phoneDescriptionSampleText: String = "I bought this phone at a thrift store in June 2023. I've always been wanting this model because of its stylish design."

// MARK: - Properties - Integers

// The current year to use as the default value of a phone or handset's release year/acquisition year.
var currentYear = Calendar.current.component(.year, from: Date())

// The least amount of maximum phonebook capacity required to support Bluetooth phonebook transfers.
var phonebookTransferRequiredMaxCapacity = 150

// MARK: - Functions

func showHelp() {
    let helpURL = URL(string: "https://techwithtyler20.weebly.com/\((appName?.lowercased())!)help")!
#if os(macOS)
    NSWorkspace.shared.open(helpURL)
#else
    UIApplication.shared.open(helpURL)
#endif
}

#if os(macOS)
func getPNGDataFromNSImage(image: NSImage) -> Data {
    // Get the CGImage from the NSImage.
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
		fatalError("Image error!")
	}
	// Create a NSBitmapImageRep from the CGImage.
	let imageRep = NSBitmapImageRep(cgImage: cgImage)
	// Get the PNG data from the NSBitmapImageRep.
	guard let data = imageRep.representation(using: .png, properties: [:]) else {
		fatalError("Failed to get image data!")
	}
	return data
}

#elseif os(iOS) || os(visionOS)
func getPNGDataFromUIImage(image: UIImage) -> Data {
	guard let data = image.pngData() else {
		fatalError("Failed to get image data!")
	}
	return data
}
#endif
