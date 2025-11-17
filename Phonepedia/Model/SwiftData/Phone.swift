//
//  Phone.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI
import SwiftData

// The structure of a SwiftData model class is very simple--a Swift class with @Model before its declaration. Any property not marked with @Transient is a persistent property which will be stored to the underlying Core Data persistent store SQLite file. @Model does 2 things: makes this class conform to PersistentModel and Observable, and internally adds @_PersistedProperty to the beginning of persistent properties.
// A final class is a class that can't be subclassed.
@Model
final class Phone {

    // MARK: - Properties - Mock Phone

    @Transient
    static let mockPhone: Phone = Phone(brand: Phone.mockBrand, model: Phone.mockModel)

    // MARK: - Properties - Default Data

    // Properties marked with the @Transient property wrapper won't persist their values to SwiftData.
    @Transient
    static let mockBrand: String = "Some Brand"

    @Transient
    static let mockModel: String = "M123-2"

    // MARK: - Properties - Persistent Data

    // At least one property should be created without a default value, being assigned the default in init(), to reduce performance issues.
    var brand: String

    var model: String

    // There must be one or more properties declared with an initial value for automatic (lightweight) migration to work.
    var nickname: String = String()

    var phoneNumberInCollection: Int = 0

    // Use @Attribute(_:) to specify an attribute for a SwiftData property.
    @Attribute(.externalStorage) var photoData: Data? = nil

    var releaseYear: Int = currentYear

    var acquisitionYear: Int = currentYear

    var whereAcquired: Int = 0

    var basePhoneType: Int = 0

    var mainHandsetModel: String = "MH12"

    var baseMainColorRed: Double = 0

    var baseMainColorGreen: Double = 0

    var baseMainColorBlue: Double = 0

    var baseSecondaryColorRed: Double = 0

    var baseSecondaryColorGreen: Double = 0

    var baseSecondaryColorBlue: Double = 0

    var baseAccentColorRed: Double = 0

    var baseAccentColorGreen: Double = 0

    var baseAccentColorBlue: Double = 0

    var baseDisplayBacklightColorRed: Double = 255

    var baseDisplayBacklightColorGreen: Double = 255

    var baseDisplayBacklightColorBlue: Double = 255

    var baseDisplayBacklightColorAlpha: Double = 1

    var baseKeyForegroundColorRed: Double = 255

    var baseKeyForegroundColorGreen: Double = 255

    var baseKeyForegroundColorBlue: Double = 255

    var baseKeyBackgroundColorRed: Double = 0

    var baseKeyBackgroundColorGreen: Double = 0

    var baseKeyBackgroundColorBlue: Double = 0

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

    var baseLEDMessageCounterColorRed: Double = 255

    var baseLEDMessageCounterColorGreen: Double = 0

    var baseLEDMessageCounterColorBlue: Double = 0

    var baseKeyBacklightColorRed: Double = 0

    var baseKeyBacklightColorGreen: Double = 255

    var baseKeyBacklightColorBlue: Double = 0

    var chargeLightColorChargingRed: Double = 255

    var chargeLightColorChargingGreen: Double = 0

    var chargeLightColorChargingBlue: Double = 0

    var chargeLightColorChargedRed: Double = 0

    var chargeLightColorChargedGreen: Double = 255

    var chargeLightColorChargedBlue: Double = 0

    var chargeLightColorChargedAlpha: Double = 1

    var hasChargeLight: Bool = false

    var cordedReceiverEarpieceType: Int = 0

    var baseBackupBatteryType: Int = 0

    var locatorButtons: Int = 0

    var locatorButtonLocation: Int = 0

    var handsetLocatorUsesIntercom: Bool = false

    var deregistration: Int = 2

    var buttonType: Int = 0

    var hasRotaryInspiredButtonLayout: Bool = false

    var answeringSystemSwitches: Bool = false

    var baseSpeakerVolumeAdjustmentType: Int = 1

    var cordedReceiverVolumeAdjustmentType: Int = 1

    var hasHardWiredCordedReceiver: Bool = false

    var hasHardWiredLineCord: Bool = false

    var baseRingerVolumeAdjustmentType: Int = 1

    var baseSupportsRingerOff: Bool = true

    var dialMode: Int = 2

    var clock: Int = 0

    var callerIDTimeAdjust: Bool = true

    var cordedPhoneType: Int = 0

    var isPayphone: Bool = false

    var cordedPhoneHasClockRadioAlarm: Bool = false

    var cordedReceiverHookType: Int = 2

    var cordlessHandsetLayDownHookType: Int = 0

    var hasDualReceivers: Bool = false

    var dialLocation: Int = 1

    var switchHookType: Int = 0

    var cordedRingerType: Int = 0

    var cordedRingerLocation: Int = 0

    var numberOfIncludedCordlessHandsets: Int = 2

    var handsetNumberDigit: Int? = 2

    var handsetNumberDigitIndex: Int? = 5

    var maxCordlessHandsets: Int = 5

    var supportsRangeExtenders: Bool = false

    var holdForOutOfRange: Bool = false

