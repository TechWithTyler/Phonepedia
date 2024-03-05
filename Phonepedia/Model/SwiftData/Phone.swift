//
//  Phone.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

// The structure of a SwiftData model class is very simple--a Swift class with @Model before its declaration.
@Model
final class Phone {
    
    // MARK: - Properties - Default Photo Data

	static var defaultPhotoData: Data {
#if os(iOS) || os(visionOS)
		return getPNGDataFromUIImage(image: .phone)
#elseif os(macOS)
		return getPNGDataFromNSImage(image: .phone)
#endif
	}
    
    // MARK: - Properties - Persistent Data
    
    // At least one property should be created without a default value, being assigned the default in init(), to reduce performance issues.
	var brand: String

	var model: String
	
    // There must be one or more properties declared with an initial value for automatic (lightweight) migration to work.
    // Use @Attribute(_:) to specify an attribute for a SwiftData property.
	@Attribute(.externalStorage) var photoData: Data? = nil

	var releaseYear: Int = currentYear
    
    var baseMainColorHex: String = Color.black.hex!
    
    var baseSecondaryColorHex: String = Color.black.hex!
    
    var cordedReceiverMainColorHex: String = Color.clear.hex!
    
    var cordedReceiverSecondaryColorHex: String = Color.black.hex!
    
    var baseDisplayBacklightColorHex: String = Color.white.hex!
    
    var baseKeyBacklightColorHex: String = Color.white.hex!
    
    var baseKeyForegroundColorHex: String = Color.white.hex!
    
    var baseKeyBackgroundColorHex: String = Color.black.hex!
    
    var baseLEDMessageCounterColorHex: String = Color.black.hex!
    
    var baseBackupBatteryType: Int = 0
    
    var locatorButtons: Int = 0
    
    var deregistration: Int = 2
    
    var buttonType: Int = 0
    
    var chargeLight: Int = 0
	
	var cordedPhoneType: Int = 0
	
	var cordedRingerType: Int = 0
	
	var numberOfIncludedCordlessHandsets: Int = 1
	
	var maxCordlessHandsets: Int = 5
	
	var supportsRangeExtenders: Bool = false
	
	var hasTransmitOnlyBase: Bool = false
	
	var frequency: Int = 24
    
    var hasNoLineAlert: Bool = false

    // Use @Relationship(deleteRule:inverse:) to define a relationship between a property and its type. The type of an @Relationship property must contain an Optional property of this object's type. In this case, a relationship is established between a CordlessHandset and its corresponding Phone.
    // This is a one-to-many relationship--each Phone can have multiple CordlessHandsets but each CordlessHandset can only be assigned to one Phone.
	@Relationship(deleteRule: .cascade, inverse: \CordlessHandset.phone)
	var cordlessHandsetsIHave: [CordlessHandset] = []
	
	@Relationship(deleteRule: .cascade, inverse: \Charger.phone)
	var chargersIHave: [Charger] = []
	
	var baseRingtones: Int = 1
	
	var baseMusicRingtones: Int = 0
	
    var baseIntercomRingtone: Int = 0
	
	var hasIntercom: Bool = true
	
	var hasBaseIntercom: Bool = false
	
	var numberOfLandlines: Int = 1
	
	var landlineInUseStatusOnBase: Int = 0
	
	var landlineInUseVisualRingerFollowsRingSignal: Bool = true
	
	var cellLineInUseStatusOnBase: Int = 0
	
	var cellLineOnlyBehavior: Int = 0
	
	var baseChargingDirection: Int = 0
	
	var baseHasSeparateDataContact: Bool = false
	
	var baseChargeContactPlacement: Int = 0
	
	var baseChargeContactType: Int = 1
	
	var hasAnsweringSystem: Int = 3
	
	var answeringSystemMenuOnBase: Int = 0
	
	var greetingRecordingOnBaseOrHandset: Int = 1
	
	var hasMessageAlertByCall: Bool = false
	
	var hasGreetingOnlyMode: Bool = true
	
	var voicemailIndication: Int = 3
	
	var voicemailQuickDial: Int = 3

	var voicemailFeatureCodes: Bool = false

	var hasBaseSpeakerphone: Bool = false
	
	var hasBaseKeypad: Bool = false
	
	var hasTalkingCallerID: Bool = false
	
	var hasTalkingKeypad: Bool = false
	
	var hasTalkingPhonebook: Bool = false
	
	var baseDisplayType: Int = 0
    
    var handsetRenaming: Int = 0
	
	var baseHasDisplayAndMessageCounter: Bool = false
	
	var baseSoftKeysBottom: Int = 0
	
	var baseSoftKeysSide: Int = 0
	
