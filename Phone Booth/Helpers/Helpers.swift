//
//  Helpers.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/23/23.
//

import Foundation
import SwiftUI

var names: [String] = ["John Smith", "Pat Fleet", "Allison Smith", "Charlie Johnson", "Apple", "Microsoft", "Tesla", "Toyota", "American Airlines"]

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

#elseif os(iOS) || os(xrOS)
func getPNGDataFromUIImage(image: UIImage) -> Data {
	guard let data = image.pngData() else {
		fatalError("Failed to get image data!")
	}
	return data
}
#endif
