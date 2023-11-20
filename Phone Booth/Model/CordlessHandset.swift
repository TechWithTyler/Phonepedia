//
//  CordlessHandset.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class CordlessHandset {
    
    // MARK: - Properties
    
    var id = UUID()
	
	var phone: Phone?
	
	var brand: String
	
	var model: String
	
	var releaseYear: Int = currentYear
	
	var fitsOnBase: Bool = true
	
	var maxBases: Int = 1
	
	var cordlessDeviceType: Int = 0
	
	var color: String = "Black"
	
	var cordedReceiverColor: String = String()
	
	var keyForegroundColor: String = "White"
	
	var keyBackgroundColor: String = "Black"
	
	var buttonType: Int = 0
	
	var displayType: Int = 2
	
	var menuUpdateMode: Int = 0
	
	var hasSpeakerphone: Bool = true
	
	var lineButtons: Int = 0
	
	var visualRinger: Int = 0
	
	var ringtones: Int = 5
	
	var musicRingtones: Int = 5
	
	var hasSeparateIntercomTone: Bool = true
	
	var canChangeIntercomTone: Bool = false
	
	var oneTouchDialCapacity: Int = 0
	
	var speedDialCapacity: Int = 0
	
	var redialCapacity: Int = 5
	
	var displayBacklightColor: String = "White"
	
	var softKeys: Int = 0
	
	var navigatorKeyType: Int = 1
	
	var navigatorKeyUpDownVolume: Bool = true
	
	var navigatorKeyStandbyShortcuts: Bool = true
	
	var navigatorKeyCenterButton: Int = 1
	
	var sideVolumeButtons: Bool = false
	
	var keyBacklightColor: String = String()
	
	var keyBacklightAmount: Int = 0
	
	var supportsWiredHeadsets: Bool = false
	
	var answeringSystemMenu: Int = 3
	
	var phonebookCapacity: Int = 0
	
	var callerIDPhonebookMatch: Bool = false
	
	var usesBasePhonebook: Bool = true
	
	var usesBaseCallerID: Bool = true
	
	var usesBaseSpeedDial: Bool = false
	
	var usesBaseOneTouchDial: Bool = false
	
	var speedDialPhonebookEntryMode: Int = 0
	
	var redialNameDisplay: Int = 0
	
	var bluetoothHeadphonesSupported: Int = 0
	
	var bluetoothPhonebookTransfers: Int = 0
	
	var callerIDCapacity: Int = 0
	
	var keyFindersSupported: Int = 0
	
	var antenna: Int = 0
	
	var hasTalkingCallerID: Bool = false
	
	var hasTalkingKeypad: Bool = false
	
	var hasTalkingPhonebook: Bool = false
    
    // MARK: - Initialization
	
	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
	}
    
    // MARK: - Property Change Handlers
	
	func cordlessDeviceTypeChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
			fitsOnBase = false
		}
	}
	
	func displayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
			hasTalkingPhonebook = false
		}
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
		if newValue < 3 && navigatorKeyCenterButton == 3 {
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