	var baseNavigatorKeyType: Int = 0
	
	var baseNavigatorKeyStandbyShortcuts: Bool = false
	
	var baseNavigatorKeyCenterButton: Int = 0
	
	var baseNavigatorKeyLeftRightRepeatSkip: Bool = false
	
	var baseNavigatorKeyUpDownVolume: Bool = false
	
	var baseKeyBacklightAmount: Int = 0
	
	var cordedPowerSource: Int = 0
	
	var cordlessPowerBackupMode: Int = 0
	
	var cordlessPowerBackupReturnBehavior: Int = 0
	
	var baseSupportsWiredHeadsets: Bool = false
	
	var baseBluetoothHeadphonesSupported: Int = 0
	
	var baseBluetoothCellPhonesSupported: Int = 0
    
    var supportsPhonebookTransferDialingCodes: Bool = false
    
    var supportsDialingOfInternationalCode: Bool = false
    
    var supportsAddingOfCellAreaCode: Bool = false
    
    var landlineLocalAreaCodeFeatures: Int = 0
    
    var baseCellRingtone: Int = 1
	
	var bluetoothPhonebookTransfers: Int = 0
	
	var hasCellPhoneVoiceControl: Bool = false
	
	var basePhonebookCapacity: Int = 50
	
	var baseCallerIDCapacity: Int = 50
	
	var baseRedialCapacity: Int = 0
	
	var redialNameDisplay: Int = 0
	
	var callerIDPhonebookMatch: Bool = true
	
	var baseSpeedDialCapacity: Int = 0
	
	var baseOneTouchDialCapacity: Int = 0
	
	var oneTouchDialSupportsHandsetNumbers: Bool = false
	
	var speedDialPhonebookEntryMode: Int = 0
	
	var callBlockCapacity: Int = 1000
	
	var callBlockSupportsPrefixes: Bool = false
	
	var blockedCallersHear: Int = 0
	
	var hasFirstRingSuppression: Bool = true
	
	var hasOneTouchCallBlock: Bool = true
	
	var callBlockPreProgrammedDatabaseEntryCount: Int = 0
	
	var callBlockPreScreening: Int = 2
	
	var callBlockPreScreeningCustomGreeting: Bool = false
	
	var callBlockPreScreeningAllowedNameCapacity: Int = 100
	
	var callBlockPreScreeningAllowedNumberCapacity: Int = 100
	
	var callBlockPreScreeningAllowedNumberListVisible: Bool = true
	
	var roomMonitor: Int = 0
	
	var externalRoomMonitorAutomatedSystem: Int = 0
	
	var smartHomeDevicesSupported: Int = 0
	
	var answerByVoice: Bool = false
	
	var smartphonesAsHandsetsOverWiFi: Int = 0
	
	var scamCallDetection: Bool = false
	
	var placeOnBaseAutoRegister: Bool = true
	
	var wallMountability: Int = 1
	
	var antennas: Int = 0
    
    var musicOnHoldPreset: Bool = false
    
    var musicOnHoldRecord: Bool = false
    
    var musicOnHoldLive: Bool = false
    
    var hasChargerSizeBase: Bool = false
    
    var landlineConnectionType: Int = 0
    
    var landlineConnectedTo: Int = 2
    
    var storageOrSetup: Int = 0
    
    var phoneDescription: String
    
    var hasQZ: Bool = true
    
    // MARK: - Properties - Transient (Non-Persistent) Properties
	
    // Properties marked with the @Transient property wrapper won't persist their values to SwiftData.
    @Transient
	var phoneTypeText: String {
		if isCordedCordless {
            return PhoneType.cordedCordless.rawValue
		} else if isCordless {
			if hasTransmitOnlyBase {
                return PhoneType.cordlessWithTransmitOnlyBase.rawValue
			}
            return PhoneType.cordless.rawValue
		} else {
            return PhoneType.corded.rawValue
		}
	}
    
    @Transient
    var totalBaseRingtones: Int {
        return baseRingtones + baseMusicRingtones
    }
	
    @Transient
	var hasCordedReceiver: Bool {
        return cordedReceiverMainColorBinding.wrappedValue != .clear
	}
	
    @Transient
	var isCordless: Bool {
		return numberOfIncludedCordlessHandsets > 0
	}
	
    @Transient
	var isCordedCordless: Bool {
		return isCordless && hasCordedReceiver
	}
    
    @Transient
    var hasRegistration: Bool {
        return maxCordlessHandsets != -1
    }
    
    @Transient
    var baseChargesHandset: Bool {
        return isCordless && !hasCordedReceiver && !hasTransmitOnlyBase
    }
    
