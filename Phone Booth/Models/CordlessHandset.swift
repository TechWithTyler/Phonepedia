//
//  CordlessHandset.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//

import Foundation
import SwiftData

@Model
final class CordlessHandset {
	
	var phone: Phone?
	
	var brand: String
	
	var model: String
	
	var color: String
	
	var keyForegroundColor: String
	
	var keyBackgroundColor: String
	
	var diamondCutKeys: Int
	
	var displayType: Int
	
	var hasSpeakerphone: Bool
	
	var ringtones: Int
	
	var musicRingtones: Int
	
	var hasSeparateIntercomTone: Bool
	
	var canChangeIntercomTone: Bool
	
	var oneTouchDialCapacity: Int
	
	var speedDialCapacity: Int
	
	var redialCapacity: Int
	
	var displayBacklightColor: String
	
	var softKeys: Int
	
	var keyBacklightColor: String
	
	var keyBacklightAmount: Int
	
	var supportsWiredHeadsets: Bool
	
	var answeringSystemMenu: Int
	
	var phonebookCapacity: Int
	
	var usesBasePhonebook: Bool
	
	var usesBaseCallerID: Bool
	
	var usesBaseSpeedDial: Bool
	
	var usesBaseOneTouchDial: Bool
	
	var bluetoothHeadphonesSupported: Int
	
	var callerIDCapacity: Int

	init(phone: Phone? = nil, brand: String, model: String, color: String, keyForegroundColor: String, keyBackgroundColor: String, diamondCutKeys: Int, displayType: Int, hasSpeakerphone: Bool, ringtones: Int, musicRingtones: Int, hasSeparateIntercomTone: Bool, canChangeIntercomTone: Bool, oneTouchDialCapacity: Int, speedDialCapacity: Int, redialCapacity: Int, displayBacklightColor: String, softKeys: Int, keyBacklightColor: String, keyBacklightAmount: Int, supportsWiredHeadsets: Bool, answeringSystemMenu: Int, phonebookCapacity: Int, usesBasePhonebook: Bool, usesBaseCallerID: Bool, usesBaseSpeedDial: Bool, usesBaseOneTouchDial: Bool, bluetoothHeadphonesSupported: Int, callerIDCapacity: Int) {
		self.phone = phone
		self.brand = brand
		self.model = model
		self.color = color
		self.keyForegroundColor = keyForegroundColor
		self.keyBackgroundColor = keyBackgroundColor
		self.diamondCutKeys = diamondCutKeys
		self.displayType = displayType
		self.hasSpeakerphone = hasSpeakerphone
		self.ringtones = ringtones
		self.musicRingtones = musicRingtones
		self.hasSeparateIntercomTone = hasSeparateIntercomTone
		self.canChangeIntercomTone = canChangeIntercomTone
		self.oneTouchDialCapacity = oneTouchDialCapacity
		self.speedDialCapacity = speedDialCapacity
		self.redialCapacity = redialCapacity
		self.displayBacklightColor = displayBacklightColor
		self.softKeys = softKeys
		self.keyBacklightColor = keyBacklightColor
		self.keyBacklightAmount = keyBacklightAmount
		self.supportsWiredHeadsets = supportsWiredHeadsets
		self.answeringSystemMenu = answeringSystemMenu
		self.phonebookCapacity = phonebookCapacity
		self.usesBasePhonebook = usesBasePhonebook
		self.usesBaseCallerID = usesBaseCallerID
		self.usesBaseSpeedDial = usesBaseSpeedDial
		self.usesBaseOneTouchDial = usesBaseOneTouchDial
		self.bluetoothHeadphonesSupported = bluetoothHeadphonesSupported
		self.callerIDCapacity = callerIDCapacity
	}

}
