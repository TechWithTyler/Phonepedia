//
//  CordlessHandset.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI
import SwiftData

@Model
final class CordlessHandset: BaseColorManipulatable, ChargeLightColorManipulatable, CordedReceiverColorManipulatable, KeyColorManipulatable {

    // MARK: - Cordless Device Type Enum

    // Types of cordless devices.
    enum CordlessDeviceType : String {

        case handset = "Handset"

        case deskset = "Deskset"

        case headset = "Headset/Speakerphone"

        var plural: String {
            return "\(rawValue)s"
        }

    }

    // MARK: - Properties - Mock Handset

    // The mock handset, which is used in Xcode previews and in the phone row preview in Settings. New cordless devices added to a phone use the phone's brand, the phone's main cordless device model number, and the phone's base colors.
    @Transient
    static var mockHandset: CordlessHandset {
        let phone = Phone.mockPhone
        let cordlessHandset = CordlessHandset(brand: Phone.mockBrand, model: CordlessHandset.mockModel, mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0)
        phone.cordlessHandsetsIHave.append(cordlessHandset)
        return cordlessHandset
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

	var releaseYear: Int = currentYear - 1

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

    var earpieceType: Int = 0

    var hasChargeLight: Bool = false

    var supportsPlaceOnBasePowerBackup: Bool = true

    var canDialThenPlaceOnBase: Bool = false

    var keyLockWhenPowerReturns: Bool = false

	var buttonType: Int = 0

    var ringerVolumeAdjustmentType: Int = 1

    var supportsRingerOff: Bool = true

    var clock: Int = 1

    var supportsTimeBackup: Bool = true

    var volumeAdjustmentType: Int = 1

	var displayType: Int = 2

    var displayBrightnessContrastAdjustment: Int = 0

    var displayColorThemes: Int = 0

    var displayLocation: Int = 0

    var baseSettingsChangeMethod: Int = 0

    var hasAnsweringSystemControls: Bool = false

    var desksetDisplayCanTilt: Bool = false

    var displayMultiEntries: Bool = false

    var menuMultiItems: Bool = false

    var mainMenuLayout: Int = 0

    var batteryType: Int = 0
    
    var desksetSupportsBackupBatteries: Bool = true

    var isSlimCordedDeskset: Bool = false

    var switchHookType: Int = 0

    var cordedReceiverHookType: Int = 0

	var menuUpdateMode: Int = 0
	
	var hasSpeakerphone: Bool = true

    var intercomAutoAnswer: Int = 0

    var hasDirectCommunication: Bool = false

    var hasAutoAnswer: Bool = false

    var chargeDuringCall: Int = 0

    var hasChargeTone: Bool = false

    var canPowerOff: Bool = false

	var lineButtons: Int = 0
	
	var visualRinger: Int = 0
	
	var ringtones: Int = 5

    var musicRingtones: Int = 5

    var hasVibratorMotor: Bool = false

    var customRingtonesSource: Int = 0

    var intercomRingtone: Int = 0

    var ringsOnBase: Bool = true

    var silentMode: Int = 0

    var joinLeaveTone: Int = 0

    var supportsSilentModeBypass: Bool = false

	var oneTouchDialCapacity: Int = 0

    var hasOneTouchEmergencyCalling: Bool = false

	var speedDialCapacity: Int = 0
	
	var redialCapacity: Int = 5

    var busyRedialMode: Int = 0

	var softKeys: Int = 0
    
    var standbySoftKeysCustomizable: Bool = false
	
	var navigatorKeyType: Int = 1
	
	var navigatorKeyUpDownVolume: Bool = true
	
	var navigatorKeyStandbyShortcuts: Bool = true
	
	var navigatorKeyCenterButton: Int = 0
	
	var sideVolumeButtons: Bool = false

    var buttonPressOnChargeBehavior: Int = 0

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

    var redialDuringCall: Int = 1

	var redialNameDisplay: Int = 0

    var standbyCellCallDialing: Int = 0

    var cellLineSelection: Int = 0

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

    // The text to display for the cordless device's type.
    @Transient
    var cordlessDeviceTypeText: String {
        switch cordlessDeviceType {
        case 1: return CordlessDeviceType.deskset.rawValue
        case 2: return CordlessDeviceType.headset.rawValue
        default: return CordlessDeviceType.handset.rawValue
        }
    }

    // The text to display for the cordless device's phonebook type.
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

    // The actual number of this cordless device, which is handsetNumber (the index of the cordless device) + 1.
    @Transient
    var actualHandsetNumber: Int {
        return handsetNumber + 1
    }

    // Whether the cordless device has a secondary color (the main and secondary colors aren't the same).
    @Transient
    var hasSecondaryColor: Bool {
        return secondaryColorBinding.wrappedValue != mainColorBinding.wrappedValue
    }

    // Whether the cordless device has an accent color (the accent color is different from both the main and secondary colors).
    @Transient
    var hasAccentColor: Bool {
        return accentColorBinding.wrappedValue != mainColorBinding.wrappedValue && accentColorBinding.wrappedValue != secondaryColorBinding.wrappedValue
    }

    // Whether the cordless device is a deskset with a corded receiver.
    @Transient
    var hasCordedReceiver: Bool {
        return cordedReceiverMainColorBinding.wrappedValue != .clear
    }

    // Whether the cordless device is a handset or corded deskset.
    @Transient
    var isHandsetOrCordedDeskset: Bool {
        return cordlessDeviceType == 0 || hasCordedReceiver
    }

    // Whether the cordless device is a deskset with a display.
    @Transient
    var isDesksetWithDisplay: Bool {
        return displayType > 0 && cordlessDeviceType == 1 
    }

    // The total number of ringtones (standard and music/melody).
    @Transient
    var totalRingtones: Int {
        return ringtones + musicRingtones
    }

    // Whether the handset has a talk button instead of a single talk/off button or individual line buttons.
    @Transient
    var hasTalkButton: Bool {
        return talkOffButtonType > 0 && talkOffButtonType < 4
    }

    // Whether the handset has a physical cell button.
    @Transient
    var hasPhysicalCellButton: Bool {
        guard let phone = phone else { return false }
        return phone.baseBluetoothCellPhonesSupported > 0 && (lineButtons == 0 || talkOffButtonType == 4)
    }

    // Whether the handset's navigation button is an up/down/left/right button/joystick.
    @Transient
    var navigatorKeyLeftRight: Bool {
        return navigatorKeyType == 2 || navigatorKeyType == 3
    }

    // Whether the cordless device was acquired in the year of release (the acquisition year is the same as the release year, and both years are known).
    @Transient
    var acquiredInYearOfRelease: Bool {
        return acquisitionYear == releaseYear && acquisitionYear != -1 && releaseYear != -1
    }

    // Whether the cordless device has a monochrome (i.e. non-color) display.
    @Transient
    var hasMonochromeDisplay: Bool {
        return displayType > 0 && displayType < 5
    }

    // Whether the cordless device supports answering system/voicemail features.
    @Transient
    var supportsMessaging: Bool {
        guard let phone = phone else { return false }
        return (phone.hasAnsweringSystem > 1 && displayType > 0) || phone.voicemailIndication > 0 || phone.landlineConnectionType > 0
    }

    // Whether the cordless device has lists of entries (e.g. phonebook, caller ID list).
    @Transient
    var hasListsOfEntries: Bool {
        guard let phone = phone else { return false }
        return (phone.hasPhonebook || phone.hasCallerIDList || phone.callBlockCapacity > 0 || redialCapacity > 1)
    }

    // Whether the cordless device has a phonebook or supports a base's shared phonebook.
    @Transient
    var hasPhonebook: Bool {
        guard let phone = phone else { return false }
        return (phonebookCapacity > 0 && handsetStyle < 3) || (phone.basePhonebookCapacity > 0 && usesBasePhonebook)
    }

    // Whether the cordless device has both a phonebook and a redial list.
    @Transient
    var hasPhonebookAndRedialList: Bool {
        guard let phone = phone else { return false }
        return redialCapacity > 1 && (phonebookCapacity > 0 || (phone.basePhonebookCapacity > 0 && usesBasePhonebook))
    }

    // Whether the cordless device takes batteries (i.e. is a handset, headset, or speakerphone, or a deskset that supports backup batteries).
    @Transient
    var takesBatteries: Bool {
        return cordlessDeviceType == 0 || (cordlessDeviceType == 1 && desksetSupportsBackupBatteries)
    }

    // MARK: - Properties - Color Bindings
    
    @Transient
    var mainColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (mainColorRed, mainColorGreen, mainColorBlue) }, set: { [self] r, g, b in
            mainColorRed = r
            mainColorGreen = g
            mainColorBlue = b
        })
    }
    
    @Transient
    var secondaryColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (secondaryColorRed, secondaryColorGreen, secondaryColorBlue) }, set: { [self] r, g, b in
            secondaryColorRed = r
            secondaryColorGreen = g
            secondaryColorBlue = b
        })
    }

    @Transient
    var accentColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (accentColorRed, accentColorGreen, accentColorBlue) }, set: { [self] r, g, b in
            accentColorRed = r
            accentColorGreen = g
            accentColorBlue = b
        })
    }

    @Transient
    var chargeLightColorChargingBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (chargeLightColorChargingRed, chargeLightColorChargingGreen, chargeLightColorChargingBlue) }, set: { [self] r, g, b in
            chargeLightColorChargingRed = r
            chargeLightColorChargingGreen = g
            chargeLightColorChargingBlue = b
        })
    }

    @Transient
    var chargeLightColorChargedBinding: Binding<Color> {
        Color.rgbaQuantizedAlphaBinding(get: { [self] in (chargeLightColorChargedRed, chargeLightColorChargedGreen, chargeLightColorChargedBlue, chargeLightColorChargedAlpha) }, set: { [self] r, g, b, a in
            chargeLightColorChargedRed = r
            chargeLightColorChargedGreen = g
            chargeLightColorChargedBlue = b
            chargeLightColorChargedAlpha = a
        })
    }

    @Transient
    var cordedReceiverMainColorBinding: Binding<Color> {
        Color.rgbaQuantizedAlphaBinding(get: { [self] in (cordedReceiverMainColorRed, cordedReceiverMainColorGreen, cordedReceiverMainColorBlue, cordedReceiverMainColorAlpha) }, set: { [self] r, g, b, a in
            cordedReceiverMainColorRed = r
            cordedReceiverMainColorGreen = g
            cordedReceiverMainColorBlue = b
            cordedReceiverMainColorAlpha = a
        })
    }
    
    @Transient
    var cordedReceiverSecondaryColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (cordedReceiverSecondaryColorRed, cordedReceiverSecondaryColorGreen, cordedReceiverSecondaryColorBlue) }, set: { [self] r, g, b in
            cordedReceiverSecondaryColorRed = r
            cordedReceiverSecondaryColorGreen = g
            cordedReceiverSecondaryColorBlue = b
        })
    }

    @Transient
    var cordedReceiverAccentColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (cordedReceiverAccentColorRed, cordedReceiverAccentColorGreen, cordedReceiverAccentColorBlue) }, set: { [self] r, g, b in
            cordedReceiverAccentColorRed = r
            cordedReceiverAccentColorGreen = g
            cordedReceiverAccentColorBlue = b
        })
    }

    @Transient
    var displayBacklightColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (displayBacklightColorRed, displayBacklightColorGreen, displayBacklightColorBlue) }, set: { [self] r, g, b in
            displayBacklightColorRed = r
            displayBacklightColorGreen = g
            displayBacklightColorBlue = b
        })
    }
    
    @Transient
    var keyBacklightColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (keyBacklightColorRed, keyBacklightColorGreen, keyBacklightColorBlue) }, set: { [self] r, g, b in
            keyBacklightColorRed = r
            keyBacklightColorGreen = g
            keyBacklightColorBlue = b
        })
    }
    
    @Transient
    var keyForegroundColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (keyForegroundColorRed, keyForegroundColorGreen, keyForegroundColorBlue) }, set: { [self] r, g, b in
            keyForegroundColorRed = r
            keyForegroundColorGreen = g
            keyForegroundColorBlue = b
        })
    }
    
    @Transient
    var keyBackgroundColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (keyBackgroundColorRed, keyBackgroundColorGreen, keyBackgroundColorBlue) }, set: { [self] r, g, b in
            keyBackgroundColorRed = r
            keyBackgroundColorGreen = g
            keyBackgroundColorBlue = b
        })
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

    // MARK: - Set Acquisition Year to Release Year

    // This method sets the cordless device's acquisition year to its release year.
    func setAcquisitionYearToReleaseYear() {
        acquisitionYear = releaseYear
    }

    // MARK: - Set Key Background Color To Main

    // This method sets the key background color to the main color.
    func setKeyBackgroundColorToMain() {
        keyBackgroundColorRed = mainColorRed
        keyBackgroundColorGreen = mainColorGreen
        keyBackgroundColorBlue = mainColorBlue
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
        if newValue == 1 {
            hasSpeakerphone = true
        }
        if newValue != 1 {
            cordedReceiverMainColorBinding.wrappedValue = .clear
            cordedReceiverSecondaryColorBinding.wrappedValue = .black
            desksetSupportsBackupBatteries = false
            desksetDisplayCanTilt = false
            isSlimCordedDeskset = false
            switchHookType = 0
            cordedReceiverHookType = 0
        }
	}
    
    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if acquisitionYear < newValue && acquisitionYear != -1 {
            acquisitionYear = releaseYear
        }
        if newValue == 0 && oldValue == -1 {
            releaseYear = oldestHandsetYear
        } else if newValue < oldestHandsetYear {
            releaseYear = -1
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
        if newValue >= 5 {
            displayBacklightColorBinding.wrappedValue = .white
        }
        if newValue < 5 && displayBrightnessContrastAdjustment > 1 {
            displayBrightnessContrastAdjustment = 1
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

    // This method duplicates the cordless device.
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
        // 3. Copy all other persistent properties (those not marked @Transient).
        newHandset.phone = self.phone
        newHandset.handsetNumber = self.handsetNumber
        newHandset.releaseYear = self.releaseYear
        newHandset.acquisitionYear = self.acquisitionYear
        newHandset.whereAcquired = self.whereAcquired
        newHandset.fitsOnBase = self.fitsOnBase
        newHandset.maxBases = self.maxBases
        newHandset.cordlessDeviceType = self.cordlessDeviceType
        newHandset.handsetStyle = self.handsetStyle
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
        newHandset.cordedReceiverMainColorAlpha = self.cordedReceiverMainColorAlpha
        newHandset.cordedReceiverSecondaryColorRed = self.cordedReceiverSecondaryColorRed
        newHandset.cordedReceiverSecondaryColorGreen = self.cordedReceiverSecondaryColorGreen
        newHandset.cordedReceiverSecondaryColorBlue = self.cordedReceiverSecondaryColorBlue
        newHandset.cordedReceiverAccentColorRed = self.cordedReceiverAccentColorRed
        newHandset.cordedReceiverAccentColorGreen = self.cordedReceiverAccentColorGreen
        newHandset.cordedReceiverAccentColorBlue = self.cordedReceiverAccentColorBlue
        newHandset.keyBacklightColorRed = self.keyBacklightColorRed
        newHandset.keyBacklightColorGreen = self.keyBacklightColorGreen
        newHandset.keyBacklightColorBlue = self.keyBacklightColorBlue
        newHandset.chargeLightColorChargingRed = self.chargeLightColorChargingRed
        newHandset.chargeLightColorChargingGreen = self.chargeLightColorChargingGreen
        newHandset.chargeLightColorChargingBlue = self.chargeLightColorChargingBlue
        newHandset.chargeLightColorChargedRed = self.chargeLightColorChargedRed
        newHandset.chargeLightColorChargedGreen = self.chargeLightColorChargedGreen
        newHandset.chargeLightColorChargedBlue = self.chargeLightColorChargedBlue
        newHandset.chargeLightColorChargedAlpha = self.chargeLightColorChargedAlpha
        newHandset.earpieceType = self.earpieceType
        newHandset.hasChargeLight = self.hasChargeLight
        newHandset.supportsPlaceOnBasePowerBackup = self.supportsPlaceOnBasePowerBackup
        newHandset.canDialThenPlaceOnBase = self.canDialThenPlaceOnBase
        newHandset.keyLockWhenPowerReturns = self.keyLockWhenPowerReturns
        newHandset.buttonType = self.buttonType
        newHandset.ringerVolumeAdjustmentType = self.ringerVolumeAdjustmentType
        newHandset.supportsRingerOff = self.supportsRingerOff
        newHandset.clock = self.clock
        newHandset.supportsTimeBackup = self.supportsTimeBackup
        newHandset.volumeAdjustmentType = self.volumeAdjustmentType
        newHandset.displayType = self.displayType
        newHandset.displayLocation = self.displayLocation
        newHandset.baseSettingsChangeMethod = self.baseSettingsChangeMethod
        newHandset.hasAnsweringSystemControls = self.hasAnsweringSystemControls
        newHandset.desksetDisplayCanTilt = self.desksetDisplayCanTilt
        newHandset.displayMultiEntries = self.displayMultiEntries
        newHandset.menuMultiItems = self.menuMultiItems
        newHandset.mainMenuLayout = self.mainMenuLayout
        newHandset.batteryType = self.batteryType
        newHandset.desksetSupportsBackupBatteries = self.desksetSupportsBackupBatteries
        newHandset.isSlimCordedDeskset = self.isSlimCordedDeskset
        newHandset.switchHookType = self.switchHookType
        newHandset.cordedReceiverHookType = self.cordedReceiverHookType
        newHandset.menuUpdateMode = self.menuUpdateMode
        newHandset.hasSpeakerphone = self.hasSpeakerphone
        newHandset.intercomAutoAnswer = self.intercomAutoAnswer
        newHandset.hasDirectCommunication = self.hasDirectCommunication
        newHandset.hasAutoAnswer = self.hasAutoAnswer
        newHandset.chargeDuringCall = self.chargeDuringCall
        newHandset.hasChargeTone = self.hasChargeTone
        newHandset.canPowerOff = self.canPowerOff
        newHandset.lineButtons = self.lineButtons
        newHandset.visualRinger = self.visualRinger
        newHandset.ringtones = self.ringtones
        newHandset.musicRingtones = self.musicRingtones
        newHandset.hasVibratorMotor = self.hasVibratorMotor
        newHandset.customRingtonesSource = self.customRingtonesSource
        newHandset.intercomRingtone = self.intercomRingtone
        newHandset.silentMode = self.silentMode
        newHandset.supportsSilentModeBypass = self.supportsSilentModeBypass
        newHandset.oneTouchDialCapacity = self.oneTouchDialCapacity
        newHandset.hasOneTouchEmergencyCalling = self.hasOneTouchEmergencyCalling
        newHandset.speedDialCapacity = self.speedDialCapacity
        newHandset.redialCapacity = self.redialCapacity
        newHandset.busyRedialMode = self.busyRedialMode
        newHandset.softKeys = self.softKeys
        newHandset.standbySoftKeysCustomizable = self.standbySoftKeysCustomizable
        newHandset.navigatorKeyType = self.navigatorKeyType
        newHandset.navigatorKeyUpDownVolume = self.navigatorKeyUpDownVolume
        newHandset.navigatorKeyStandbyShortcuts = self.navigatorKeyStandbyShortcuts
        newHandset.navigatorKeyCenterButton = self.navigatorKeyCenterButton
        newHandset.sideVolumeButtons = self.sideVolumeButtons
        newHandset.buttonPressOnChargeBehavior = self.buttonPressOnChargeBehavior
        newHandset.keyBacklightAmount = self.keyBacklightAmount
        newHandset.keyBacklightLayer = self.keyBacklightLayer
        newHandset.supportsWiredHeadsets = self.supportsWiredHeadsets
        newHandset.answeringSystemMenu = self.answeringSystemMenu
        newHandset.hasMessageList = self.hasMessageList
        newHandset.voicemailQuickDial = self.voicemailQuickDial
        newHandset.phonebookCapacity = self.phonebookCapacity
        newHandset.numbersPerPhonebookEntry = self.numbersPerPhonebookEntry
        newHandset.supportsPhonebookRingtones = self.supportsPhonebookRingtones
        newHandset.supportsPhonebookGroups = self.supportsPhonebookGroups
        newHandset.favoriteEntriesCapacity = self.favoriteEntriesCapacity
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
        newHandset.alarm = self.alarm
        newHandset.hasTalkingCallerID = self.hasTalkingCallerID
        newHandset.hasKeypadLock = self.hasKeypadLock
        newHandset.hasTalkingKeypad = self.hasTalkingKeypad
        newHandset.hasTalkingPhonebook = self.hasTalkingPhonebook
        newHandset.audibleLowBatteryAlert = self.audibleLowBatteryAlert
        newHandset.talkOffButtonType = self.talkOffButtonType
        newHandset.talkOffColorLayer = self.talkOffColorLayer
        newHandset.speakerphoneColorLayer = self.speakerphoneColorLayer
        newHandset.hasSpeakerphoneButtonLight = self.hasSpeakerphoneButtonLight
        newHandset.storageOrSetup = self.storageOrSetup
        newHandset.hasQZ = self.hasQZ
        newHandset.displayColorThemes = self.displayColorThemes
        newHandset.displayBrightnessContrastAdjustment = self.displayBrightnessContrastAdjustment
        // 4. Return the duplicated handset.
        return newHandset
    }

}