    var hasTransmitOnlyBase: Bool = false

    var ecoMode: Int = 0

    var frequency: Double = CordlessFrequency.northAmericaDECT6.rawValue

    var baseTransmitThroughPowerLine: Bool = false

    var hasNoLineAlert: Bool = false

    // Use @Relationship(deleteRule:inverse:) to define a relationship between a property and its type. The type of an @Relationship property must contain an Optional property of this object's type. In this case, a relationship is established between a CordlessHandset and its corresponding Phone.
    // This is a one-to-many relationship--each Phone can have multiple CordlessHandsets but each CordlessHandset can only be assigned to one Phone.
    @Relationship(deleteRule: .cascade, inverse: \CordlessHandset.phone)
    var cordlessHandsetsIHave: [CordlessHandset] = []

    @Relationship(deleteRule: .cascade, inverse: \CordlessHandsetCharger.phone)
    var chargersIHave: [CordlessHandsetCharger] = []

    var baseRingtones: Int = 1

    var baseMusicRingtones: Int = 0

    var baseIntercomRingtone: Int = 0

    var silentMode: Int = 0

    var supportsSilentModeBypass: Bool = false

    var hasIntercom: Bool = true

    var callTransferType: Int = 1

    var callPrivacyMode: Int = 0

    var hasBaseIntercom: Bool = false

    var intercomAutoAnswer: Int = 0

    var pushToTalkOrBroadcastToAll: Int = 0

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

    var answeringSystemType: Int = 1

    var remoteAccessCodeType: Int = 2

    var remoteAccessCodeCommonToAllLines: Bool = false

    var answeringSystemMessageTimestamp: Int = 2

    var hasMessageList: Bool = false

    var answeringSystemMultilineButtonLayout: Int = 0

    var answeringSystemForCellLines: Bool = false

    var hasCallRecording: Int = 0

    var answeringSystemMenuOnBase: Int = 0

    var greetingRecordingOnBaseOrHandset: Int = 1

    var greetingSlotsAndSchedules: Bool = false

    var hasMessageAlertByCall: Bool = false

    var canRecordVoiceMemos: Bool = false

    var numberOfMailboxes: Int = 1

    var hasAutoAttendantAndPersonalMailboxes: Bool = false

    var hasGreetingOnlyMode: Bool = true

    var voicemailIndication: Int = 3

    var voicemailQuickDial: Int = 0

    var voicemailFeatureCodes: Bool = false

    var hasBaseSpeakerphone: Bool = false

    var hasPickUpToSwitch: Bool = true

    var dialWithBaseDuringHandsetCall: Bool = false

    var handsetToBaseCallPickupBehavior: Int = 2

    var hasBaseKeypad: Bool = false

    var hasKeypadLock: Bool = false

    var hasTalkingCallerID: Bool = false

    var hasTalkingKeypad: Bool = false

    var hasTalkingPhonebook: Bool = false

    var baseDisplayType: Int = 0

    var cordlessBaseMenuType: Int = 0

    var baseDisplayCanTilt: Bool = false

    var baseMenuMultiItems: Bool = false

    var baseDisplayMultiEntries: Bool = false

    var baseMainMenuLayout: Int = 0

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

    var baseKeyBacklightLayer: Int = 0

    var cordedPowerSource: Int = 0

    var cordlessPowerBackupMode: Int = 0

    var cordedFunctionalityOnBackupBatteries: Int = 1

    var cordlessPowerBackupReturnBehavior: Int = 0

    var baseSupportsWiredHeadsets: Bool = false

    var baseBluetoothHeadphonesSupported: Int = 0

    var baseBluetoothCellPhonesSupported: Int = 0

    var supportsPhonebookTransferDialingCodes: Bool = false

    var supportsDialingOfInternationalCode: Bool = false

    var supportsAddingOfCellAreaCode: Bool = false

    var landlineLocalAreaCodeFeatures: Int = 0

    var supportsAddingOfPBXLineAccessNumber: Bool = false

    var supportsCellRingtone: Bool = false

    var supportsCellAlerts: Bool = false

    var baseCellRingtone: Int = 1

    var bluetoothPhonebookTransfers: Int = 0

    var baseOrInBackgroundPhonebookTransfer: Bool = false

    var hasCellPhoneVoiceControl: Bool = false

    var basePhonebookCapacity: Int = 50

    var numbersPerPhonebookEntry: Int = 1

    var baseFavoriteEntriesCapacity: Int = 0

    var baseSupportsPhonebookRingtones: Bool = false

    var baseSupportsPhonebookGroups: Bool = false

    var baseCallerIDCapacity: Int = 50

    var baseRedialCapacity: Int = 0

    var busyRedialMode: Int = 0

    var redialNameDisplay: Int = 0

    var supportsCallWaiting: Bool = true

    var callRestriction: Int = 0

    var callerIDPhonebookMatch: Bool = true

    var baseSpeedDialCapacity: Int = 0

    var hasOneTouchEmergencyCalling: Bool = false

    var baseOneTouchDialCapacity: Int = 0

