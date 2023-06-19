//
//  Phone.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//

import Foundation
import SwiftData
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

@Model
final class Phone {

	var brand: String

	var model: String

	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
	}

//	static var previewPhotoData: Data? {
//		#if os(iOS) || os(xrOS)
//		return getPNGDataFromUIImage(image: UIImage(named: "phone")!)
//		#elseif os(macOS)
//		return getPNGDataFromNSImage(image: NSImage(named: "phone")!)
//		#endif
//	}
//
//	var brand: String
//
//	var model: String
//
//	var photoData: Data?
//
//	var colors: [[String : String]]
//
//	var numberOfCordlessHandsets: Int
//
//	var maxCordlessHandsets: Int
//
//	var hasAnsweringSystem: Bool
//
//	var hasVoicemailQuickDial: Bool
//
//	var baseSupportsWiredHeadsets: Bool
//
//	var handsetSupportsWiredHeadsets: Bool
//
//	var baseSupportsBluetoothHeadphones: Bool
//
//	var handsetSupportsBluetoothHeadphones: Bool
//
//	var baseSupportsBluetoothCellLinking: Bool
//
//	var basePhonebookCapacity: Int
//
//	var handsetPhonebookCapacity: Int
//
//	var baseCallerIDCapacity: Int
//
//	var handsetCallerIDCapacity: Int
//
//	var baseRedialCapacity: Int
//
//	var handsetRedialCapacity: Int
//
//	var baseSpeedDialCapacity: Int
//
//	var handsetSpeedDialCapacity: Int
//
//	var callBlockCapacity: Int
//
//	var callBlockPreScreening: Int
//
//	var callBlockPreScreeningAllowedNameCapacity: Int
//
//	var callBlockPreScreeningAllowedNumberCapacity: Int
//
//	var callBlockPreScreeningDescription: String {
//		switch callBlockPreScreening {
//			case 1: return "Code"
//			case 2: return "Caller name"
//			default: return "None"
//		}
//	}
//
//	var isCordless: Bool {
//		return numberOfCordlessHandsets > 0
//	}
//
//	var hasSharedPhonebook: Bool {
//		return isCordless && basePhonebookCapacity > 0 && handsetPhonebookCapacity == 0
//	}
//
//	var hasSharedCID: Bool {
//		return isCordless && baseCallerIDCapacity > 0 && handsetCallerIDCapacity == 0
//	}
//
//	init(brand: String, model: String, photoData: Data, colors: [[String : String]], numberOfCordlessHandsets: Int, maxCordlessHandsets: Int, hasAnsweringSystem: Bool, hasVoicemailQuickDial: Bool, baseSupportsWiredHeadsets: Bool, handsetSupportsWiredHeadsets: Bool, baseSupportsBluetoothHeadphones: Bool, handsetSupportsBluetoothHeadphones: Bool, baseSupportsBluetoothCellLinking: Bool, basePhonebookCapacity: Int, handsetPhonebookCapacity: Int, baseCallerIDCapacity: Int, handsetCallerIDCapacity: Int, baseRedialCapacity: Int, handsetRedialCapacity: Int, baseSpeedDialCapacity: Int, handsetSpeedDialCapacity: Int, callBlockCapacity: Int, callBlockPreScreening: Int, callBlockPreScreeningAllowedNameCapacity: Int, callBlockPreScreeningAllowedNumberCapacity: Int) {
//		self.brand = brand
//		self.model = model
//		self.photoData = photoData
//		self.colors = colors
//		self.numberOfCordlessHandsets = numberOfCordlessHandsets
//		self.maxCordlessHandsets = maxCordlessHandsets
//		self.hasAnsweringSystem = hasAnsweringSystem
//		self.hasVoicemailQuickDial = hasVoicemailQuickDial
//		self.baseSupportsWiredHeadsets = baseSupportsWiredHeadsets
//		self.handsetSupportsWiredHeadsets = handsetSupportsWiredHeadsets
//		self.baseSupportsBluetoothHeadphones = baseSupportsBluetoothHeadphones
//		self.handsetSupportsBluetoothHeadphones = handsetSupportsBluetoothHeadphones
//		self.baseSupportsBluetoothCellLinking = baseSupportsBluetoothCellLinking
//		self.basePhonebookCapacity = basePhonebookCapacity
//		self.handsetPhonebookCapacity = handsetPhonebookCapacity
//		self.baseCallerIDCapacity = baseCallerIDCapacity
//		self.handsetCallerIDCapacity = handsetCallerIDCapacity
//		self.baseRedialCapacity = baseRedialCapacity
//		self.handsetRedialCapacity = handsetRedialCapacity
//		self.baseSpeedDialCapacity = baseSpeedDialCapacity
//		self.handsetSpeedDialCapacity = handsetSpeedDialCapacity
//		self.callBlockCapacity = callBlockCapacity
//		self.callBlockPreScreening = callBlockPreScreening
//		self.callBlockPreScreeningAllowedNameCapacity = callBlockPreScreeningAllowedNameCapacity
//		self.callBlockPreScreeningAllowedNumberCapacity = callBlockPreScreeningAllowedNumberCapacity
//	}
//
}
