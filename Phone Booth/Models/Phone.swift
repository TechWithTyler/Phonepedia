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

	var diamondCutKeys: Int

	var cordedReceiverColor: String
	
	var numberOfIncludedCordlessHandsets: Int
	
	var maxCordlessHandsets: Int
	
	@Relationship(.cascade, inverse: \CordlessHandset.phone)
	var cordlessHandsetsIHave: [CordlessHandset]
	
	@Relationship(.cascade, inverse: \Charger.phone)
	var chargersIHave: [Charger]

	var baseRingtones: Int
	
	var baseMusicRingtones: Int
	
	var baseHasSeparateIntercomTone: Bool
	
	var canChangeBaseIntercomTone: Bool
	
	var hasIntercom: Bool
	
	var hasBaseIntercom: Bool
	
	var landlineInUseStatusOnBase: Int
	
	var cellLineInUseStatusOnBase: Int
	
	var reversibleHandset: Bool
	
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

	var baseSoftKeys: Int

	var baseLEDMessageCounterColor: String

	var baseDisplayBacklightColor: String

	var baseKeyBacklightColor: String

	var baseKeyBacklightAmount: Int

	var cordedPowerSource: Int
	
	var cordlessPowerBackupMode: Int
	
	var baseSupportsWiredHeadsets: Bool
	
	var baseBluetoothHeadphonesSupported: Int
	
	var baseBluetoothCellPhonesSupported: Int
	
	var hasCellPhoneVoiceControl: Bool
	
	var basePhonebookCapacity: Int
	
	var baseCallerIDCapacity: Int
	
	var baseRedialCapacity: Int

	var redialNameDisplay: Int
	
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
	
	var callBlockPreScreeningAllowedNameCapacity: Int
	
	var callBlockPreScreeningAllowedNumberCapacity: Int
	
	var hasCordedReceiver: Bool {
		return !cordedReceiverColor.isEmpty
	}
	
	var isCordless: Bool {
		return numberOfIncludedCordlessHandsets > 0
	}
	
	var isCordedCordless: Bool {
		return isCordless && hasCordedReceiver
	}

	init(brand: String, model: String, photoData: Data, baseColor: String, baseKeyForegroundColor: String, baseKeyBackgroundColor: String, diamondCutKeys: Int, cordedReceiverColor: String, numberOfIncludedCordlessHandsets: Int, maxCordlessHandsets: Int, cordlessHandsetsIHave: [CordlessHandset], chargersIHave: [Charger], baseRingtones: Int, baseMusicRingtones: Int, baseHasSeparateIntercomTone: Bool, canChangeBaseIntercomTone: Bool, hasIntercom: Bool, hasBaseIntercom: Bool, landlineInUseStatusOnBase: Int, cellLineInUseStatusOnBase: Int, reversibleHandset: Bool, hasAnsweringSystem: Int, answeringSystemMenuOnBase: Int, greetingRecordingOnBaseOrHandset: Int, hasMessageAlertByCall: Bool, hasGreetingOnlyMode: Bool, voicemailIndication: Int, voicemailQuickDial: Int, hasBaseSpeakerphone: Bool, hasBaseKeypad: Bool, hasTalkingCallerID: Bool, baseDisplayType: Int, baseHasDisplayAndMessageCounter: Bool, baseSoftKeys: Int, baseLEDMessageCounterColor: String, baseDisplayBacklightColor: String, baseKeyBacklightColor: String, baseKeyBacklightAmount: Int, cordedPowerSource: Int, cordlessPowerBackupMode: Int, baseSupportsWiredHeadsets: Bool, baseBluetoothHeadphonesSupported: Int, baseBluetoothCellPhonesSupported: Int, hasCellPhoneVoiceControl: Bool, basePhonebookCapacity: Int, baseCallerIDCapacity: Int, baseRedialCapacity: Int, redialNameDisplay: Int, baseSpeedDialCapacity: Int, baseOneTouchDialCapacity: Int, oneTouchDialSupportsHandsetNumbers: Bool, speedDialPhonebookEntryMode: Int, callBlockCapacity: Int, callBlockSupportsPrefixes: Bool, blockedCallersHear: Int, hasFirstRingSuppression: Bool, hasOneTouchCallBlock: Bool, callBlockPreProgrammedDatabaseEntryCount: Int, callBlockPreScreening: Int, callBlockPreScreeningAllowedNameCapacity: Int, callBlockPreScreeningAllowedNumberCapacity: Int) {
		self.brand = brand
		self.model = model
		self.photoData = photoData
		self.baseColor = baseColor
		self.baseKeyForegroundColor = baseKeyForegroundColor
		self.baseKeyBackgroundColor = baseKeyBackgroundColor
		self.diamondCutKeys = diamondCutKeys
		self.cordedReceiverColor = cordedReceiverColor
		self.numberOfIncludedCordlessHandsets = numberOfIncludedCordlessHandsets
		self.maxCordlessHandsets = maxCordlessHandsets
		self.cordlessHandsetsIHave = cordlessHandsetsIHave
		self.chargersIHave = chargersIHave
		self.baseRingtones = baseRingtones
		self.baseMusicRingtones = baseMusicRingtones
		self.baseHasSeparateIntercomTone = baseHasSeparateIntercomTone
		self.canChangeBaseIntercomTone = canChangeBaseIntercomTone
		self.hasIntercom = hasIntercom
		self.hasBaseIntercom = hasBaseIntercom
		self.landlineInUseStatusOnBase = landlineInUseStatusOnBase
		self.cellLineInUseStatusOnBase = cellLineInUseStatusOnBase
		self.reversibleHandset = reversibleHandset
		self.hasAnsweringSystem = hasAnsweringSystem
		self.answeringSystemMenuOnBase = answeringSystemMenuOnBase
		self.greetingRecordingOnBaseOrHandset = greetingRecordingOnBaseOrHandset
		self.hasMessageAlertByCall = hasMessageAlertByCall
		self.hasGreetingOnlyMode = hasGreetingOnlyMode
		self.voicemailIndication = voicemailIndication
		self.voicemailQuickDial = voicemailQuickDial
		self.hasBaseSpeakerphone = hasBaseSpeakerphone
		self.hasBaseKeypad = hasBaseKeypad
		self.hasTalkingCallerID = hasTalkingCallerID
		self.baseDisplayType = baseDisplayType
		self.baseHasDisplayAndMessageCounter = baseHasDisplayAndMessageCounter
		self.baseSoftKeys = baseSoftKeys
		self.baseLEDMessageCounterColor = baseLEDMessageCounterColor
		self.baseDisplayBacklightColor = baseDisplayBacklightColor
		self.baseKeyBacklightColor = baseKeyBacklightColor
		self.baseKeyBacklightAmount = baseKeyBacklightAmount
		self.cordedPowerSource = cordedPowerSource
		self.cordlessPowerBackupMode = cordlessPowerBackupMode
		self.baseSupportsWiredHeadsets = baseSupportsWiredHeadsets
		self.baseBluetoothHeadphonesSupported = baseBluetoothHeadphonesSupported
		self.baseBluetoothCellPhonesSupported = baseBluetoothCellPhonesSupported
		self.hasCellPhoneVoiceControl = hasCellPhoneVoiceControl
		self.basePhonebookCapacity = basePhonebookCapacity
		self.baseCallerIDCapacity = baseCallerIDCapacity
		self.baseRedialCapacity = baseRedialCapacity
		self.redialNameDisplay = redialNameDisplay
		self.baseSpeedDialCapacity = baseSpeedDialCapacity
		self.baseOneTouchDialCapacity = baseOneTouchDialCapacity
		self.oneTouchDialSupportsHandsetNumbers = oneTouchDialSupportsHandsetNumbers
		self.speedDialPhonebookEntryMode = speedDialPhonebookEntryMode
		self.callBlockCapacity = callBlockCapacity
		self.callBlockSupportsPrefixes = callBlockSupportsPrefixes
		self.blockedCallersHear = blockedCallersHear
		self.hasFirstRingSuppression = hasFirstRingSuppression
		self.hasOneTouchCallBlock = hasOneTouchCallBlock
		self.callBlockPreProgrammedDatabaseEntryCount = callBlockPreProgrammedDatabaseEntryCount
		self.callBlockPreScreening = callBlockPreScreening
		self.callBlockPreScreeningAllowedNameCapacity = callBlockPreScreeningAllowedNameCapacity
		self.callBlockPreScreeningAllowedNumberCapacity = callBlockPreScreeningAllowedNumberCapacity
	}

}
