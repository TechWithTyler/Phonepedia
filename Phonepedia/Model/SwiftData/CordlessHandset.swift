//
//  CordlessHandset.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class CordlessHandset {

    // MARK: - Cordless Device Type Enum

    // Types of cordless devices.
    enum CordlessDeviceType : String {

        case handset = "Handset"

        case deskset = "Deskset"

        case headset = "Headset/Speakerphone"

    }

    // MARK: - Properties - Default Data

    @Transient
    static var mockModel: String = "MH12"

    // MARK: - Properties - Persistent Data
    
    var id = UUID()
	
	var phone: Phone?
	
	var brand: String
	
	var model: String

    var handsetNumber: Int = 0

	var releaseYear: Int = currentYear

    var acquisitionYear: Int = currentYear

    var whereAcquired: Int = 0

	var fitsOnBase: Bool = true
	
	var maxBases: Int = 1
	
	var cordlessDeviceType: Int = 0

    var handsetStyle: Int = 0

    var mainColorRed: Double = 0
    
    var mainColorGreen: Double = 0
    
    var mainColorBlue: Double = 0
    
    var secondaryColorRed: Double = 0
    
    var secondaryColorGreen: Double = 0
    
    var secondaryColorBlue: Double = 0

    var accentColorRed: Double = 0

    var accentColorGreen: Double = 0

    var accentColorBlue: Double = 0

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

    var cordedReceiverMainColorAlpha: Double = 0

    var cordedReceiverSecondaryColorRed: Double = 0
    
    var cordedReceiverSecondaryColorGreen: Double = 0
    
    var cordedReceiverSecondaryColorBlue: Double = 0

    var cordedReceiverAccentColorRed: Double = 0

    var cordedReceiverAccentColorGreen: Double = 0

    var cordedReceiverAccentColorBlue: Double = 0

    var keyBacklightColorRed: Double = 0
    
    var keyBacklightColorGreen: Double = 255

    var keyBacklightColorBlue: Double = 0

    var chargeLightColorChargingRed: Double = 255

    var chargeLightColorChargingGreen: Double = 0

    var chargeLightColorChargingBlue: Double = 0

    var chargeLightColorChargedRed: Double = 0

    var chargeLightColorChargedGreen: Double = 255

    var chargeLightColorChargedBlue: Double = 0

    var chargeLightColorChargedAlpha: Double = 1

    var hasChargeLight: Bool = false

	var buttonType: Int = 0

    var ringerVolumeAdjustmentType: Int = 1

    var supportsRingerOff: Bool = true

    var clock: Int = 1

    var supportsTimeBackup: Bool = true

    var volumeAdjustmentType: Int = 1

	var displayType: Int = 2

    var baseSettingsChangeMethod: Int = 0

    var desksetDisplayCanTilt: Bool = false

    var displayMultiEntries: Bool = false

    var menuMultiItems: Bool = false

    var mainMenuLayout: Int = 0

    var batteryType: Int = 0
    
    var desksetSupportsBackupBatteries: Bool = true
	
	var menuUpdateMode: Int = 0
	
	var hasSpeakerphone: Bool = true

    var intercomAutoAnswer: Int = 0

    var hasDirectCommunication: Bool = false

    var hasAutoAnswer: Bool = false

    var chargeDuringCall: Int = 0

    var hasChargeTone: Bool = false

	var lineButtons: Int = 0
	
	var visualRinger: Int = 0
	
	var ringtones: Int = 5

    var musicRingtones: Int = 5

    var hasVibratorMotor: Bool = false

    var customRingtonesSource: Int = 0

    var intercomRingtone: Int = 0

    var silentMode: Int = 0

    var supportsSilentModeBypass: Bool = false

	var oneTouchDialCapacity: Int = 0

    var hasOneTouchEmergencyCalling: Bool = false

	var speedDialCapacity: Int = 0
	
	var redialCapacity: Int = 5
	
	var softKeys: Int = 0
    
    var standbySoftKeysCustomizable: Bool = false
	
	var navigatorKeyType: Int = 1
	
	var navigatorKeyUpDownVolume: Bool = true
	
	var navigatorKeyStandbyShortcuts: Bool = true
	
	var navigatorKeyCenterButton: Int = 0
	
	var sideVolumeButtons: Bool = false
	
	var keyBacklightAmount: Int = 0

    var keyBacklightLayer: Int = 0

	var supportsWiredHeadsets: Bool = false
	
	var answeringSystemMenu: Int = 3

    var hasMessageList: Bool = false

    var voicemailQuickDial: Int = 0

	var phonebookCapacity: Int = 0

    var numbersPerPhonebookEntry: Int = 1

    var supportsPhonebookRingtones: Bool = false

    var supportsPhonebookGroups: Bool = false

    var favoriteEntriesCapacity: Int = 0

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

    var alarm: Int = 0

	var hasTalkingCallerID: Bool = false

    var hasKeypadLock: Bool = false

	var hasTalkingKeypad: Bool = false
	
	var hasTalkingPhonebook: Bool = false

    var audibleLowBatteryAlert: Int = 0

    var talkOffButtonType = 1
    
    var talkOffColorLayer: Int = 1
    
    var speakerphoneColorLayer: Int = 1
    
    var hasSpeakerphoneButtonLight: Bool = false
    
    var storageOrSetup: Int = 0
    
    var hasQZ: Bool = true

    // MARK: - Properties - Transient (Non-Persistent) Properties

    @Transient
    var cordlessDeviceTypeText: String {
        switch cordlessDeviceType {
        case 1: return CordlessDeviceType.deskset.rawValue
        case 2: return CordlessDeviceType.headset.rawValue
        default: return CordlessDeviceType.handset.rawValue
        }
    }

    @Transient
    var phonebookTypeText: String {
        if usesBasePhonebook && phonebookCapacity > 0 {
            return CordlessHandset.HandsetPhonebookType.sharedAndIndividual.rawValue
        } else if usesBasePhonebook {
            return CordlessHandset.HandsetPhonebookType.shared.rawValue
        } else if phonebookCapacity > 0 {
            return CordlessHandset.HandsetPhonebookType.individual.rawValue
        } else {
            return "None"
        }
    }

    @Transient
    var hasCordedReceiver: Bool {
        return cordedReceiverMainColorBinding.wrappedValue != .clear
    }

    @Transient
    var totalRingtones: Int {
        return ringtones + musicRingtones
    }
    
    @Transient
    var hasPhysicalCellButton: Bool {
        guard let phone = phone else { return false }
        return phone.baseBluetoothCellPhonesSupported > 0 && lineButtons == 0
    }
    
    // MARK: - Properties - Color Bindings
    
    @Transient
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
    
    @Transient
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

    @Transient
    var accentColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: accentColorRed, green: accentColorGreen, blue: accentColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            accentColorRed = components.red
            accentColorGreen = components.green
            accentColorBlue = components.blue
        }
    }

    @Transient
    var chargeLightColorChargingBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: chargeLightColorChargingRed, green: chargeLightColorChargingGreen, blue: chargeLightColorChargingBlue)
        } set: { [self] newValue in
            let components = newValue.components
            chargeLightColorChargingRed = components.red
            chargeLightColorChargingGreen = components.green
            chargeLightColorChargingBlue = components.blue
        }
    }

    @Transient
    var chargeLightColorChargedBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: chargeLightColorChargedRed, green: chargeLightColorChargedGreen, blue: chargeLightColorChargedBlue, opacity: Double(Int(chargeLightColorChargedAlpha.rounded(.toNearestOrEven))))
        } set: { [self] newValue in
            let components = newValue.components
            chargeLightColorChargedRed = components.red
            chargeLightColorChargedGreen = components.green
            chargeLightColorChargedBlue = components.blue
            chargeLightColorChargedAlpha = Double(Int(components.opacity.rounded(.toNearestOrEven)))
        }
    }

    @Transient
    var cordedReceiverMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: cordedReceiverMainColorRed, green: cordedReceiverMainColorGreen, blue: cordedReceiverMainColorBlue, opacity: Double(Int(cordedReceiverMainColorAlpha.rounded(.toNearestOrEven))))
        } set: { [self] newColor in
            let components = newColor.components
            cordedReceiverMainColorRed = components.red
            cordedReceiverMainColorGreen = components.green
            cordedReceiverMainColorBlue = components.blue
            cordedReceiverMainColorAlpha = Double(Int(components.opacity.rounded(.toNearestOrEven)))
        }
    }
    
    @Transient
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

    @Transient
    var cordedReceiverAccentColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: cordedReceiverAccentColorRed, green: cordedReceiverAccentColorGreen, blue: cordedReceiverAccentColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            cordedReceiverAccentColorRed = components.red
            cordedReceiverAccentColorGreen = components.green
            cordedReceiverAccentColorBlue = components.blue
        }
    }

    @Transient
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
    
    @Transient
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
    
    @Transient
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
    
    @Transient
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
	
    init(brand: String, model: String, mainColorRed: Double, mainColorGreen: Double, mainColorBlue: Double, secondaryColorRed: Double, secondaryColorGreen: Double, secondaryColorBlue: Double, accentColorRed: Double, accentColorGreen: Double, accentColorBlue: Double) {
		self.brand = brand
		self.model = model
        self.mainColorRed = mainColorRed
        self.mainColorGreen = mainColorGreen
        self.mainColorBlue = mainColorBlue
        self.secondaryColorRed = secondaryColorRed
        self.secondaryColorGreen = secondaryColorGreen
        self.secondaryColorBlue = secondaryColorBlue
        self.accentColorRed = accentColorRed
        self.accentColorGreen = accentColorGreen
        self.accentColorBlue = accentColorBlue
	}
    
    // MARK: - Color Methods

    func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
    }

    func setCordedReceiverSecondaryColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverSecondaryColorRed = components.red
        cordedReceiverSecondaryColorGreen = components.green
        cordedReceiverSecondaryColorBlue = components.blue
    }

    // MARK: - Set Accent Color

    func setAccentColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    func setAccentColorToSecondary() {
        let components = secondaryColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    func setChargeLightChargedColorToCharging() {
        let components = chargeLightColorChargingBinding.wrappedValue.components
        chargeLightColorChargedRed = components.red
        chargeLightColorChargedGreen = components.green
        chargeLightColorChargedBlue = components.blue
        chargeLightColorChargedAlpha = 1
    }

    func setCordedReceiverAccentColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

    func setCordedReceiverAccentColorToSecondary() {
        let components = cordedReceiverSecondaryColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

    func swapKeyBackgroundAndForegroundColors() {
        let previousBackgroundRed = keyBackgroundColorRed
        let previousBackgroundGreen = keyBackgroundColorGreen
        let previousBackgroundBlue = keyBackgroundColorBlue
        keyBackgroundColorRed = keyForegroundColorRed
        keyBackgroundColorGreen = keyForegroundColorGreen
        keyBackgroundColorBlue = keyForegroundColorBlue
        keyForegroundColorRed = previousBackgroundRed
        keyForegroundColorGreen = previousBackgroundGreen
        keyForegroundColorBlue = previousBackgroundBlue
    }

    // MARK: - Property Change Handlers

    func brandChanged(oldValue: String, newValue: String) {
        if newValue.isEmpty {
            brand = Phone.mockBrand
        }
    }

    func phonebookCapacityChanged(oldValue: Int, newValue: Int) {
        if newValue < phonebookTransferRequiredMaxCapacity {
            bluetoothPhonebookTransfers = false
        }
        if newValue == 0 {
            redialNameDisplay = 0
            callerIDPhonebookMatch = false
            hasTalkingPhonebook = false
            speedDialPhonebookEntryMode = 0
        }
    }

    func handsetStyleChanged(oldValue: Int, newValue: Int) {
        if newValue > 2 {
            talkOffButtonType = 1
            hasVibratorMotor = true
            hasSpeakerphone = true
        }
        if newValue == 2 {
            displayType = 4
            navigatorKeyType = 2
        } else if newValue == 3 {
            phonebookCapacity = 50
            callerIDCapacity = 50
            oneTouchDialCapacity = 0
            sideVolumeButtons = true
            displayType = 5
        }
    }

	func cordlessDeviceTypeChanged(oldValue: Int, newValue: Int) {
		if newValue > 0 {
            handsetStyle = 0
            talkOffButtonType = 0
            talkOffColorLayer = 0
			fitsOnBase = false
            batteryType = 0
            keyFindersSupported = 0
		}
        if newValue != 1 {
            cordedReceiverMainColorBinding.wrappedValue = .clear
            cordedReceiverSecondaryColorBinding.wrappedValue = .black
            desksetSupportsBackupBatteries = false
            desksetDisplayCanTilt = false
        }
	}
    
    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if acquisitionYear < newValue {
            acquisitionYear = releaseYear
        }
        if newValue == 0 && oldValue == -1 {
            releaseYear = 1965
        } else if newValue < 1965 {
            releaseYear = -1
        }
    }

    func acquisitionYearChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 && oldValue == -1 {
            acquisitionYear = releaseYear
        } else if newValue < releaseYear {
            acquisitionYear = -1
        }
    }

    func totalRingtonesChanged(oldValue: Int, newValue: Int) {
        if newValue < oldValue && (intercomRingtone >= (totalRingtones + 1) || intercomRingtone == 1) {
            intercomRingtone -= 1
        }
    }

    func voicemailQuickDialChanged(oldValue: Int, newValue: Int) {
        if newValue == 2 && speedDialCapacity > 9 {
            speedDialCapacity = 9
        }
    }

	func displayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
            desksetDisplayCanTilt = false
            if answeringSystemMenu > 0 {
                answeringSystemMenu = 0
            }
			hasTalkingPhonebook = false
            if voicemailQuickDial > 2 {
                voicemailQuickDial = 0
            }
		}
		if newValue <= 1 {
			softKeys = 0
		}
        if newValue < 3 {
            mainMenuLayout = 0
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
			navigatorKeyCenterButton = 0
		}
		if newValue == 0 {
			lineButtons = 0
		}
	}
	
	func sideVolumeButtonsChanged(oldValue: Bool, newValue: Bool) {
		if !newValue {
			navigatorKeyUpDownVolume = true
            ringerVolumeAdjustmentType = 1
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

    // MARK: - Duplicate

    func duplicate() -> CordlessHandset {
        // 1. Initialize a new CordlessHandset, passing the original's properties to the initializer.
        let newHandset = CordlessHandset(
            brand: brand,
            model: model,
            mainColorRed: mainColorRed,
            mainColorGreen: mainColorGreen,
            mainColorBlue: mainColorBlue,
            secondaryColorRed: secondaryColorRed,
            secondaryColorGreen: secondaryColorGreen,
            secondaryColorBlue: secondaryColorBlue,
            accentColorRed: accentColorRed,
            accentColorGreen: accentColorGreen,
            accentColorBlue: accentColorBlue
        )
        // 2. Give the duplicated handset a new UUID.
        newHandset.id = UUID()
        // 3. Copy all other properties.
        newHandset.phone = self.phone
        newHandset.releaseYear = self.releaseYear
        newHandset.acquisitionYear = self.acquisitionYear
        newHandset.whereAcquired = self.whereAcquired
        newHandset.fitsOnBase = self.fitsOnBase
        newHandset.maxBases = self.maxBases
        newHandset.cordlessDeviceType = self.cordlessDeviceType
        newHandset.displayBacklightColorRed = self.displayBacklightColorRed
        newHandset.displayBacklightColorGreen = self.displayBacklightColorGreen
        newHandset.displayBacklightColorBlue = self.displayBacklightColorBlue
        newHandset.keyForegroundColorRed = self.keyForegroundColorRed
        newHandset.keyForegroundColorGreen = self.keyForegroundColorGreen
        newHandset.keyForegroundColorBlue = self.keyForegroundColorBlue
        newHandset.keyBackgroundColorRed = self.keyBackgroundColorRed
        newHandset.keyBackgroundColorGreen = self.keyBackgroundColorGreen
        newHandset.keyBackgroundColorBlue = self.keyBackgroundColorBlue
        newHandset.cordedReceiverMainColorRed = self.cordedReceiverMainColorRed
        newHandset.cordedReceiverMainColorGreen = self.cordedReceiverMainColorGreen
        newHandset.cordedReceiverMainColorBlue = self.cordedReceiverMainColorBlue
        newHandset.cordedReceiverSecondaryColorRed = self.cordedReceiverSecondaryColorRed
        newHandset.cordedReceiverSecondaryColorGreen = self.cordedReceiverSecondaryColorGreen
        newHandset.cordedReceiverSecondaryColorBlue = self.cordedReceiverSecondaryColorBlue
        newHandset.keyBacklightColorRed = self.keyBacklightColorRed
        newHandset.keyBacklightColorGreen = self.keyBacklightColorGreen
        newHandset.keyBacklightColorBlue = self.keyBacklightColorBlue
        newHandset.buttonType = self.buttonType
        newHandset.displayType = self.displayType
        newHandset.batteryType = self.batteryType
        newHandset.desksetSupportsBackupBatteries = self.desksetSupportsBackupBatteries
        newHandset.menuUpdateMode = self.menuUpdateMode
        newHandset.hasSpeakerphone = self.hasSpeakerphone
        newHandset.lineButtons = self.lineButtons
        newHandset.visualRinger = self.visualRinger
        newHandset.ringtones = self.ringtones
        newHandset.musicRingtones = self.musicRingtones
        newHandset.customRingtonesSource = self.customRingtonesSource
        newHandset.intercomRingtone = self.intercomRingtone
        newHandset.oneTouchDialCapacity = self.oneTouchDialCapacity
        newHandset.speedDialCapacity = self.speedDialCapacity
        newHandset.redialCapacity = self.redialCapacity
        newHandset.softKeys = self.softKeys
        newHandset.standbySoftKeysCustomizable = self.standbySoftKeysCustomizable
        newHandset.navigatorKeyType = self.navigatorKeyType
        newHandset.navigatorKeyUpDownVolume = self.navigatorKeyUpDownVolume
        newHandset.navigatorKeyStandbyShortcuts = self.navigatorKeyStandbyShortcuts
        newHandset.navigatorKeyCenterButton = self.navigatorKeyCenterButton
        newHandset.sideVolumeButtons = self.sideVolumeButtons
        newHandset.keyBacklightAmount = self.keyBacklightAmount
        newHandset.supportsWiredHeadsets = self.supportsWiredHeadsets
        newHandset.answeringSystemMenu = self.answeringSystemMenu
        newHandset.phonebookCapacity = self.phonebookCapacity
        newHandset.callerIDPhonebookMatch = self.callerIDPhonebookMatch
        newHandset.usesBasePhonebook = self.usesBasePhonebook
        newHandset.usesBaseCallerID = self.usesBaseCallerID
        newHandset.usesBaseSpeedDial = self.usesBaseSpeedDial
        newHandset.usesBaseOneTouchDial = self.usesBaseOneTouchDial
        newHandset.speedDialPhonebookEntryMode = self.speedDialPhonebookEntryMode
        newHandset.redialNameDisplay = self.redialNameDisplay
        newHandset.bluetoothHeadphonesSupported = self.bluetoothHeadphonesSupported
        newHandset.bluetoothPhonebookTransfers = self.bluetoothPhonebookTransfers
        newHandset.callerIDCapacity = self.callerIDCapacity
        newHandset.keyFindersSupported = self.keyFindersSupported
        newHandset.antenna = self.antenna
        newHandset.hasTalkingCallerID = self.hasTalkingCallerID
        newHandset.hasTalkingKeypad = self.hasTalkingKeypad
        newHandset.hasTalkingPhonebook = self.hasTalkingPhonebook
        newHandset.audibleLowBatteryAlert = self.audibleLowBatteryAlert
        newHandset.talkOffButtonType = self.talkOffButtonType
        newHandset.talkOffColorLayer = self.talkOffColorLayer
        newHandset.speakerphoneColorLayer = self.speakerphoneColorLayer
        newHandset.hasSpeakerphoneButtonLight = self.hasSpeakerphoneButtonLight
        newHandset.storageOrSetup = self.storageOrSetup
        newHandset.hasQZ = self.hasQZ
        newHandset.alarm = self.alarm
        newHandset.handsetStyle = self.handsetStyle
        newHandset.keyBacklightLayer = self.keyBacklightLayer
        newHandset.volumeAdjustmentType = self.volumeAdjustmentType
        newHandset.ringerVolumeAdjustmentType = self.ringerVolumeAdjustmentType
        newHandset.supportsRingerOff = self.supportsRingerOff
        newHandset.hasAutoAnswer = self.hasAutoAnswer
        newHandset.intercomAutoAnswer = self.intercomAutoAnswer
        newHandset.chargeDuringCall = self.chargeDuringCall
        newHandset.hasChargeTone = self.hasChargeTone
        newHandset.hasDirectCommunication = self.hasDirectCommunication
        newHandset.displayMultiEntries = self.displayMultiEntries
        newHandset.menuMultiItems = self.menuMultiItems
        newHandset.hasMessageList = self.hasMessageList
        newHandset.favoriteEntriesCapacity = self.favoriteEntriesCapacity
        newHandset.supportsPhonebookRingtones = self.supportsPhonebookRingtones
        newHandset.supportsPhonebookGroups = self.supportsPhonebookGroups
        newHandset.clock = self.clock
        newHandset.supportsTimeBackup = self.supportsTimeBackup
        newHandset.chargeLightColorChargingRed = self.chargeLightColorChargingRed
        newHandset.chargeLightColorChargingGreen = self.chargeLightColorChargingGreen
        newHandset.chargeLightColorChargingBlue = self.chargeLightColorChargingBlue
        newHandset.chargeLightColorChargedRed = self.chargeLightColorChargedRed
        newHandset.chargeLightColorChargedGreen = self.chargeLightColorChargedGreen
        newHandset.chargeLightColorChargedBlue = self.chargeLightColorChargedBlue
        newHandset.chargeLightColorChargedAlpha = self.chargeLightColorChargedAlpha
        newHandset.hasChargeLight = self.hasChargeLight
        // 4. Return the duplicated handset.
        return newHandset
    }

}