    var baseOneTouchDialCard: Int = 0

    var baseOneTouchDialExpansionModulesSupported: Bool = false

    var oneTouchDialSupportsHandsetNumbers: Bool = false

    var speedDialPhonebookEntryMode: Int = 0

    var callBlockCapacity: Int = 0

    var callBlockSupportsPrefixes: Bool = false

    var blockedCallersHear: Int = 0

    var hasFirstRingSuppression: Bool = false

    var hasOneTouchCallBlock: Bool = false

    var canBlockEveryoneNotInPhonebook: Bool = false

    var canBlockNumberlessCalls: Bool = false

    var callBlockAutoDeletesOldestEntry: Int = 0

    var callBlockPreProgrammedDatabaseEntryCount: Int = 0

    var callBlockPreScreening: Int = 0

    var callBlockPreScreeningCustomGreeting: Bool = false

    var callBlockPreScreeningAllowedNameCapacity: Int = 100

    var callBlockPreScreeningAllowedNumberCapacity: Int = 100

    var callBlockPreScreeningAllowedNumberListVisible: Bool = true

    var roomMonitor: Int = 0

    var externalRoomMonitorAutomatedSystem: Int = 0

    var smartHomeDevicesSupported: Int = 0

    var answerByVoice: Bool = false

    var smartphonesAsHandsetsOverWiFi: Int = 0

    var outOfServiceToneOnAnswer: Bool = false

    var scamCallDetection: Bool = false

    var placeOnBaseAutoRegister: Bool = true

    var wallMountability: Int = 1

    var antennas: Int = 0

    var musicOnHoldPreset: Bool = false

    var musicOnHoldRecord: Bool = false

    var musicOnHoldLive: Bool = false

    var hasChargerSizeBase: Bool = false

    var landlineConnectionType: Int = 0

    var usesSingleLinePowerFeed: Bool = false

    var grade: Int = 0

    var landlineConnectedTo: Int = 2

    var storageOrSetup: Int = 0

    var phoneDescription: String = String()

    var hasQZ: Bool = true

    var supportsPoE: Bool = false

    var neededReplacements: Bool = false

    var cellCallRejection: Int = 0

    // MARK: - Properties - Supported VoIP Audio Codecs

    var supportsULaw: Bool = true

    var supportsALaw: Bool = true

    var supportsOpus: Bool = true

    var supportsG729: Bool = true

    var supportsG723: Bool = true

    var supportsG722: Bool = true

    var supportsG726: Bool = true

    var supportsILBC: Bool = true

    // MARK: - Properties - Transient (Non-Persistent) Properties

    // The text to display for the phone's type.
    @Transient
    var phoneTypeText: String {
        if isCordedCordless {
            return PhoneType.cordedCordless.rawValue
        } else if isCordless {
            let type: String
            if hasTransmitOnlyBase {
                type = PhoneType.cordlessWithTransmitOnlyBase.rawValue
            } else {
                type = PhoneType.cordless.rawValue
            }
            return "\(type) (\(cordlessBaseTypeText))"
        } else if basePhoneType == 1 {
            return PhoneType.wiFiHandset.rawValue
        } else if basePhoneType == 2 {
            return PhoneType.cellularHandset.rawValue
        } else {
            return PhoneType.corded.rawValue
        }
    }

    // The text to display for a cordless phone's base type.
    @Transient
    var cordlessBaseTypeText: String {
        if hasCordedReceiver {
            return String()
        } else if hasBaseKeypad {
            return CordlessBaseType.dialingBase.rawValue
        } else if hasBaseSpeakerphone {
            return CordlessBaseType.speakerphoneBase.rawValue
        } else if hasBaseAccessibleAnsweringSystem {
            return CordlessBaseType.messagingBase.rawValue
        } else {
            return hasTransmitOnlyBase ? CordlessBaseType.hiddenBase.rawValue : CordlessBaseType.locatorBase.rawValue
        }
    }

    // The actual number of this phone in the collection, which is phoneNumberInCollection (the index of the phone) + 1.
    @Transient
    var actualPhoneNumberInCollection: Int {
        return phoneNumberInCollection + 1
    }

    // Whether the base charges a handset in a lay-down position.
    @Transient
    var hasLayDownCharging: Bool {
        return baseChargingDirection == 2 || baseChargingDirection == 5 || baseChargingDirection == 6 || baseChargingDirection == 7
    }

    // Whether a corded phone has an electronic ringer or a cordless phone has a base ringer.
    @Transient
    var hasElectronicRinger: Bool {
        return baseRingtones > 2 || isCordless || cordedRingerType == 1
    }

    // The total number of base ringtones (standard + music/melody).
    @Transient
    var totalBaseRingtones: Int {
        return baseRingtones + baseMusicRingtones
    }

    // Whether the base can be used to talk on the phone.
    @Transient
    var canTalkOnBase: Bool {
        return hasBaseSpeakerphone || !isCordless || isCordedCordless
    }

