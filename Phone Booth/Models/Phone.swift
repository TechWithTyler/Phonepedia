//
//  Phone.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Phone {
	
	static var previewPhotoData: Data {
#if os(iOS) || os(xrOS)
		return getPNGDataFromUIImage(image: UIImage(named: "phone")!)
#elseif os(macOS)
		return getPNGDataFromNSImage(image: NSImage(named: "phone")!)
#endif
	}
	
	var brand: String
	
	var model: String
	
	var photoData: Data
	
	var baseColor: String

	var baseKeyForegroundColor: String

	var baseKeyBackgroundColor: String

	var buttonType: Int

	var chargeLight: Int

	var cordedReceiverColor: String
	
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

	var baseDisplayBacklightColor: String

	var baseKeyBacklightColor: String

	var baseKeyBacklightAmount: Int

	var cordedPowerSource: Int
	
	var cordlessPowerBackupMode: Int

	var cordlessPowerBackupReturnBehavior: Int

	var baseSupportsWiredHeadsets: Bool
	
	var baseBluetoothHeadphonesSupported: Int
	
	var baseBluetoothCellPhonesSupported: Int
	
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
	}

}
