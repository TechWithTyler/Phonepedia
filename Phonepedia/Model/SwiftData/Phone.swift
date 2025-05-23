//
//  Phone.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

// The structure of a SwiftData model class is very simple--a Swift class with @Model before its declaration.
@Model
final class Phone {

    // MARK: - Properties - Default Data

    @Transient
    static let mockBrand: String = "Some Brand"

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

    var isWiFiHandset: Bool = false

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

    var baseBackupBatteryType: Int = 0

    var locatorButtons: Int = 0

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

    var cordedPhoneType: Int = 0

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

    var hasTransmitOnlyBase: Bool = false

    var ecoMode: Int = 0

    var frequency: Double = CordlessFrequency.northAmericaDECT6.rawValue

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
        } else if isWiFiHandset {
            return PhoneType.wiFiHandset.rawValue
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

    // The following computed properties check whether the base and/or cordless handsets of a cordless phone have a given feature. For corded phones, the cordless handset checks don't apply.

    @Transient
    var supportsWiredHeadsets: Bool {
        return baseSupportsWiredHeadsets || !cordlessHandsetsIHave.filter({$0.supportsWiredHeadsets}).isEmpty
    }

    @Transient
    var hasPhonebook: Bool {
        return basePhonebookCapacity > 0 || !cordlessHandsetsIHave.filter({$0.phonebookCapacity > 0}).isEmpty
    }

    @Transient
    var hasCallerIDList: Bool {
        return baseCallerIDCapacity > 0 || !cordlessHandsetsIHave.filter({$0.callerIDCapacity > 0}).isEmpty
    }

    // MARK: - Properties - Color Bindings

    // SwiftData can only store Codable types like String, Int, Double, and Bool, not complex types like Color. To allow ColorPicker to work with SwiftData, a custom Color binding is created, which gets and sets color component Double values stored in SwiftData.

    @Transient
    var baseMainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseMainColorRed, green: baseMainColorGreen, blue: baseMainColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseMainColorRed = components.red
            baseMainColorGreen = components.green
            baseMainColorBlue = components.blue
        }
    }

    @Transient
    var baseSecondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseSecondaryColorRed, green: baseSecondaryColorGreen, blue: baseSecondaryColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseSecondaryColorRed = components.red
            baseSecondaryColorGreen = components.green
            baseSecondaryColorBlue = components.blue
        }
    }

    @Transient
    var baseAccentColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseAccentColorRed, green: baseAccentColorGreen, blue: baseAccentColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseAccentColorRed = components.red
            baseAccentColorGreen = components.green
            baseAccentColorBlue = components.blue
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
    var baseDisplayBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseDisplayBacklightColorRed, green: baseDisplayBacklightColorGreen, blue: baseDisplayBacklightColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseDisplayBacklightColorRed = components.red
            baseDisplayBacklightColorGreen = components.green
            baseDisplayBacklightColorBlue = components.blue
        }
    }

    @Transient
    var baseKeyBacklightColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseKeyBacklightColorRed, green: baseKeyBacklightColorGreen, blue: baseKeyBacklightColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseKeyBacklightColorRed = components.red
            baseKeyBacklightColorGreen = components.green
            baseKeyBacklightColorBlue = components.blue
        }
    }

    @Transient
    var baseKeyForegroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseKeyForegroundColorRed, green: baseKeyForegroundColorGreen, blue: baseKeyForegroundColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseKeyForegroundColorRed = components.red
            baseKeyForegroundColorGreen = components.green
            baseKeyForegroundColorBlue = components.blue
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
    var baseKeyBackgroundColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseKeyBackgroundColorRed, green: baseKeyBackgroundColorGreen, blue: baseKeyBackgroundColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseKeyBackgroundColorRed = components.red
            baseKeyBackgroundColorGreen = components.green
            baseKeyBackgroundColorBlue = components.blue
        }
    }

    @Transient
    var baseLEDMessageCounterColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: baseLEDMessageCounterColorRed, green: baseLEDMessageCounterColorGreen, blue: baseLEDMessageCounterColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            baseLEDMessageCounterColorRed = components.red
            baseLEDMessageCounterColorGreen = components.green
            baseLEDMessageCounterColorBlue = components.blue
        }
    }

    // MARK: - Initialization

    init(brand: String, model: String) {
        self.brand = brand
        self.model = model
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

    func numberOfIncludedCordlessHandsetsChanged(oldValue: Int, newValue: Int) {
        if let digit = handsetNumberDigit, digit != newValue {
            handsetNumberDigit = nil
            handsetNumberDigitIndex = nil
        }
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

    func releaseYearChanged(oldValue: Int, newValue: Int) {
        if acquisitionYear < newValue {
            acquisitionYear = releaseYear
        }
        if newValue == 0 && oldValue == -1 {
            releaseYear = 1892
        } else if newValue < 1892 {
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
        }
    }

    func isWiFiHandsetChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            numberOfIncludedCordlessHandsets = 0
            landlineConnectionType = 3
            hasBaseKeypad = true
        }
    }

    func isCordlessChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            cordedPhoneType = 0
            cordedRingerType = 1
            if baseKeyBacklightAmount > 6 {
                baseKeyBacklightAmount = 5
            }
        } else {
            if hasAnsweringSystem > 1 {
                hasAnsweringSystem = 1
            }
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
            switchHookType = 0
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