    // Whether the base has a corded receiver.
    @Transient
    var hasCordedReceiver: Bool {
        return cordedReceiverMainColorBinding.wrappedValue != .clear
    }

    // Whether the phone is a push-button corded phone.
    @Transient
    var isPushButtonCorded: Bool {
        return !isCordless && (cordedPhoneType == 0 || cordedPhoneType == 2)
    }

    // Whether the phone is a corded wall phone.
    @Transient
    var isCordedWallPhone: Bool {
        return !isCordless && hasCordedReceiver && (cordedPhoneType == 2 || cordedPhoneType == 3 || cordedPhoneType == 6 || cordedPhoneType == 7)
    }

    // Whether the phone is a slim corded phone.
    @Transient
    var isSlimCorded: Bool {
        return !isCordless && (cordedPhoneType == 2 || cordedPhoneType == 3)
    }

    // Whether the phone is cordless, which is true if it came with 1 or more cordless devices (handsets/headsets/speakerphones).
    @Transient
    var isCordless: Bool {
        return numberOfIncludedCordlessHandsets > 0
    }

    // Whether the phone is a digital cordless phone, which means signals are transmitted/received as digital data.
    @Transient
    var isDigitalCordless: Bool {
        guard let frequency = Phone.CordlessFrequency(rawValue: frequency) else { return false }
        return frequency.isDigital
    }

    // Whether the phone is corded/cordless, meaning the base is a corded phone and acts as a main transmitting base for cordless devices.
    @Transient
    var isCordedCordless: Bool {
        return isCordless && hasCordedReceiver
    }

    // The number of cordless devices the user has added to the phone plus 1, which is used to set a new cordless device's properties before it's added to the phone's numberOfCordlessHandsets array.
    @Transient
    var cordlessHandsetsIHaveAfterAddHandset: Int {
        return cordlessHandsetsIHave.count + 1
    }

    // Whether the user has added the maximum number of, or too many, cordless devices to the phone based on how many can be registered to its base.
    @Transient
    var maxOrTooManyCordlessDevices: Bool {
        return cordlessHandsetsIHave.count >= maxCordlessHandsets && maxCordlessHandsets != -1
    }

    // Whether the user has added too many cordless devices (at least 1 more than maxCordlessHandsets) to the phone based on how many can be registered to its base.
    @Transient
    var tooManyCordlessDevices: Bool {
        return cordlessHandsetsIHave.count > maxCordlessHandsets && maxCordlessHandsets != -1
    }

    // Whether the phone has a charging area for a cordless handset.
    @Transient
    var baseChargesHandset: Bool {
        return isCordless && !hasCordedReceiver && !hasTransmitOnlyBase
    }

    // Whether the phone is cordless or a push-button corded desk phone.
    @Transient
    var isCordlessOrPushButtonDesk: Bool {
        return isCordless || cordedPhoneType == 0
    }

    // Whether the phone has a secondary color (the main and secondary colors aren't the same).
    @Transient
    var hasSecondaryColor: Bool {
        return baseSecondaryColorBinding.wrappedValue != baseMainColorBinding.wrappedValue
    }

    // Whether the phone has an accent color (the accent color is different from both the main and secondary colors).
    @Transient
    var hasAccentColor: Bool {
        return baseAccentColorBinding.wrappedValue != baseMainColorBinding.wrappedValue && baseAccentColorBinding.wrappedValue != baseSecondaryColorBinding.wrappedValue
    }

    // Whether the phone was acquired in the year of release (the acquisition year is the same as the release year, and both years are known).
    @Transient
    var acquiredInYearOfRelease: Bool {
        return acquisitionYear == releaseYear && acquisitionYear != -1 && releaseYear != -1
    }

    // Whether the phone has multiple lines or is a VoIP/landline combo phone.
    @Transient
    var isMultiline: Bool {
        return numberOfLandlines > 1 || landlineConnectionType == 5
    }

    // Whether the phone has an analog line jack.
    @Transient
    var hasAnalogLineConnection: Bool {
        return landlineConnectionType == 0 || landlineConnectionType == 5
    }

    // Whether the phone has a line in use light.
    @Transient
    var hasLandlineInUseLight: Bool {
        return landlineInUseStatusOnBase == 1 || landlineInUseStatusOnBase == 3
    }

    // Whether the phone is a business corded/cordless system (i.e., a 4-line system with a corded base that can accept 8 or more cordless handsets/desksets).
    @Transient
    var isBusinessCordedCordlessSystem: Bool {
        return isCordedCordless && maxCordlessHandsets >= 8 && numberOfLandlines == 4
    }

    // Whether the phone has a clock display or answering system message day/time stamp.
    @Transient
    var hasClock: Bool {
        return clock > 0 || !cordlessHandsetsIHave.filter({$0.clock > 0}).isEmpty || (hasAnsweringSystem > 0 && answeringSystemMessageTimestamp > 0)
    }

    // Whether the phone has a display to show phone numbers.
    @Transient
    var canShowPhoneNumbers: Bool {
        return isCordless || ((cordedPhoneType == 0 || cordedPhoneType == 2) && baseDisplayType > 2)
    }

