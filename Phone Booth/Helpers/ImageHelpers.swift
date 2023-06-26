//
//  ImageHelpers.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/23/23.
//

import Foundation
import SwiftUI

#if os(macOS)

func getPNGDataFromNSImage(image: NSImage) -> Data? {
	// Get the CGImage from the NSImage.
	guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
		fatalError("Image error!")
	}

	// Create a NSBitmapImageRep from the CGImage.
	let imageRep = NSBitmapImageRep(cgImage: cgImage)

	// Get the PNG data from the NSBitmapImageRep.
	return imageRep.representation(using: .png, properties: [:])
}

#elseif os(iOS) || os(xrOS)
func getPNGDataFromUIImage(image: UIImage) -> Data? {
	return image.pngData()
}
#endif
