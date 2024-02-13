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
    
    var mainColorRed: Double = 0
    
    var mainColorGreen: Double = 0
    
    var mainColorBlue: Double = 0
    
    var secondaryColorRed: Double = 0
    
    var secondaryColorGreen: Double = 0
    
    var secondaryColorBlue: Double = 0

    var displayBacklightColorRed: Double = 255
    
    var displayBacklightColorGreen: Double = 255
    
    var displayBacklightColorBlue: Double = 255
    
    var keyForegroundColorRed: Double = 255
    
    var keyForegroundColorGreen: Double = 255
    
    var keyForegroundColorBlue: Double = 255
    
    var keyBackgroundColorRed: Double = 0
    
    var keyBackgroundColorGreen: Double = 0
    
    var keyBackgroundColorBlue: Double = 0
    
    var cordedReceiverMainColorRed: Double = 0
    
    var cordedReceiverMainColorGreen: Double = 0
    
    var cordedReceiverMainColorBlue: Double = 0
    
    var cordedReceiverSecondaryColorRed: Double = 0
    
    var cordedReceiverSecondaryColorGreen: Double = 0
    
    var cordedReceiverSecondaryColorBlue: Double = 0
    
    var keyBacklightColorRed: Double = 0
    
    var keyBacklightColorGreen: Double = 0
    
    var keyBacklightColorBlue: Double = 0
	
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
            Color(red: mainColorRed, green: mainColorGreen, blue: mainColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            mainColorRed = components.red
            mainColorGreen = components.green
            mainColorBlue = components.blue
        }
    }
    
    var secondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: secondaryColorRed, green: secondaryColorGreen, blue: secondaryColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            secondaryColorRed = components.red
            secondaryColorGreen = components.green
            secondaryColorBlue = components.blue
        }
    }
    
    var cordedReceiverMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: cordedReceiverMainColorRed, green: cordedReceiverMainColorGreen, blue: cordedReceiverMainColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            cordedReceiverMainColorRed = components.red
            cordedReceiverMainColorGreen = components.green
            cordedReceiverMainColorBlue = components.blue
        }
    }
    
    var cordedReceiverSecondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: cordedReceiverSecondaryColorRed, green: cordedReceiverSecondaryColorGreen, blue: cordedReceiverSecondaryColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            cordedReceiverSecondaryColorRed = components.red
            cordedReceiverSecondaryColorGreen = components.green
            cordedReceiverSecondaryColorBlue = components.blue
        }
    }
    
    var displayBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: displayBacklightColorRed, green: displayBacklightColorGreen, blue: displayBacklightColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            displayBacklightColorRed = components.red
            displayBacklightColorGreen = components.green
            displayBacklightColorBlue = components.blue
        }
    }
    
    var keyBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: keyBacklightColorRed, green: keyBacklightColorGreen, blue: keyBacklightColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            keyBacklightColorRed = components.red
            keyBacklightColorGreen = components.green
            keyBacklightColorBlue = components.blue
        }
    }
    
    var keyForegroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: keyForegroundColorRed, green: keyForegroundColorGreen, blue: keyForegroundColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            keyForegroundColorRed = components.red
            keyForegroundColorGreen = components.green
            keyForegroundColorBlue = components.blue
        }
    }
    
    var keyBackgroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: keyBackgroundColorRed, green: keyBackgroundColorGreen, blue: keyBackgroundColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            keyBackgroundColorRed = components.red
            keyBackgroundColorGreen = components.green
            keyBackgroundColorBlue = components.blue
        }
    }
    
    // MARK: - Initialization
	
	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
	}
    
    // MARK: - Set Secondary Color to Main
    
    func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
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
