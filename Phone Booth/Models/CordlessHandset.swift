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

	var releaseYear: Int

	var fitsOnBase: Bool

	var maxBases: Int

	var cordlessDeviceType: Int

	var color: String

	var cordedReceiverColor: String

	var keyForegroundColor: String

	var keyBackgroundColor: String

	var buttonType: Int

	var displayType: Int

	var menuUpdateMode: Int

	var hasSpeakerphone: Bool

	var lineButtons: Int

	var visualRinger: Int

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

	var callerIDPhonebookMatch: Bool

	var usesBasePhonebook: Bool

	var usesBaseCallerID: Bool

	var usesBaseSpeedDial: Bool

	var usesBaseOneTouchDial: Bool

	var speedDialPhonebookEntryMode: Int

	var redialNameDisplay: Int

	var bluetoothHeadphonesSupported: Int

	var bluetoothPhonebookTransfers: Int

	var callerIDCapacity: Int

	var keyFindersSupported: Int

	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
		self.color = String()
		self.maxBases = 1
		self.cordedReceiverColor = String()
		self.cordlessDeviceType = 0
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
		self.callerIDPhonebookMatch = false
		self.usesBasePhonebook = true
		self.usesBaseCallerID = true
		self.usesBaseSpeedDial = false
		self.usesBaseOneTouchDial = false
		self.bluetoothHeadphonesSupported = 0
		self.callerIDCapacity = 0
		self.redialNameDisplay = 0
		self.speedDialPhonebookEntryMode = 0
		self.visualRinger = 0
		self.lineButtons = 0
		self.fitsOnBase = true
		self.menuUpdateMode = 1
		self.bluetoothPhonebookTransfers = 0
		self.displayBacklightColor = String()
		self.keyFindersSupported = 0
		self.releaseYear = currentYear
	}

	func cordlessDeviceTypeChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
			fitsOnBase = false
		}
	}

	func displayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue <= 1 {
			softKeys = 0
		}
		if newValue == 5 {
			displayBacklightColor = String()
		}
		if newValue == 0 {
			displayBacklightColor = String()
			menuUpdateMode = 0
			navigatorKeyType = 0
			navigatorKeyCenterButton = 0
		}
	}

	func softKeysChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue == 1 {
			softKeys = 2
		} else if oldValue == 2 && newValue == 1 {
			softKeys = 0
		}
		if newValue < 3 {
			navigatorKeyCenterButton = 2
		}
		if newValue == 0 {
			lineButtons = 0
		}
	}

	func sideVolumeButtonsChanged(oldValue: Bool, newValue: Bool) {
		if !newValue {
			navigatorKeyUpDownVolume = true
		}
	}

	func callerIDCapacityChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
			usesBaseCallerID = false
		}
	}

}
