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
	
	static var preview = Phone(brand: "Some Brand", model: "M123", photoData: Phone.previewPhotoData, baseColor: "Black", cordedReceiverColor: String(), numberOfIncludedCordlessHandsets: 2, maxCordlessHandsets: 5, cordlessHandsetsIHave: [], chargersIHave: [], handsetRingtones: 5, handsetMusicRingtones: 5, handsetHasSeparateIntercomTone: false, canChangeHandsetIntercomTone: true, baseRingtones: 1, baseMusicRingtones: 0, baseHasSeparateIntercomTone: false, canChangeBaseIntercomTone: false, hasBaseIntercom: false, landlineInUseStatusOnBase: 0, landlineInUseStatusOnHandset: 1, cellLineInUseStatusOnBase: 1, reversibleHandset: false, hasAnsweringSystem: 3, answeringSystemMenuOnHandset: 2, answeringSystemMenuOnBase: 0, greetingRecordingOnBaseOrHandset: 2, hasMessageAlertByCall: true, hasGreetingOnlyMode: true, indicatesNewVoicemail: true, hasVoicemailQuickDial: true, speedDial1IsReservedForVoicemail: false, hasHandsetSpeakerphone: true, hasBaseSpeakerphone: false, hasBaseKeypad: false, hasTalkingCallerID: true, handsetDisplayType: 1, baseDisplayType: 1, cordedPowerSource: 0, cordlessPowerBackupMode: 1, baseSupportsWiredHeadsets: false, handsetSupportsWiredHeadsets: true, baseSupportsBluetoothHeadphones: true, handsetSupportsBluetoothHeadphones: true, baseBluetoothCellPhonesSupported: 2, hasCellPhoneVoiceControl: true, basePhonebookCapacity: 7000, handsetPhonebookCapacity: 0, baseCallerIDCapacity: 7000, handsetCallerIDCapacity: 0, baseRedialCapacity: 0, handsetRedialCapacity: 5, baseSpeedDialCapacity: 0, handsetSpeedDialCapacity: 10, callBlockCapacity: 7000, callBlockSupportsPrefixes: true, blockedCallersHear: 3, hasOneTouchCallBlock: true, callBlockPreProgrammedDatabaseEntryCount: 20000, callBlockPreScreening: 2, callBlockPreScreeningAllowedNameCapacity: 100, callBlockPreScreeningAllowedNumberCapacity: 100)

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
	
	var hasBaseIntercom: Bool
	
	var landlineInUseStatusOnBase: Int
	
	var landlineInUseStatusOnHandset: Int
	
	var cellLineInUseStatusOnBase: Int
	
	var reversibleHandset: Bool
	
	var hasAnsweringSystem: Int
	
	var answeringSystemMenuOnHandset: Int
	
	var answeringSystemMenuOnBase: Int
	
	var greetingRecordingOnBaseOrHandset: Int
	
	var hasMessageAlertByCall: Bool
	
	var hasGreetingOnlyMode: Bool
	
	var indicatesNewVoicemail: Bool
	
	var hasVoicemailQuickDial: Bool
	
	var speedDial1IsReservedForVoicemail: Bool
	
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
	
	var baseSupportsBluetoothHeadphones: Bool
	
	var handsetSupportsBluetoothHeadphones: Bool
	
	var baseBluetoothCellPhonesSupported: Int
	
	var hasCellPhoneVoiceControl: Bool
	
	var basePhonebookCapacity: Int
	
	var handsetPhonebookCapacity: Int
	
	var baseCallerIDCapacity: Int
	
	var handsetCallerIDCapacity: Int
	
	var baseRedialCapacity: Int
	
	var handsetRedialCapacity: Int
	
	var baseSpeedDialCapacity: Int
	
	var handsetSpeedDialCapacity: Int
	
	var callBlockCapacity: Int
	
	var callBlockSupportsPrefixes: Bool
	
	var blockedCallersHear: Int
	
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

	init(brand: String, model: String, photoData: Data, baseColor: String, cordedReceiverColor: String, numberOfIncludedCordlessHandsets: Int, maxCordlessHandsets: Int, cordlessHandsetsIHave: [CordlessHandset], chargersIHave: [Charger], handsetRingtones: Int, handsetMusicRingtones: Int, handsetHasSeparateIntercomTone: Bool, canChangeHandsetIntercomTone: Bool, baseRingtones: Int, baseMusicRingtones: Int, baseHasSeparateIntercomTone: Bool, canChangeBaseIntercomTone: Bool, hasBaseIntercom: Bool, landlineInUseStatusOnBase: Int, landlineInUseStatusOnHandset: Int, cellLineInUseStatusOnBase: Int, reversibleHandset: Bool, hasAnsweringSystem: Int, answeringSystemMenuOnHandset: Int, answeringSystemMenuOnBase: Int, greetingRecordingOnBaseOrHandset: Int, hasMessageAlertByCall: Bool, hasGreetingOnlyMode: Bool, indicatesNewVoicemail: Bool, hasVoicemailQuickDial: Bool, speedDial1IsReservedForVoicemail: Bool, hasHandsetSpeakerphone: Bool, hasBaseSpeakerphone: Bool, hasBaseKeypad: Bool, hasTalkingCallerID: Bool, handsetDisplayType: Int, baseDisplayType: Int, cordedPowerSource: Int, cordlessPowerBackupMode: Int, baseSupportsWiredHeadsets: Bool, handsetSupportsWiredHeadsets: Bool, baseSupportsBluetoothHeadphones: Bool, handsetSupportsBluetoothHeadphones: Bool, baseBluetoothCellPhonesSupported: Int, hasCellPhoneVoiceControl: Bool, basePhonebookCapacity: Int, handsetPhonebookCapacity: Int, baseCallerIDCapacity: Int, handsetCallerIDCapacity: Int, baseRedialCapacity: Int, handsetRedialCapacity: Int, baseSpeedDialCapacity: Int, handsetSpeedDialCapacity: Int, callBlockCapacity: Int, callBlockSupportsPrefixes: Bool, blockedCallersHear: Int, hasOneTouchCallBlock: Bool, callBlockPreProgrammedDatabaseEntryCount: Int, callBlockPreScreening: Int, callBlockPreScreeningAllowedNameCapacity: Int, callBlockPreScreeningAllowedNumberCapacity: Int) {
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
		self.hasBaseIntercom = hasBaseIntercom
		self.landlineInUseStatusOnBase = landlineInUseStatusOnBase
		self.landlineInUseStatusOnHandset = landlineInUseStatusOnHandset
		self.cellLineInUseStatusOnBase = cellLineInUseStatusOnBase
		self.reversibleHandset = reversibleHandset
		self.hasAnsweringSystem = hasAnsweringSystem
		self.answeringSystemMenuOnHandset = answeringSystemMenuOnHandset
		self.answeringSystemMenuOnBase = answeringSystemMenuOnBase
		self.greetingRecordingOnBaseOrHandset = greetingRecordingOnBaseOrHandset
		self.hasMessageAlertByCall = hasMessageAlertByCall
		self.hasGreetingOnlyMode = hasGreetingOnlyMode
		self.indicatesNewVoicemail = indicatesNewVoicemail
		self.hasVoicemailQuickDial = hasVoicemailQuickDial
		self.speedDial1IsReservedForVoicemail = speedDial1IsReservedForVoicemail
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
		self.baseSupportsBluetoothHeadphones = baseSupportsBluetoothHeadphones
		self.handsetSupportsBluetoothHeadphones = handsetSupportsBluetoothHeadphones
		self.baseBluetoothCellPhonesSupported = baseBluetoothCellPhonesSupported
		self.hasCellPhoneVoiceControl = hasCellPhoneVoiceControl
		self.basePhonebookCapacity = basePhonebookCapacity
		self.handsetPhonebookCapacity = handsetPhonebookCapacity
		self.baseCallerIDCapacity = baseCallerIDCapacity
		self.handsetCallerIDCapacity = handsetCallerIDCapacity
		self.baseRedialCapacity = baseRedialCapacity
		self.handsetRedialCapacity = handsetRedialCapacity
		self.baseSpeedDialCapacity = baseSpeedDialCapacity
		self.handsetSpeedDialCapacity = handsetSpeedDialCapacity
		self.callBlockCapacity = callBlockCapacity
		self.callBlockSupportsPrefixes = callBlockSupportsPrefixes
		self.blockedCallersHear = blockedCallersHear
		self.hasOneTouchCallBlock = hasOneTouchCallBlock
		self.callBlockPreProgrammedDatabaseEntryCount = callBlockPreProgrammedDatabaseEntryCount
		self.callBlockPreScreening = callBlockPreScreening
		self.callBlockPreScreeningAllowedNameCapacity = callBlockPreScreeningAllowedNameCapacity
		self.callBlockPreScreeningAllowedNumberCapacity = callBlockPreScreeningAllowedNumberCapacity
	}

}
