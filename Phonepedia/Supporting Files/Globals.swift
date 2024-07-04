//
//  Globals.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/23/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import Foundation
import SwiftUI

// Names to use for the answering system greeting/talking caller ID examples
var names: [String] = [
    "John Smith",
    "Pat Fleet",
    "Allison Smith",
    "Charlie Johnson"
]

// Takes the given name and converts it from "First Last" to "LAST, FIRST".
func cnamForName(_ name: String) -> String {
    // 1. Split name into separate components.
    let splitName = name.components(separatedBy: " ")
    // 2. Get the first and last names and convert them to uppercase.
    let firstName = splitName.first?.uppercased()
    let lastName = splitName.last?.uppercased()
    // 3. Create a new String with the format "LAST, FIRST".
    let lastFirstName = "\(lastName!), \(firstName!)"
    // 4. Return the new String.
    return lastFirstName
}

// The current year to use as the default value of a phone or handset's release year/acquisition year.
var currentYear = Calendar.current.component(.year, from: Date())

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