    @Transient
    var supportsWiredHeadsets: Bool {
        return baseSupportsWiredHeadsets || !cordlessHandsetsIHave.filter({$0.supportsWiredHeadsets}).isEmpty
    }
    
    // The following computed properties check whether the base and/or cordless handsets of a cordless phone have a given feature. For corded phones, the cordless handset checks don't apply.
    
    @Transient
    var hasCallerIDList: Bool {
        return baseCallerIDCapacity > 0 || !cordlessHandsetsIHave.filter({$0.callerIDCapacity > 0}).isEmpty
    }
    
    // MARK: - Color Bindings
    
    // SwiftData can only store Codable types like String, Int, Double, and Bool, not complex types like Color. To allow ColorPicker to work with SwiftData, a custom Color binding is created, which gets and sets color component Double values stored in SwiftData.
    
    @Transient
    var baseMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseMainColorHex)!
        } set: { [self] newColor in
            baseMainColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseSecondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseSecondaryColorHex)!
        } set: { [self] newColor in
                baseSecondaryColorHex = newColor.hex!
        }
    }
    
    @Transient
    var cordedReceiverMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: cordedReceiverMainColorHex)!
        } set: { [self] newColor in
                cordedReceiverMainColorHex = newColor.hex!
        }
    }
    
    @Transient
    var cordedReceiverSecondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: cordedReceiverSecondaryColorHex)!
        } set: { [self] newColor in
                cordedReceiverSecondaryColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseDisplayBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseDisplayBacklightColorHex)!
        } set: { [self] newColor in
                baseDisplayBacklightColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseKeyBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseKeyBacklightColorHex)!
        } set: { [self] newColor in
                baseKeyBacklightColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseKeyForegroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseKeyForegroundColorHex)!
        } set: { [self] newColor in
                baseKeyForegroundColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseKeyBackgroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseKeyBackgroundColorHex)!
        } set: { [self] newColor in
                baseKeyBackgroundColorHex = newColor.hex!
        }
    }
    
    @Transient
    var baseLEDMessageCounterColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: baseLEDMessageCounterColorHex)!
        } set: { [self] newColor in
        baseLEDMessageCounterColorHex = newColor.hex!
        }
    }
    
    // MARK: - Initialization

    init(brand: String, model: String, phoneDescription: String = String()) {
		self.brand = brand
		self.model = model
        self.phoneDescription = phoneDescription
	}
    
    // MARK: - Set Secondary Color to Main
    
    func setBaseSecondaryColorToMain() {
        baseSecondaryColorHex = baseMainColorHex
    }
    
    // MARK: - Property Change Handlers
    
    func supportsWiredHeadsetsChanged(oldValue: Bool, newValue: Bool) {
        if !newValue && musicOnHoldLive {
            musicOnHoldLive = false
        }
    }
    
    func numberOfLandlinesChanged(oldValue: Int, newValue: Int) {
        if newValue < 2 {
            for handset in cordlessHandsetsIHave {
                if handset.talkOffButtonType == 4 {
                    handset.talkOffButtonType = 1
                }
            }
        }
    }
	
	func transmitOnlyBaseChanged(oldValue: Bool, newValue: Bool) {
		if newValue {
			for handset in cordlessHandsetsIHave {
				handset.fitsOnBase = false
			}
            if maxCordlessHandsets == -1 {
                maxCordlessHandsets = 1
            }
            hasChargerSizeBase = false
			placeOnBaseAutoRegister = false
			baseHasSeparateDataContact = false
			baseChargeContactType = 0
			baseChargeContactPlacement = 0
			baseChargingDirection = 0
			if cordlessPowerBackupMode == 1 {
				cordlessPowerBackupMode = 0
			}
		}
	}
    
    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 && oldValue == -1 {
            releaseYear = 1892
        } else if newValue < 1892 {
            releaseYear = -1
        }
    }
	
	func isCordlessChanged(oldValue: Bool, newValue: Bool) {
		if newValue {
			cordedPhoneType = 0
			cordedRingerType = 1
		} else {
			if hasAnsweringSystem > 1 {
				hasAnsweringSystem = 1
			}
            hasIntercom = false
            baseIntercomRingtone = 0
			placeOnBaseAutoRegister = false
			hasTransmitOnlyBase = false
			supportsRangeExtenders = false
			baseChargingDirection = 0
			baseChargeContactType = 0
			baseChargeContactPlacement = 0
			baseHasSeparateDataContact = false
			cordlessHandsetsIHave.removeAll()
			chargersIHave.removeAll()
		}
	}
    
    func totalBaseRingtonesChanged(oldValue: Int, newValue: Int) {
        guard isCordless else { return }
        if newValue < oldValue && (baseIntercomRingtone >= (totalBaseRingtones + 1) || baseIntercomRingtone == 1) {
            baseIntercomRingtone -= 1
        }
    }
	
	func baseDisplayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
            if handsetRenaming == 2 {
                handsetRenaming = 1
            }
			hasTalkingPhonebook = false
            baseNavigatorKeyType = 0
            baseNavigatorKeyCenterButton = 0
            baseNavigatorKeyStandbyShortcuts = false
		}
		if newValue <= 1 {
			baseSoftKeysBottom = 0
			baseSoftKeysSide = 0
		}
		if newValue < 3 || newValue > 5 {
            baseDisplayBacklightColorHex = Color.white.hex!
		}
	}
    
    func baseNavigatorKeyTypeChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            baseNavigatorKeyCenterButton = 0
            baseNavigatorKeyUpDownVolume = false
            baseNavigatorKeyLeftRightRepeatSkip = false
            baseNavigatorKeyStandbyShortcuts = false
        }
    }
	
	func maxCordlessHandsetsChanged(oldValue: Int, newValue: Int) {
		if newValue == -1 {
            hasTransmitOnlyBase = false
            cordedReceiverMainColorBinding.wrappedValue = .clear
			placeOnBaseAutoRegister = false
			deregistration = 0
			locatorButtons = 0
			for handset in cordlessHandsetsIHave {
				handset.fitsOnBase = true
			}
		}
		if newValue == 0 && oldValue == -1 {
			maxCordlessHandsets = 1
		} else if newValue == 0 && oldValue == 1 {
			maxCordlessHandsets = -1
		}
	}
	
	func baseSoftKeysBottomChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue == 1 {
			baseSoftKeysBottom = 2
		} else if oldValue == 2 && newValue == 1 {
			baseSoftKeysBottom = 0
		}
	}
	
	func baseSoftKeysSideChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue == 1 {
			baseSoftKeysSide = 2
		} else if oldValue == 2 && newValue == 1 {
			baseSoftKeysSide = 0
		}
	}
    
    func hasBaseKeypadChanged(oldValue: Bool, newValue: Bool) {
        if newValue && hasChargerSizeBase {
            hasChargerSizeBase = false
        }
        if newValue && baseCellRingtone == 0 {
            baseCellRingtone = 1
        }
    }
    
    func hasBaseSpeakerphoneChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            hasBaseIntercom = true
        }
    }
	
	func cordlessPowerBackupModeChanged(oldValue: Int, newValue: Int) {
		if newValue != 1 {
			cordlessPowerBackupReturnBehavior = 0
		}
	}
	
	func locatorButtonsChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
			deregistration = 1
		}
	}
	
	func cordedReceiverColorChanged(oldValue: Color, newValue: Color) {
        if newValue != .clear {
			for handset in cordlessHandsetsIHave {
				handset.fitsOnBase = false
			}
            if maxCordlessHandsets == -1 {
                maxCordlessHandsets = 1
            }
			placeOnBaseAutoRegister = false
			hasTransmitOnlyBase = false
			baseChargingDirection = 0
			baseChargeContactType = 0
			baseChargeContactPlacement = 0
		}
	}
	
	func cordedPhoneTypeChanged(oldValue: Int, newValue: Int) {
		if newValue != 0 {
			hasBaseSpeakerphone = false
			hasTalkingKeypad = false
			hasTalkingPhonebook = false
			hasAnsweringSystem = 0
			baseMusicRingtones = 0
			basePhonebookCapacity = 0
			baseBluetoothHeadphonesSupported = 0
			baseBluetoothCellPhonesSupported = 0
			hasTalkingCallerID = false
		}
		if newValue == 1 || newValue == 3 {
			baseRedialCapacity = 0
			baseSpeedDialCapacity = 0
			baseCallerIDCapacity = 0
			baseDisplayType = 0
			baseSoftKeysSide = 0
			baseSoftKeysBottom = 0
			baseDisplayType = 0
		}
	}
	
	func cordedRingerTypeChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
			hasBaseSpeakerphone = false
			hasAnsweringSystem = 0
			baseRingtones = 0
			baseMusicRingtones = 0
			basePhonebookCapacity = 0
			baseCallerIDCapacity = 0
			baseBluetoothHeadphonesSupported = 0
			baseBluetoothCellPhonesSupported = 0
			hasTalkingCallerID = false
			hasTalkingKeypad = false
			hasTalkingPhonebook = false
		}
	}
	
	func deregistrationChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
			placeOnBaseAutoRegister = false
		}
	}
	
}
