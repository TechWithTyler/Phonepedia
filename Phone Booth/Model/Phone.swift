//
//  Phone.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Phone {
	
	static var previewPhotoData: Data {
#if os(iOS) || os(xrOS)
		return getPNGDataFromUIImage(image: .phone)
#elseif os(macOS)
		return getPNGDataFromNSImage(image: .phone)
#endif
	}

	var brand: String

	var model: String

	var photoData: Data

	var releaseYear: Int

	var baseColor: String

	var baseDisplayBacklightColor: String

	var baseKeyForegroundColor: String

	var baseKeyBackgroundColor: String

	var locatorButtons: Int

	var deregistration: Int

	var buttonType: Int

	var chargeLight: Int

	var cordedReceiverColor: String

	var cordedPhoneType: Int

	var cordedRingerType: Int

	var numberOfIncludedCordlessHandsets: Int

	var maxCordlessHandsets: Int

	var supportsRangeExtenders: Bool

	var hasTransmitOnlyBase: Bool

	var frequency: Int

	@Relationship(deleteRule: .cascade, inverse: \CordlessHandset.phone)
	var cordlessHandsetsIHave: [CordlessHandset]

	@Relationship(deleteRule: .cascade, inverse: \Charger.phone)
	var chargersIHave: [Charger]

	var baseRingtones: Int

	var baseMusicRingtones: Int

	var baseHasSeparateIntercomTone: Bool

	var canChangeBaseIntercomTone: Bool

	var hasIntercom: Bool

	var hasBaseIntercom: Bool

	var numberOfLandlines: Int

	var landlineInUseStatusOnBase: Int

	var landlineInUseVisualRingerFollowsRingSignal: Bool

	var cellLineInUseStatusOnBase: Int

	var cellLineOnlyBehavior: Int

	var baseChargingDirection: Int

	var baseHasSeparateDataContact: Bool

	var baseChargeContactPlacement: Int

	var baseChargeContactMechanism: Int

	var hasAnsweringSystem: Int

	var answeringSystemMenuOnBase: Int

	var greetingRecordingOnBaseOrHandset: Int

	var hasMessageAlertByCall: Bool

	var hasGreetingOnlyMode: Bool

	var voicemailIndication: Int

	var voicemailQuickDial: Int

	var hasBaseSpeakerphone: Bool

	var hasBaseKeypad: Bool

	var hasTalkingCallerID: Bool

	var hasTalkingKeypad: Bool

	var hasTalkingPhonebook: Bool

	var baseDisplayType: Int

	var baseHasDisplayAndMessageCounter: Bool

	var baseSoftKeysBottom: Int

	var baseSoftKeysSide: Int

	var baseNavigatorKeyType: Int

	var baseNavigatorKeyStandbyShortcuts: Bool

	var baseNavigatorKeyCenterButton: Int

	var baseNavigatorKeyLeftRightRepeatSkip: Bool

	var baseNavigatorKeyUpDownVolume: Bool

	var baseLEDMessageCounterColor: String

	var baseKeyBacklightColor: String

	var baseKeyBacklightAmount: Int

	var cordedPowerSource: Int

	var cordlessPowerBackupMode: Int

	var cordlessPowerBackupReturnBehavior: Int

	var baseSupportsWiredHeadsets: Bool

	var baseBluetoothHeadphonesSupported: Int

	var baseBluetoothCellPhonesSupported: Int

	var bluetoothPhonebookTransfers: Int

	var hasCellPhoneVoiceControl: Bool

	var basePhonebookCapacity: Int

	var baseCallerIDCapacity: Int

	var baseRedialCapacity: Int

	var redialNameDisplay: Int

	var callerIDPhonebookMatch: Bool

	var baseSpeedDialCapacity: Int

	var baseOneTouchDialCapacity: Int

	var oneTouchDialSupportsHandsetNumbers: Bool

	var speedDialPhonebookEntryMode: Int

	var callBlockCapacity: Int

	var callBlockSupportsPrefixes: Bool

	var blockedCallersHear: Int

	var hasFirstRingSuppression: Bool

	var hasOneTouchCallBlock: Bool

	var callBlockPreProgrammedDatabaseEntryCount: Int

	var callBlockPreScreening: Int

	var callBlockPreScreeningCustomGreeting: Bool

	var callBlockPreScreeningAllowedNameCapacity: Int

	var callBlockPreScreeningAllowedNumberCapacity: Int

	var callBlockPreScreeningAllowedNumberListVisible: Bool

	var roomMonitor: Int

	var externalRoomMonitorAutomatedSystem: Int

	var smartHomeDevicesSupported: Int

	var answerByVoice: Bool

	var smartphonesAsHandsetsOverWiFi: Int

	var scamCallDetection: Bool

	var placeOnBaseAutoRegister: Bool

	var wallMountability: Int

	var antennas: Int

	var phoneTypeText: String {
		if isCordedCordless {
			return "Corded/Cordless"
		} else if isCordless {
			if hasTransmitOnlyBase {
				return "Cordless with Transmit-Only Base"
			}
			return "Cordless"
		} else {
			return "Corded"
		}
	}

	var hasCordedReceiver: Bool {
		return !cordedReceiverColor.isEmpty
	}

	var isCordless: Bool {
		return numberOfIncludedCordlessHandsets > 0
	}

	var isCordedCordless: Bool {
		return isCordless && hasCordedReceiver
	}

	init(brand: String, model: String) {
		self.brand = brand
		self.model = model
		self.photoData = Phone.previewPhotoData
		self.baseColor = String()
		self.baseKeyForegroundColor = String()
		self.baseKeyBackgroundColor = String()
		self.buttonType = 0
		self.cordedReceiverColor = String()
		self.numberOfIncludedCordlessHandsets = 1
		self.maxCordlessHandsets = 5
		self.frequency = 25
		self.cordlessHandsetsIHave = []
		self.chargersIHave = []
		self.baseRingtones = 1
		self.baseMusicRingtones = 0
		self.baseHasSeparateIntercomTone = false
		self.canChangeBaseIntercomTone = false
		self.hasIntercom = true
		self.hasBaseIntercom = false
		self.landlineInUseStatusOnBase = 0
		self.cellLineInUseStatusOnBase = 0
		self.baseChargingDirection = 0
		self.baseHasSeparateDataContact = false
		self.baseChargeContactPlacement = 0
		self.baseChargeContactMechanism = 1
		self.hasAnsweringSystem = 3
		self.answeringSystemMenuOnBase = 0
		self.greetingRecordingOnBaseOrHandset = 1
		self.hasMessageAlertByCall = false
		self.hasGreetingOnlyMode = true
		self.voicemailIndication = 3
		self.voicemailQuickDial = 3
		self.hasBaseSpeakerphone = false
		self.hasBaseKeypad = false
		self.hasTalkingCallerID = false
		self.baseDisplayType = 1
		self.baseHasDisplayAndMessageCounter = false
		self.baseSoftKeysBottom = 0
		self.baseSoftKeysSide = 0
		self.baseNavigatorKeyType = 0
		self.baseNavigatorKeyStandbyShortcuts = false
		self.baseNavigatorKeyCenterButton = 0
		self.baseNavigatorKeyLeftRightRepeatSkip = false
		self.baseNavigatorKeyUpDownVolume = false
		self.baseLEDMessageCounterColor = String()
		self.baseDisplayBacklightColor = String()
		self.baseKeyBacklightColor = String()
		self.baseKeyBacklightAmount = 0
		self.cordedPowerSource = 0
		self.cordlessPowerBackupMode = 1
		self.baseSupportsWiredHeadsets = false
		self.baseBluetoothHeadphonesSupported = 0
		self.baseBluetoothCellPhonesSupported = 0
		self.hasCellPhoneVoiceControl = false
		self.basePhonebookCapacity = 100
		self.baseCallerIDCapacity = 100
		self.baseRedialCapacity = 0
		self.redialNameDisplay = 0
		self.baseSpeedDialCapacity = 0
		self.baseOneTouchDialCapacity = 0
		self.oneTouchDialSupportsHandsetNumbers = false
		self.speedDialPhonebookEntryMode = 0
		self.callBlockCapacity = 20
		self.callBlockSupportsPrefixes = false
		self.blockedCallersHear = 0
		self.hasFirstRingSuppression = true
		self.hasOneTouchCallBlock = false
		self.callBlockPreProgrammedDatabaseEntryCount = 0
		self.callBlockPreScreening = 0
		self.callBlockPreScreeningAllowedNameCapacity = 0
		self.callBlockPreScreeningAllowedNumberCapacity = 0
		self.supportsRangeExtenders = false
		self.hasTransmitOnlyBase = false
		self.callBlockPreScreeningCustomGreeting = false
		self.callBlockPreScreeningAllowedNumberListVisible = false
		self.callerIDPhonebookMatch = true
		self.chargeLight = 3
		self.landlineInUseVisualRingerFollowsRingSignal = false
		self.cellLineOnlyBehavior = 0
		self.numberOfLandlines = 1
		self.cordlessPowerBackupReturnBehavior = 0
		self.bluetoothPhonebookTransfers = 0
		self.locatorButtons = 0
		self.deregistration = 1
		self.roomMonitor = 0
		self.externalRoomMonitorAutomatedSystem = 0
		self.smartHomeDevicesSupported = 0
		self.answerByVoice = false
		self.cordedPhoneType = 0
		self.cordedRingerType = 1
		self.smartphonesAsHandsetsOverWiFi = 0
		self.releaseYear = currentYear
		self.scamCallDetection = false
		self.placeOnBaseAutoRegister = false
		self.wallMountability = 2
		self.antennas = 0
		self.hasTalkingKeypad = false
		self.hasTalkingPhonebook = false
	}

	func transmitOnlyBaseChanged(oldValue: Bool, newValue: Bool) {
		if newValue {
			for handset in cordlessHandsetsIHave {
				handset.fitsOnBase = false
			}
			placeOnBaseAutoRegister = false
			baseHasSeparateDataContact = false
			baseChargeContactMechanism = 0
			baseChargeContactPlacement = 0
			baseChargingDirection = 0
			if cordlessPowerBackupMode == 1 {
				cordlessPowerBackupMode = 0
			}
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
			placeOnBaseAutoRegister = false
			hasTransmitOnlyBase = false
			supportsRangeExtenders = false
			baseChargingDirection = 0
			baseChargeContactMechanism = 0
			baseChargeContactPlacement = 0
			baseHasSeparateDataContact = false
			cordlessHandsetsIHave.removeAll()
			chargersIHave.removeAll()
		}
	}

	func baseDisplayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue == 0 {
			hasTalkingPhonebook = false
		}
		if newValue <= 1 {
			baseSoftKeysBottom = 0
			baseSoftKeysSide = 0
		}
		if newValue < 3 || newValue > 5 {
			baseDisplayBacklightColor = String()
		}
	}

	func maxCordlessHandsetsChanged(oldValue: Int, newValue: Int) {
		if newValue == -1 {
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

	func baseBluetoothCellPhonesSupportedChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue > 0 {
			bluetoothPhonebookTransfers = 1
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

	func cordedReceiverColorChanged(oldValue: String, newValue: String) {
		if !newValue.isEmpty {
			for handset in cordlessHandsetsIHave {
				handset.fitsOnBase = false
			}
			placeOnBaseAutoRegister = false
			hasTransmitOnlyBase = false
			baseChargingDirection = 0
			baseChargeContactMechanism = 0
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
