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
	
	var cordedReceiverColor: String
	
	var numberOfIncludedCordlessHandsets: Int
	
	var maxCordlessHandsets: Int
	
	@Relationship(.cascade, inverse: \CordlessHandset.phone)
	var cordlessHandsetsIHave: [CordlessHandset]
	
	@Relationship(.cascade, inverse: \Charger.phone)
	var chargersIHave: [Charger]
	
	var handsetRingtones: Int
	
	var handsetMusicRingtones: Int
	
	var handsetHasSeparateIntercomTone: Bool
	
	var canChangeHandsetIntercomTone: Bool
	
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
	
	var answeringSystemMenuOnHandset: Int
	
	var answeringSystemMenuOnBase: Int
	
	var greetingRecordingOnBaseOrHandset: Int
	
	var hasMessageAlertByCall: Bool
	
	var hasGreetingOnlyMode: Bool
	
	var voicemailIndication: Int
	
	var voicemailQuickDial: Int
	
	var hasHandsetSpeakerphone: Bool
	
	var hasBaseSpeakerphone: Bool
	
	var hasBaseKeypad: Bool
	
	var hasTalkingCallerID: Bool
	
	var handsetDisplayType: Int
	
	var baseDisplayType: Int
	
	var cordedPowerSource: Int
	
	var cordlessPowerBackupMode: Int
	
	var baseSupportsWiredHeadsets: Bool
	
	var handsetSupportsWiredHeadsets: Bool
	
	var baseBluetoothHeadphonesSupported: Int
	
	var handsetBluetoothHeadphonesSupported: Int
	
	var baseBluetoothCellPhonesSupported: Int
	
	var hasCellPhoneVoiceControl: Bool
	
	var basePhonebookCapacity: Int
	
	var handsetPhonebookCapacity: Int
	
	var baseCallerIDCapacity: Int
	
	var handsetCallerIDCapacity: Int
	
	var baseRedialCapacity: Int
	
	var handsetRedialCapacity: Int
	
	var redialNameDisplay: Int
	
	var baseSpeedDialCapacity: Int
	
	var handsetSpeedDialCapacity: Int
	
	var hasSharedSpeedDial: Bool
	
	var handsetOneTouchDialCapacity: Int
	
	var baseOneTouchDialCapacity: Int
	
	var hasSharedOneTouchDial: Bool
	
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
	
	var hasSharedPhonebook: Bool {
		return isCordless && basePhonebookCapacity > 0 && handsetPhonebookCapacity == 0
	}
	
	var hasSharedCID: Bool {
		return isCordless && baseCallerIDCapacity > 0 && handsetCallerIDCapacity == 0
	}

	init(brand: String, model: String, photoData: Data, baseColor: String, cordedReceiverColor: String, numberOfIncludedCordlessHandsets: Int, maxCordlessHandsets: Int, cordlessHandsetsIHave: [CordlessHandset], chargersIHave: [Charger], handsetRingtones: Int, handsetMusicRingtones: Int, handsetHasSeparateIntercomTone: Bool, canChangeHandsetIntercomTone: Bool, baseRingtones: Int, baseMusicRingtones: Int, baseHasSeparateIntercomTone: Bool, canChangeBaseIntercomTone: Bool, hasIntercom: Bool, hasBaseIntercom: Bool, landlineInUseStatusOnBase: Int, cellLineInUseStatusOnBase: Int, reversibleHandset: Bool, hasAnsweringSystem: Int, answeringSystemMenuOnHandset: Int, answeringSystemMenuOnBase: Int, greetingRecordingOnBaseOrHandset: Int, hasMessageAlertByCall: Bool, hasGreetingOnlyMode: Bool, voicemailIndication: Int, voicemailQuickDial: Int, hasHandsetSpeakerphone: Bool, hasBaseSpeakerphone: Bool, hasBaseKeypad: Bool, hasTalkingCallerID: Bool, handsetDisplayType: Int, baseDisplayType: Int, cordedPowerSource: Int, cordlessPowerBackupMode: Int, baseSupportsWiredHeadsets: Bool, handsetSupportsWiredHeadsets: Bool, baseBluetoothHeadphonesSupported: Int, handsetBluetoothHeadphonesSupported: Int, baseBluetoothCellPhonesSupported: Int, hasCellPhoneVoiceControl: Bool, basePhonebookCapacity: Int, handsetPhonebookCapacity: Int, baseCallerIDCapacity: Int, handsetCallerIDCapacity: Int, baseRedialCapacity: Int, handsetRedialCapacity: Int, redialNameDisplay: Int, baseSpeedDialCapacity: Int, handsetSpeedDialCapacity: Int, hasSharedSpeedDial: Bool, handsetOneTouchDialCapacity: Int, baseOneTouchDialCapacity: Int, hasSharedOneTouchDial: Bool, oneTouchDialSupportsHandsetNumbers: Bool, speedDialPhonebookEntryMode: Int, callBlockCapacity: Int, callBlockSupportsPrefixes: Bool, blockedCallersHear: Int, hasFirstRingSuppression: Bool, hasOneTouchCallBlock: Bool, callBlockPreProgrammedDatabaseEntryCount: Int, callBlockPreScreening: Int, callBlockPreScreeningAllowedNameCapacity: Int, callBlockPreScreeningAllowedNumberCapacity: Int) {
		self.brand = brand
		self.model = model
		self.photoData = photoData
		self.baseColor = baseColor
		self.cordedReceiverColor = cordedReceiverColor
		self.numberOfIncludedCordlessHandsets = numberOfIncludedCordlessHandsets
		self.maxCordlessHandsets = maxCordlessHandsets
		self.cordlessHandsetsIHave = cordlessHandsetsIHave
		self.chargersIHave = chargersIHave
		self.handsetRingtones = handsetRingtones
		self.handsetMusicRingtones = handsetMusicRingtones
		self.handsetHasSeparateIntercomTone = handsetHasSeparateIntercomTone
		self.canChangeHandsetIntercomTone = canChangeHandsetIntercomTone
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
		self.answeringSystemMenuOnHandset = answeringSystemMenuOnHandset
		self.answeringSystemMenuOnBase = answeringSystemMenuOnBase
		self.greetingRecordingOnBaseOrHandset = greetingRecordingOnBaseOrHandset
		self.hasMessageAlertByCall = hasMessageAlertByCall
		self.hasGreetingOnlyMode = hasGreetingOnlyMode
		self.voicemailIndication = voicemailIndication
		self.voicemailQuickDial = voicemailQuickDial
		self.hasHandsetSpeakerphone = hasHandsetSpeakerphone
		self.hasBaseSpeakerphone = hasBaseSpeakerphone
		self.hasBaseKeypad = hasBaseKeypad
		self.hasTalkingCallerID = hasTalkingCallerID
		self.handsetDisplayType = handsetDisplayType
		self.baseDisplayType = baseDisplayType
		self.cordedPowerSource = cordedPowerSource
		self.cordlessPowerBackupMode = cordlessPowerBackupMode
		self.baseSupportsWiredHeadsets = baseSupportsWiredHeadsets
		self.handsetSupportsWiredHeadsets = handsetSupportsWiredHeadsets
		self.baseBluetoothHeadphonesSupported = baseBluetoothHeadphonesSupported
		self.handsetBluetoothHeadphonesSupported = handsetBluetoothHeadphonesSupported
		self.baseBluetoothCellPhonesSupported = baseBluetoothCellPhonesSupported
		self.hasCellPhoneVoiceControl = hasCellPhoneVoiceControl
		self.basePhonebookCapacity = basePhonebookCapacity
		self.handsetPhonebookCapacity = handsetPhonebookCapacity
		self.baseCallerIDCapacity = baseCallerIDCapacity
		self.handsetCallerIDCapacity = handsetCallerIDCapacity
		self.baseRedialCapacity = baseRedialCapacity
		self.handsetRedialCapacity = handsetRedialCapacity
		self.redialNameDisplay = redialNameDisplay
		self.baseSpeedDialCapacity = baseSpeedDialCapacity
		self.handsetSpeedDialCapacity = handsetSpeedDialCapacity
		self.hasSharedSpeedDial = hasSharedSpeedDial
		self.handsetOneTouchDialCapacity = handsetOneTouchDialCapacity
		self.baseOneTouchDialCapacity = baseOneTouchDialCapacity
		self.hasSharedOneTouchDial = hasSharedOneTouchDial
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
