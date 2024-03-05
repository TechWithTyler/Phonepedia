//
//  CordlessHandset.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
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
    
    var mainColorHex: String = Color.black.hex!
    
    var secondaryColorHex: String = Color.black.hex!
    
    var cordedReceiverMainColorHex: String = Color.clear.hex!
    
    var cordedReceiverSecondaryColorHex: String = Color.black.hex!
    
    var displayBacklightColorHex: String = Color.white.hex!
    
    var keyBacklightColorHex: String = Color.white.hex!
    
    var keyForegroundColorHex: String = Color.white.hex!
    
    var keyBackgroundColorHex: String = Color.black.hex!
	
	var buttonType: Int = 0
	
	var displayType: Int = 2
    
    var batteryType: Int = 0
    
    var desksetSupportsBackupBatteries: Bool = true
	
	var menuUpdateMode: Int = 0
	
	var hasSpeakerphone: Bool = true
	
	var lineButtons: Int = 0
	
	var visualRinger: Int = 0
	
	var ringtones: Int = 5
	
	var musicRingtones: Int = 5
	
    var intercomRingtone: Int = 0
	
	var oneTouchDialCapacity: Int = 0
	
	var speedDialCapacity: Int = 0
	
	var redialCapacity: Int = 5
	
	var softKeys: Int = 0
    
    var standbySoftKeysCustomizable: Bool = false
	
	var navigatorKeyType: Int = 1
	
	var navigatorKeyUpDownVolume: Bool = true
	
	var navigatorKeyStandbyShortcuts: Bool = true
	
	var navigatorKeyCenterButton: Int = 1
	
	var sideVolumeButtons: Bool = false
	
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
	
	var bluetoothPhonebookTransfers: Bool = false
	
	var callerIDCapacity: Int = 0
	
	var keyFindersSupported: Int = 0
	
	var antenna: Int = 0
	
	var hasTalkingCallerID: Bool = false
	
	var hasTalkingKeypad: Bool = false
	
	var hasTalkingPhonebook: Bool = false
    
    var talkOffButtonType = 1
    
    var talkOffColorLayer: Int = 1
    
    var speakerphoneColorLayer: Int = 1
    
    var hasSpeakerphoneButtonLight: Bool = false
    
    var storageOrSetup: Int = 0
    
    var hasQZ: Bool = true
    
    var totalRingtones: Int {
        return ringtones + musicRingtones
    }
    
    var hasPhysicalCellButton: Bool {
        guard let phone = phone else { return false }
        return softKeys > 0 && phone.baseBluetoothCellPhonesSupported > 0 && lineButtons == 0
    }
    
    // MARK: - Color Bindings
    
    var mainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: mainColorHex)!
        } set: { [self] newColor in
                mainColorHex = newColor.hex!
        }
    }
    
    var secondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: secondaryColorHex)!
        } set: { [self] newColor in
                secondaryColorHex = newColor.hex!
        }
    }
    
    var cordedReceiverMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: cordedReceiverMainColorHex)!
        } set: { [self] newColor in
                cordedReceiverMainColorHex = newColor.hex!
        }
    }
    
    var cordedReceiverSecondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: cordedReceiverSecondaryColorHex)!
        } set: { [self] newColor in
                cordedReceiverSecondaryColorHex = newColor.hex!
        }
    }
    
    var displayBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: displayBacklightColorHex)!
        } set: { [self] newColor in
                displayBacklightColorHex = newColor.hex!
        }
    }
    
    var keyBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: keyBacklightColorHex)!
        } set: { [self] newColor in
                keyBacklightColorHex = newColor.hex!
        }
    }
    
    var keyForegroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: keyForegroundColorHex)!
        } set: { [self] newColor in
                keyForegroundColorHex = newColor.hex!
        }
    }
    
    var keyBackgroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: keyBackgroundColorHex)!
        } set: { [self] newColor in
                keyBackgroundColorHex = newColor.hex!
        }
    }
    
    // MARK: - Initialization
	
	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
	}
    
    // MARK: - Set Secondary Color to Main
    
    func setSecondaryColorToMain() {
        secondaryColorHex = mainColorHex
    }
    
    // MARK: - Property Change Handlers
	
	func cordlessDeviceTypeChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
            talkOffButtonType = 0
            talkOffColorLayer = 0
			fitsOnBase = false
            batteryType = 0
		}
        if newValue != 1 {
            desksetSupportsBackupBatteries = false
        }
	}
    
    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 && oldValue == -1 {
            releaseYear = 1965
        } else if newValue < 1965 {
            releaseYear = -1
        }
    }
    
    func totalRingtonesChanged(oldValue: Int, newValue: Int) {
        if newValue < oldValue && (intercomRingtone >= (totalRingtones + 1) || intercomRingtone == 1) {
            intercomRingtone -= 1
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
            displayBacklightColorBinding.wrappedValue = .white
		}
		if newValue == 0 {
            displayBacklightColorBinding.wrappedValue = .white
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
    
    func navigatorKeyTypeChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            navigatorKeyCenterButton = 0
            navigatorKeyUpDownVolume = false
            sideVolumeButtons = true
            navigatorKeyStandbyShortcuts = false
        }
    }
	
	func callerIDCapacityChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
			usesBaseCallerID = false
		}
	}
	
}
