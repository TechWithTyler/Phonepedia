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
	
	var buttonType: Int

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

	var navigatorKeyType: Int

	var navigatorKeyUpDownVolume: Bool

	var navigatorKeyStandbyShortcuts: Bool

	var navigatorKeyCenterButton: Int

	var sideVolumeButtons: Bool

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

	init(phone: Phone? = nil, brand: String, model: String) {
		self.phone = phone
		self.brand = brand
		self.model = model
		self.color = String()
		self.keyForegroundColor = String()
		self.keyBackgroundColor = String()
		self.buttonType = 0
		self.displayType = 1
		self.hasSpeakerphone = true
		self.ringtones = 5
		self.musicRingtones = 5
		self.hasSeparateIntercomTone = true
		self.canChangeIntercomTone = false
		self.oneTouchDialCapacity = 0
		self.speedDialCapacity = 10
		self.redialCapacity = 5
		self.displayBacklightColor = String()
		self.softKeys = 2
		self.navigatorKeyType = 0
		self.navigatorKeyUpDownVolume = true
		self.navigatorKeyStandbyShortcuts = true
		self.navigatorKeyCenterButton = 0
		self.sideVolumeButtons = false
		self.keyBacklightColor = String()
		self.keyBacklightAmount = 0
		self.supportsWiredHeadsets = false
		self.answeringSystemMenu = 3
		self.phonebookCapacity = 0
		self.usesBasePhonebook = true
		self.usesBaseCallerID = true
		self.usesBaseSpeedDial = false
		self.usesBaseOneTouchDial = false
		self.bluetoothHeadphonesSupported = 0
		self.callerIDCapacity = 0
	}

}