    // Whether the phone has lists of entries (e.g. phonebook, caller ID list).
    @Transient
    var hasListsOfEntries: Bool {
        return canShowPhoneNumbers && (basePhonebookCapacity > 0 || baseCallerIDCapacity > 0 || callBlockCapacity > 0 || baseRedialCapacity > 1)
    }

    // Whether the base has a monochrome (i.e. non-color) display.
    @Transient
    var baseDisplayIsMonochrome: Bool {
        return baseDisplayType == 8 || (baseDisplayType > 2 && baseDisplayType < 7)
    }

    // Whether the phone has an answering system that is accessible from the base.
    @Transient
    var hasBaseAccessibleAnsweringSystem: Bool {
        return hasAnsweringSystem == 1 || hasAnsweringSystem == 3
    }

    // Whether the base has a speaker for a speakerphone, base intercom on a cordless phone, or an answering system that can be accessed from the base.
    @Transient
    var hasBaseSpeaker: Bool {
        return hasBaseSpeakerphone || (isCordless && hasBaseIntercom) || hasBaseAccessibleAnsweringSystem
    }

    // Whether the phone is a corded phone powered only by the phone line.
    @Transient
    var isLinePoweredCorded: Bool {
        return !isCordless && cordedPowerSource == 0 && landlineConnectionType == 0 && basePhoneType == 0
    }

    // The following computed properties check whether the base and/or cordless handsets of a cordless phone have a given feature. For corded phones, the cordless handset checks don't apply.

    // Whether the phone doesn't have any handsets which fit on the base.
    @Transient
    var noFittingHandsets: Bool {
        return cordlessHandsetsIHave.filter({ $0.fitsOnBase }).isEmpty
    }

    // Whether the phone doesn't have any handsets which support place-on-base power backup.
    @Transient
    var noHandsetsForPlaceOnBasePowerBackup: Bool {
        return cordlessHandsetsIHave.filter({$0.fitsOnBase && $0.hasSpeakerphone && $0.supportsPlaceOnBasePowerBackup}).isEmpty
    }

    @Transient
    var supportsWiredHeadsets: Bool {
        return baseSupportsWiredHeadsets || !cordlessHandsetsIHave.filter({$0.supportsWiredHeadsets}).isEmpty
    }

    // Whether the base or any cordless handset has a phonebook.
    @Transient
    var hasPhonebook: Bool {
        return basePhonebookCapacity > 0 || !cordlessHandsetsIHave.filter({$0.phonebookCapacity > 0}).isEmpty
    }

    // Whether the base or any cordless handset has a caller ID list.
    @Transient
    var hasCallerIDList: Bool {
        return baseCallerIDCapacity > 0 || !cordlessHandsetsIHave.filter({$0.callerIDCapacity > 0}).isEmpty
    }

    // MARK: - Properties - Color Bindings

    // SwiftData can only store Codable types like String, Int, Double, and Bool, not complex types like Color. To allow ColorPicker to work with SwiftData, a custom Color binding is created, which gets and sets color component Double values stored in SwiftData.

    @Transient
    var baseMainColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseMainColorRed, baseMainColorGreen, baseMainColorBlue) }, set: { [self] r, g, b in
            baseMainColorRed = r
            baseMainColorGreen = g
            baseMainColorBlue = b
        })
    }

    @Transient
    var baseSecondaryColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseSecondaryColorRed, baseSecondaryColorGreen, baseSecondaryColorBlue) }, set: { [self] r, g, b in
            baseSecondaryColorRed = r
            baseSecondaryColorGreen = g
            baseSecondaryColorBlue = b
        })
    }

    @Transient
    var baseAccentColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseAccentColorRed, baseAccentColorGreen, baseAccentColorBlue) }, set: { [self] r, g, b in
            baseAccentColorRed = r
            baseAccentColorGreen = g
            baseAccentColorBlue = b
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
    var baseDisplayBacklightColorBinding: Binding<Color> {
        Color.rgbaBinding(get: { [self] in (baseDisplayBacklightColorRed, baseDisplayBacklightColorGreen, baseDisplayBacklightColorBlue, baseDisplayBacklightColorAlpha) }, set: { [self] r, g, b, a in
            baseDisplayBacklightColorRed = r
            baseDisplayBacklightColorGreen = g
            baseDisplayBacklightColorBlue = b
            baseDisplayBacklightColorAlpha = a
        })
    }

    @Transient
    var baseKeyBacklightColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseKeyBacklightColorRed, baseKeyBacklightColorGreen, baseKeyBacklightColorBlue) }, set: { [self] r, g, b in
            baseKeyBacklightColorRed = r
            baseKeyBacklightColorGreen = g
            baseKeyBacklightColorBlue = b
        })
    }

    @Transient
    var baseKeyForegroundColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseKeyForegroundColorRed, baseKeyForegroundColorGreen, baseKeyForegroundColorBlue) }, set: { [self] r, g, b in
            baseKeyForegroundColorRed = r
            baseKeyForegroundColorGreen = g
            baseKeyForegroundColorBlue = b
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
    var baseKeyBackgroundColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseKeyBackgroundColorRed, baseKeyBackgroundColorGreen, baseKeyBackgroundColorBlue) }, set: { [self] r, g, b in
            baseKeyBackgroundColorRed = r
            baseKeyBackgroundColorGreen = g
            baseKeyBackgroundColorBlue = b
        })
    }

    @Transient
    var baseLEDMessageCounterColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (baseLEDMessageCounterColorRed, baseLEDMessageCounterColorGreen, baseLEDMessageCounterColorBlue) }, set: { [self] r, g, b in
            baseLEDMessageCounterColorRed = r
            baseLEDMessageCounterColorGreen = g
            baseLEDMessageCounterColorBlue = b
        })
    }

    // MARK: - Initialization

    init(brand: String, model: String) {
        self.brand = brand
        self.model = model
    }

    // MARK: - Set Acquisition Year to Release Year

    func setAcquisitionYearToReleaseYear() {
        acquisitionYear = releaseYear
    }

    // MARK: - Update All Cordless Devices' Place In Collection

    func updateAllCordlessDevicePlaceInCollection() {
        for handset in cordlessHandsetsIHave {
            handset.storageOrSetup = storageOrSetup
        }
    }

    // MARK: - Color Methods

    func setBaseSecondaryColorToMain() {
        let components = baseMainColorBinding.wrappedValue.components
        baseSecondaryColorRed = components.red
        baseSecondaryColorGreen = components.green
        baseSecondaryColorBlue = components.blue
    }

    func setBaseAccentColorToMain() {
        let components = baseMainColorBinding.wrappedValue.components
        baseAccentColorRed = components.red
        baseAccentColorGreen = components.green
        baseAccentColorBlue = components.blue
    }

    func setBaseAccentColorToSecondary() {
        let components = baseSecondaryColorBinding.wrappedValue.components
        baseAccentColorRed = components.red
        baseAccentColorGreen = components.green
        baseAccentColorBlue = components.blue
    }

    func setChargeLightChargedColorToCharging() {
        let components = chargeLightColorChargingBinding.wrappedValue.components
        chargeLightColorChargedRed = components.red
        chargeLightColorChargedGreen = components.green
        chargeLightColorChargedBlue = components.blue
        chargeLightColorChargedAlpha = 1
    }

    func setCordedReceiverSecondaryColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverSecondaryColorRed = components.red
        cordedReceiverSecondaryColorGreen = components.green
        cordedReceiverSecondaryColorBlue = components.blue
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
        let previousBackgroundRed = baseKeyBackgroundColorRed
        let previousBackgroundGreen = baseKeyBackgroundColorGreen
        let previousBackgroundBlue = baseKeyBackgroundColorBlue
        baseKeyBackgroundColorRed = baseKeyForegroundColorRed
        baseKeyBackgroundColorGreen = baseKeyForegroundColorGreen
        baseKeyBackgroundColorBlue = baseKeyForegroundColorBlue
        baseKeyForegroundColorRed = previousBackgroundRed
        baseKeyForegroundColorGreen = previousBackgroundGreen
        baseKeyForegroundColorBlue = previousBackgroundBlue
    }

    // MARK: - Property Change Handlers

    func brandChanged(oldValue: String, newValue: String) {
        if newValue.isEmpty {
            brand = Phone.mockBrand
        }
    }

    func modelNumberChanged(oldValue: String, newValue: String) {
        if newValue.isEmpty {
            model = Phone.mockModel
        }
        guard let digit = handsetNumberDigit, let digitIndex = handsetNumberDigitIndex else { return }
        let array = newValue.split(separator: String())
        if digitIndex > array.count - 1 {
            handsetNumberDigit = nil
            handsetNumberDigitIndex = nil
        } else if array[digitIndex] != String(digit) {
            handsetNumberDigit = nil
            handsetNumberDigitIndex = nil
        }
    }

    func hasAnsweringSystemChanged(oldValue: Int, newValue: Int) {
        if newValue == 1 {
            if answeringSystemMenuOnBase == 0 {
                answeringSystemMenuOnBase = 1
            }
        }
        if newValue == 0 || newValue == 2 {
            hasMessageList = false
        }
        if newValue < 2 {
            for handset in cordlessHandsetsIHave {
                handset.hasMessageList = false
            }
        }
    }

    func bluetoothPhonebookTransfersChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            supportsPhonebookTransferDialingCodes = false
            baseOrInBackgroundPhonebookTransfer = false
        }
    }

    func basePhonebookCapacityChanged(oldValue: Int, newValue: Int) {
        if newValue < phonebookTransferRequiredMaxCapacity {
            bluetoothPhonebookTransfers = 0
        }
        if newValue == 0 {
            canBlockEveryoneNotInPhonebook = false
            redialNameDisplay = 0
            callerIDPhonebookMatch = false
            hasTalkingPhonebook = false
            speedDialPhonebookEntryMode = 0
        }
    }

    func callBlockCapacityChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            canBlockNumberlessCalls = false
            canBlockEveryoneNotInPhonebook = false
            hasOneTouchCallBlock = false
            callBlockSupportsPrefixes = false
            callBlockAutoDeletesOldestEntry = 0
            callBlockPreProgrammedDatabaseEntryCount = 0
            callBlockPreScreening = 0
            callBlockPreScreeningCustomGreeting = false
            callBlockPreScreeningAllowedNameCapacity = 0
            callBlockPreScreeningAllowedNumberCapacity = 0
            callBlockPreScreeningAllowedNumberListVisible = false
            if cellCallRejection >= 2 {
                cellCallRejection = 0
            }
        }
    }

    func supportsWiredHeadsetsChanged(oldValue: Bool, newValue: Bool) {
        if !newValue && musicOnHoldLive {
            musicOnHoldLive = false
        }
    }

    func numberOfLandlinesChanged(oldValue: Int, newValue: Int) {
        if newValue < 2 {
            answeringSystemMultilineButtonLayout = 0
            for handset in cordlessHandsetsIHave {
                if handset.talkOffButtonType == 4 {
                    handset.talkOffButtonType = 1
                }
            }
        }
        if newValue < 4 {
            hasAutoAttendantAndPersonalMailboxes = false
        }
        if newValue > 1 {
            numberOfMailboxes = 1
        }
    }

    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if acquisitionYear < newValue && acquisitionYear != -1 {
            acquisitionYear = releaseYear
        }
        if newValue == 0 && oldValue == -1 {
            releaseYear = oldestPhoneYear
        } else if newValue < oldestPhoneYear {
            releaseYear = -1
        }
    }

    func acquisitionYearChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 && oldValue == -1 {
            acquisitionYear = releaseYear == -1 ? oldestPhoneYear : releaseYear
        } else if newValue < releaseYear || newValue < oldestPhoneYear {
            acquisitionYear = -1
        }
    }

    func baseBluetoothCellPhonesSupportedChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            cellLineOnlyBehavior = 0
            cellLineInUseStatusOnBase = 0
            baseCellRingtone = 0
            supportsCellRingtone = false
            answeringSystemForCellLines = false
            supportsCellAlerts = false
            hasCellPhoneVoiceControl = false
            supportsAddingOfCellAreaCode = false
            cellCallRejection = 0
            if bluetoothPhonebookTransfers == 2 {
                bluetoothPhonebookTransfers = 1
            }
        }
    }

    func isCordlessChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            if dialMode == 0 {
                dialMode = 2
            }
            cordedPhoneType = 0
            cordedRingerType = 1
            cordedPowerSource = 0
            if baseKeyBacklightAmount > 6 {
                baseKeyBacklightAmount = 5
            }
            basePhoneType = 0
        } else {
            if hasAnsweringSystem > 1 {
                hasAnsweringSystem = 1
            }
            cordlessPowerBackupMode = 0
            ecoMode = 0
            cordedReceiverMainColorBinding.wrappedValue = .black
            dialWithBaseDuringHandsetCall = false
            hasIntercom = false
            hasPickUpToSwitch = false
            baseIntercomRingtone = 0
            placeOnBaseAutoRegister = false
            hasTransmitOnlyBase = false
            supportsRangeExtenders = false
            baseChargingDirection = 0
            baseChargeContactType = 0
            baseChargeContactPlacement = 0
            baseHasSeparateDataContact = false
        }
    }

    func numberOfIncludedCordlessHandsetsChanged(oldValue: Int, newValue: Int) {
        if newValue > maxCordlessHandsets && maxCordlessHandsets != -1 {
            maxCordlessHandsets = newValue
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
        } else if newValue > 1 {
            if locatorButtons == 0 {
                deregistration = 1
            }
        }
        if newValue < 8 {
            hasAutoAttendantAndPersonalMailboxes = false
        }
        if newValue == 0 && oldValue == -1 {
            maxCordlessHandsets = 1
        } else if newValue == 0 && oldValue == 1 {
            maxCordlessHandsets = -1
        }
        if newValue < numberOfIncludedCordlessHandsets && newValue >= 1 {
            numberOfIncludedCordlessHandsets = newValue
        }
    }

    func isDigitalCordlessChanged(oldValue: Bool, newValue: Bool) {
        if !newValue {
            maxCordlessHandsets = -1
            locatorButtons = 0
            deregistration = 1
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
            dialWithBaseDuringHandsetCall = false
            hasPickUpToSwitch = false
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

    func totalBaseRingtonesChanged(oldValue: Int, newValue: Int) {
        if baseCellRingtone == 3 {
            baseCellRingtone = 1
        }
        if newValue < oldValue && (baseIntercomRingtone >= (totalBaseRingtones + 1) || baseIntercomRingtone == 1) {
            baseIntercomRingtone -= 1
        }
    }

    func voicemailQuickDialChanged(oldValue: Int, newValue: Int) {
        if newValue == 2 && baseSpeedDialCapacity > 9 {
            baseSpeedDialCapacity = 9
        }
    }

    func baseDisplayTypeChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            baseDisplayCanTilt = false
            if voicemailIndication == 6 {
                voicemailIndication = 4
            }
            if handsetRenaming == 2 {
                handsetRenaming = 1
            }
            if landlineInUseStatusOnBase > 1 {
                landlineInUseStatusOnBase = 0
            }
            if cellLineInUseStatusOnBase >= 2 {
                cellLineInUseStatusOnBase = 0
            }
            if baseCellRingtone == 3 {
                baseCellRingtone = 1
            }
            if baseSpeedDialCapacity > 10 {
                baseSpeedDialCapacity = 10
            }
            if voicemailQuickDial > 2 {
                voicemailQuickDial = 0
            }
            hasTalkingPhonebook = false
            baseNavigatorKeyType = 0
            baseNavigatorKeyCenterButton = 0
            baseNavigatorKeyStandbyShortcuts = false
        }
        if newValue <= 3 {
            baseSoftKeysBottom = 0
            baseSoftKeysSide = 0
            basePhonebookCapacity = 0
            baseCallerIDCapacity = 0
            if baseRedialCapacity >= 2 {
                baseRedialCapacity = 1
            }
        }
        if newValue < 4 {
            baseMainMenuLayout = 0
        }
        if newValue < 3 || newValue > 6 {
            let colorComponents = Color.Components(fromColor: .white)
            baseDisplayBacklightColorRed = colorComponents.red
            baseDisplayBacklightColorGreen = colorComponents.green
            baseDisplayBacklightColorBlue = colorComponents.blue
        }
    }

    func baseNavigatorKeyTypeChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            baseNavigatorKeyCenterButton = 0
            baseNavigatorKeyUpDownVolume = false
            baseNavigatorKeyLeftRightRepeatSkip = false
            baseNavigatorKeyStandbyShortcuts = false
            if baseKeyBacklightAmount > 3 {
                baseKeyBacklightAmount = 3
            }
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
        if !newValue {
            if voicemailQuickDial == 2 {
                voicemailQuickDial = 0
            }
            hasQZ = false
            hasKeypadLock = false
        }
    }

    func hasBaseSpeakerphoneChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            hasBaseIntercom = true
        }
    }

    func landlineConnectionTypeChanged(oldValue: Int, newValue: Int) {
        if newValue > 0 {
            dialMode = 1
        }
        if newValue > 1 {
            if cordedPowerSource < 2 {
                cordedPowerSource = 2
            }
            if isCordedCordless && cordlessPowerBackupMode == 1 {
                cordlessPowerBackupMode = 0
            }
        }
        if newValue > 3 {
            grade = 0
        }
        if newValue < 2 && numberOfLandlines > 4 {
            numberOfLandlines = 1
        }
        if newValue != 2 && newValue != 5 {
            supportsPoE = false
        }
    }

    func supportsPoEChanged(oldValue: Bool, newValue: Bool) {
        if !newValue && cordedPowerSource == 0 {
            cordedPowerSource = 2
        }
    }

    func cordlessPowerBackupModeChanged(oldValue: Int, newValue: Int) {
        if newValue != 1 {
            cordlessPowerBackupReturnBehavior = 0
        }
    }

    func hasBaseIntercomChanged(oldValue: Bool, newValue: Bool) {
        if !newValue {
            locatorButtons = 0
        }
    }

    func locatorButtonsChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 {
            deregistration = 1
        }
        if newValue > 0 {
            handsetLocatorUsesIntercom = true
            placeOnBaseAutoRegister = false
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
            dialWithBaseDuringHandsetCall = false
            hasPickUpToSwitch = false
            placeOnBaseAutoRegister = false
            hasTransmitOnlyBase = false
            baseChargingDirection = 0
            baseChargeContactType = 0
            baseChargeContactPlacement = 0
            if maxCordlessHandsets != 0 {
                hasBaseKeypad = true
                hasBaseSpeakerphone = true
                hasBaseIntercom = true
            }
        } else {
            numberOfIncludedCordlessHandsets = 1
            cordedPhoneType = 0
            cordedReceiverSecondaryColorBinding.wrappedValue = .black
        }
    }

    func cordedPhoneTypeChanged(oldValue: Int, newValue: Int) {
        if newValue != 0 {
            hasDualReceivers = false
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
        if newValue != 2 {
            if switchHookType == 1 {
                switchHookType = 0
            }
            if baseKeyBacklightAmount == 6 {
                baseKeyBacklightAmount = 3
            }
        }
        if newValue == 1 || newValue == 3 {
            if cordedReceiverVolumeAdjustmentType > 1 {
                cordedReceiverVolumeAdjustmentType = 1
            }
            if baseRingerVolumeAdjustmentType == 1 {
                baseRingerVolumeAdjustmentType = 0
            }
            hasBaseKeypad = true
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
            cordedRingerLocation = 0
            hasBaseSpeakerphone = false
            hasAnsweringSystem = 0
            if baseRingtones > 2 {
                baseRingtones = 2
            }
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
