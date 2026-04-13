//
//  Phone.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI
import SwiftData

// The structure of a SwiftData model class is very simple--a Swift class with @Model before its declaration. Any property not marked with @Transient is a persistent property which will be stored to the underlying Core Data persistent store SQLite file. @Model does 2 things: makes this class conform to PersistentModel and Observable, and internally adds @_PersistedProperty to the beginning of persistent properties.
// A final class is a class that can't be subclassed.
@Model
final class Phone: BaseColorManipulatable, ChargeLightColorManipulatable, CordedReceiverColorManipulatable, KeyColorManipulatable {

    // MARK: - Properties - Mock Phone

    // The mock phone, which is the default for new phones. It needs to be a computed property so it gets a new ID each time.
    @Transient
    static var mockPhone: Phone {
        return Phone(brand: Phone.mockBrand, model: Phone.mockModel)
    }

    // MARK: - Properties - Default Data

    // The default brand for new phones.
    // Properties marked with the @Transient property wrapper won't persist their values to SwiftData.
    @Transient
    static let mockBrand: String = "Some Brand"

    // The default model number for new phones.
    @Transient
    static let mockModel: String = "M123-2"

    // MARK: - Properties - Persistent Data

    // The phone's brand.
    // At least one property should be created without a default value, being assigned the default in init(), to reduce performance issues.
    var brand: String

    // The phone's model number.
    var model: String

    // The nickname the user assigned to the phone.
    // There must be one or more properties declared with an initial value for automatic (lightweight) migration to work.
    var nickname: String = String()

    // The index of this phone.
    var phoneNumberInCollection: Int = 0

    // The phone's photo data.
    // Use @Attribute(_:) to specify an attribute for a SwiftData property.
    @Attribute(.externalStorage) var photoData: Data? = nil

    // The year the phone was released.
    var releaseYear: Int = currentYear - 1

    // The year the phone was purchased/acquired by the user.
    var acquisitionYear: Int = currentYear

    // Where the user acquired the phone. 0 = thrift store/sale, 1 = electronics store (new), 2 = online (used), 3 = online (new), 4 = gift.
    var whereAcquired: Int = 0

    // The phone type for non-cordless phones. 0 = corded, 1 = Wi-Fi handset, 2 = cellular handset.
    var basePhoneType: Int = 0

    // The model number assigned to new cordless devices.
    var mainHandsetModel: String = CordlessHandset.mockModel

    // The base main color's red component.
    var baseMainColorRed: Double = 0

    // The base main color's green component.
    var baseMainColorGreen: Double = 0

    // The base main color's blue component.
    var baseMainColorBlue: Double = 0

    // The base secondary color's red component.
    var baseSecondaryColorRed: Double = 0

    // The base secondary color's green component.
    var baseSecondaryColorGreen: Double = 0

    // The base secondary color's blue component.
    var baseSecondaryColorBlue: Double = 0

    // The base accent color's red component.
    var baseAccentColorRed: Double = 0

    // The base accent color's green component.
    var baseAccentColorGreen: Double = 0

    // The base accent color's blue component.
    var baseAccentColorBlue: Double = 0

    // The base display backlight color's red component.
    var baseDisplayBacklightColorRed: Double = 255

    // The base display backlight color's green component.
    var baseDisplayBacklightColorGreen: Double = 255

    // The base display backlight color's blue component.
    var baseDisplayBacklightColorBlue: Double = 255

    // The base display backlight color's alpha component.
    var baseDisplayBacklightColorAlpha: Double = 1

    // The base key foreground color's red component.
    var baseKeyForegroundColorRed: Double = 255

    // The base key foreground color's green component.
    var baseKeyForegroundColorGreen: Double = 255

    // The base key foreground color's blue component.
    var baseKeyForegroundColorBlue: Double = 255

    // The base key background color's red component.
    var baseKeyBackgroundColorRed: Double = 0

    // The base key background color's green component.
    var baseKeyBackgroundColorGreen: Double = 0

    // The base key background color's blue component.
    var baseKeyBackgroundColorBlue: Double = 0

    // The corded receiver main color's red component.
    var cordedReceiverMainColorRed: Double = 0

    // The corded receiver main color's green component.
    var cordedReceiverMainColorGreen: Double = 0

    // The corded receiver main color's blue component.
    var cordedReceiverMainColorBlue: Double = 0

    // The corded receiver main color's alpha component.
    var cordedReceiverMainColorAlpha: Double = 0

    // The corded receiver secondary color's red component.
    var cordedReceiverSecondaryColorRed: Double = 0

    // The corded receiver secondary color's green component.
    var cordedReceiverSecondaryColorGreen: Double = 0

    // The corded receiver secondary color's blue component.
    var cordedReceiverSecondaryColorBlue: Double = 0

    // The corded receiver accent color's red component.
    var cordedReceiverAccentColorRed: Double = 0

    // The corded receiver accent color's green component.
    var cordedReceiverAccentColorGreen: Double = 0

    // The corded receiver accent color's blue component.
    var cordedReceiverAccentColorBlue: Double = 0

    // The base LED message counter color's red component.
    var baseLEDMessageCounterColorRed: Double = 255

    // The base LED message counter color's green component.
    var baseLEDMessageCounterColorGreen: Double = 0

    // The base LED message counter color's blue component.
    var baseLEDMessageCounterColorBlue: Double = 0

    // The base key backlight color's red component.
    var baseKeyBacklightColorRed: Double = 0

    // The base key backlight color's green component.
    var baseKeyBacklightColorGreen: Double = 255

    // The base key backlight color's blue component.
    var baseKeyBacklightColorBlue: Double = 0

    // The base charge light charging state color's red component.
    var chargeLightColorChargingRed: Double = 255

    // The base charge light charging state color's green component.
    var chargeLightColorChargingGreen: Double = 0

    // The base charge light charging state color's blue component.
    var chargeLightColorChargingBlue: Double = 0

    // The base charge light charged state color's red component.
    var chargeLightColorChargedRed: Double = 0

    // The base charge light charged state color's green component.
    var chargeLightColorChargedGreen: Double = 255

    // The base charge light charged state color's blue component.
    var chargeLightColorChargedBlue: Double = 0

    // The base charge light charged state color's alpha component.
    var chargeLightColorChargedAlpha: Double = 1

    // Whether the phone has a charge light.
    var hasChargeLight: Bool = false

    // The corded receiver earpiece type. 0 = standard, 1 = bone-conduction.
    var cordedReceiverEarpieceType: Int = 0

    // The base's backup battery type. 0 = pack with plug, 1 = pack with contacts, 2 = standard batteries.
    var baseBackupBatteryType: Int = 0

    // The type of handset locator button(s). 0 = one for all, 1 = one for each, 2 = one for each + all, 3 = select + call buttons.
    var locatorButtons: Int = 0

    // The location of the handset locator button. 0 = standard/in menu, 1 = side of base, 2 = bottom of base.
    var locatorButtonLocation: Int = 0

    // Whether intercom is used as the means of handset locating.
    var handsetLocatorUsesIntercom: Bool = false

    // Whether the phone supports cordless device deregistration. 0 = not supported, 1 = from the cordless device to be deregistered, 2 = one from any cordless device/base, 3 = multiple from any cordless device/base, 4 = all from base.
    var deregistration: Int = 2

    // The button type. 0 = spaced, 1 = spaced with click feel, 2 = some spaced, some diamond-cut, 3 = some spaced with click feel, some diamond-cut, 4 = diamond-cut, 5 = touch button panel.
    var buttonType: Int = 0

    // Whether the base's buttons or keypad are arranged in a circle like a rotary dial.
    var hasRotaryInspiredButtonLayout: Bool = false

    // Whether basic answering system settings are set by physical switches.
    var answeringSystemSwitches: Bool = false

    // How the base speaker volume is adjusted. 0 = switch/dial, 1 = buttons.
    var baseSpeakerVolumeAdjustmentType: Int = 1

    // How the corded receiver volume is adjusted. 0 = not supported, 1 = switch/dial, 2 = buttons.
    var cordedReceiverVolumeAdjustmentType: Int = 1

    // Whether the corded receiver cord is hard-wired (non-removable).
    var hasHardWiredCordedReceiver: Bool = false

    // Whether the line cord is hard-wired (non-removable).
    var hasHardWiredLineCord: Bool = false

    // How the base ringer volume is adjusted. 0 = switch/dial, 1 = buttons.
    var baseRingerVolumeAdjustmentType: Int = 1

    // Whether the base ringer can be turned off.
    var baseSupportsRingerOff: Bool = true

    // The supported dial mode/how it's changed. 0 = pulse-only, 1 = tone-only, 2 = tone or pulse setting, 3 = tone or pulse switch.
    var dialMode: Int = 2

    // The base clock display type. 0 = none, 1 = time only, 2 = day and time, 3 = date and time without year, 4 = date and time with year.
    var clock: Int = 0

    // Whether caller ID can set the clock.
    var callerIDTimeAdjust: Bool = true

    // The corded phone style. 0 = push-button desk, 1 = push-button rotary, 2 = slim push-button, 3 = slim rotary, 4 = base-less, 5 = novelty, 6 = candlestick, 7 = wooden box.
    var cordedPhoneType: Int = 0

    // Whether the phone is a payphone.
    var isPayphone: Bool = false

    // Whether the phone, if corded, has a clock/radio/alarm
    var cordedPhoneHasClockRadioAlarm: Bool = false

    // The corded receiver hook type. 0 = fixed, 1 = flip/rotate, 2 = removable.
    var cordedReceiverHookType: Int = 2

    // The cordless handset charging area's hook type when the handset lays down. 0 = none, 1 = fixed, 2 = flip/rotate slotting into the back of the handset, 3 = flip slotting into the top of the handset.
    var cordlessHandsetLayDownHookType: Int = 0

    // Whether the phone has 2 corded receivers.
    var hasDualReceivers: Bool = false

    // Where the keypad/rotary dial is on a slim corded phone if the ringer/electronics are in the base. 0 = in base, 1 = in receiver.
    var dialLocation: Int = 1

    // The corded receiver switch hook type. 0 = press on base, 1 = press on receiver, 2 = magnetic, 3 = contacts.
    var switchHookType: Int = 0

    // The phone's ringer type if corded and doesn't have 3 or more ringtones. 0 = bell/mechanical, 1 = electronic.
    var cordedRingerType: Int = 1

    // The ringer tone/pattern for other lines on multi-line phones. 0 = same as line 1, 1 = different cadence, 2 = different pitch, 3 = an entirely different tone/selectable.
    var ringerForOtherLines: Int = 0

    // The location of the ringer and electronics in a slim corded phone. 0 = base, 1 = receiver.
    var cordedRingerLocation: Int = 0

    // The number of included cordless devices. 0 = not cordless, 1 or higher = cordless phone with X included cordless devices.
    var numberOfIncludedCordlessHandsets: Int = 2

    // The digit in the model number which indicates the number of included cordless handsets.
    var handsetNumberDigit: Int? = 2

    // The index of the handset number digit in the model number.
    var handsetNumberDigitIndex: Int? = 5

    // What the handset number digit represents. 0 = number of included cordless devices, 1 = 1 + X additional included cordless devices.
    var handsetNumberDigitRepresents: Int = 0

    // The maximum number of cordless devices.
    var maxCordlessHandsets: Int = defaultMaxCordlessDevices

    // The cordless device linking method. 0 = none, 1 = security code set by switches, 3 = security code set by placing a handset on the base, 4 = registration.
    var cordlessDeviceLinkingMethod: Int = 4

    // Whether the phone supports range extenders.
    var supportsRangeExtenders: Bool = false

    // Whether the phone places a call on hold if the cordless device goes out of range.
    var holdForOutOfRange: Bool = false

    // Whether the base is transmit-only (i.e. doesn't have a charging area or corded receiver).
    var hasTransmitOnlyBase: Bool = false

    // The phone's ECO mode type. 0 = not supported, 1 = reduced power only, 2 = no transmit, 3 = reduced power or no transmit.
    var ecoMode: Int = 0

    // The phone's frequency if cordless.
    var frequency: Double = CordlessFrequency.northAmericaDECT6.rawValue

    // Whether the base uses the power line as a transmitting antenna.
    var baseTransmitThroughPowerLine: Bool = false

    // Whether the phone has a "no line" alert.
    var hasNoLineAlert: Bool = false

    // The cordless devices the user has added to the phone.
    // Use @Relationship(deleteRule:inverse:) to define a relationship between a property and its type. The type of an @Relationship property must contain an Optional property of this object's type. In this case, a relationship is established between a CordlessHandset and its corresponding Phone.
    // This is a one-to-many relationship--each Phone can have multiple CordlessHandsets but each CordlessHandset can only be assigned to one Phone.
    @Relationship(deleteRule: .cascade, inverse: \CordlessHandset.phone)
    var cordlessHandsetsIHave: [CordlessHandset] = []

    // The chargers the user has added to the phone.
    @Relationship(deleteRule: .cascade, inverse: \CordlessHandsetCharger.phone)
    var chargersIHave: [CordlessHandsetCharger] = []

    // The number of base ringtones.
    var baseRingtones: Int = 1

    // The number of base music/melody ringtones.
    var baseMusicRingtones: Int = 0

    // The ringtone used for intercom. 0 = intercom-specific ringtone/beep, 1 = selectable, 2 or higher = specific ringtone number + 2 (e.g. 3 = tone 1, 12 = tone 10).
    var baseIntercomRingtone: Int = 0

    // The type of silent mode for the phone. 0 = not supported, 1 = number of hours, 2 = time period.
    var silentMode: Int = 0

    // Whether phonebook entries/groups can break through silent mode.
    var supportsSilentModeBypass: Bool = false

    // Whether the phone has intercom.
    var hasIntercom: Bool = true

    // The call transfer type. 0 = blind only, 1 = intercom only, 2 = intercom or blind.
    var callTransferType: Int = 1

    // The call privacy mode type. 0 = not supported, 1 = per-call only, 2 = all calls.
    var callPrivacyMode: Int = 0

    // Whether a join/leave tone sounds when a cordless device joins/leaves a call. 0 = none, 1 = join only, 2 = join/leave.
    var joinLeaveTone: Int = 0

    // Whether the base has intercom.
    var hasBaseIntercom: Bool = false

    // The intercom auto-answer type. 0 = not supported, 1 = with ring, 2 = without ring, 3 = optional ring.
    var intercomAutoAnswer: Int = 0

    // Whether the phone has push-to-talk or just broadcast to the base/all cordless devices. 0 = not supported, 1 = broadcast, 2 = push-to-talk.
    var pushToTalkOrBroadcastToAll: Int = 0

    // The number of lines.
    var numberOfLandlines: Int = 1

    // How the phone indicates that the line is in use. 0 = none, 1 = light, 2 = display, 3 = display and light.
    var landlineInUseStatusOnBase: Int = 0

    // How the phone indicates that another phone on the line is in use vs the base/another cordless device on this cordless phone. 0 = not supported, 1 = same as this cordless, 2 = distinct.
    var landlineInUseParallelPhoneIndication: Int = 1

    // Whether the in use light follows the ring signal if it's used as a visual ringer.
    var landlineInUseVisualRingerFollowsRingSignal: Bool = true

    // Whether the phone supports wired headsets.
    var baseSupportsWiredHeadsets: Bool = false

    // The maximum number of Bluetooth headphones that can be paired.
    var baseBluetoothHeadphonesSupported: Int = 0

    // The maximum number of Bluetooth cell phones that can be paired.
    var baseBluetoothCellPhonesSupported: Int = 0

    // Whether the phone has a USB port.
    var hasUSBCharging: Bool = false

    // How the phone indicates when the cell line is in use on a cordless device. Same options as landlineInUseStatusOnBase.
    var cellLineInUseStatusOnBase: Int = 0

    // Whether cell calls can be transferred to the cell phone.
    var supportsTransferToCell: Bool = false

    // Whether a call on a cell phone can be transferred to this phone. 0 = not supported, 1 = by the cell phone, 2 = by this phone.
    var cellCallTransferToPhone: Int = 0

    // How the phone handles the lack of a landline connection. 0 = optional "no line" alert, 1 = "no line" alert suppressed when at least 1 cell phone is paired, 2 = cell line only mode.
    var cellLineOnlyBehavior: Int = 0

    // The direction the handset charges on the base. 0 = face-forward stand up, 1 = face-up lean back, 2 = face-up lay down, 3 = face-backward stand up, 4 = face-down lean back, 5 = face-down lay down, 6 = face-forward stand up or face-down lay down, 7 = reversible handset, corded phone-inspired with center contacts, 8 = corded phone-inspired with top and/or bottom contacts.
    var baseChargingDirection: Int = 0

    // Whether the base has a 3rd charging contact for data.
    var baseHasSeparateDataContact: Bool = false

    // The placement of the base charging contacts. 0 = for handsets with contacts on the bottom, 1 = for handsets with contacts on the back and/or front, 2 = for handsets with a contact on each side, 3 = for handsets which hook over the top of the base.
    var baseChargeContactPlacement: Int = 0

    // The base's charging contact type. 0 = press-down, 1 = click, 2 = inductive.
    var baseChargeContactType: Int = 1

    // Whether the phone has an answering system. 0 = no, 1 = base only, 2 = handset only, 3 = base or handset.
    var hasAnsweringSystem: Int = 3

    // Whether the phone has a voice-guided setup process.
    var voiceGuidedSetup: Bool = false

    // The type of answering system. 0 = tape cassettes, 1 = digital.
    var answeringSystemType: Int = 1

    // What messages are deleted when deleting all. 0 = not supported (handset-only answering system phones only), 1 = all, 2 = all old, 3 = when no new.
    var allMessageDeletion: Int = 1

    // The type of answering system remote access code. 0 = factory set, 1 = partially-selectable, 2 = fully selectable.
    var remoteAccessCodeType: Int = 2

    // Whether the remote access code is common to all lines.
    var remoteAccessCodeCommonToAllLines: Bool = false

    // When the answering system plays a message day/time stamp. 0 = never (no clock), 1 = before message, 2 = after message.
    var answeringSystemMessageTimestamp: Int = 2

    // Whether the base has a message list.
    var hasMessageList: Bool = false

    // The button layout for multi-line phone answering systems. 0 = separate buttons for each line, 1 = line selection button.
    var answeringSystemMultilineButtonLayout: Int = 0

    // Whether the answering system is supported on cell lines.
    var answeringSystemForCellLines: Bool = false

    // Whether the answering system has call recording. 0 = not supported, 1 = without notification, 2 = intermittent beeps, 3 = spoken notification.
    var hasCallRecording: Int = 0

    // The type of answering system menu on the base. 0 = none (cordless phones with handset-accessible answering systems only), 1 = voice prompts, 2 = display menu.
    var answeringSystemMenuOnBase: Int = 0

    // Where the greeting can be managed from on a cordless phone with an answering system that's accessible by both the base and handsets. 0 = base only, 1 = handset only, 2 = base or handset.
    var greetingRecordingOnBaseOrHandset: Int = 1

    // Whether the answering system has greeting slots/schedules.
    var greetingSlotsAndSchedules: Bool = false

    // Whether the answering system has message alert by call.
    var hasMessageAlertByCall: Bool = false

    // Whether the answering system can record voice memos.
    var canRecordVoiceMemos: Bool = false

    // The number of mailboxes for the answering system.
    var numberOfMailboxes: Int = 1

    // Whether mailboxes can be password-protected (only if the base has a keypad or the answering system is only handset-accessible).
    var mailboxPasswordProtection: Bool = false

    // Whether the phone has an auto-attendant system/each cordless device has a personal mailbox that's stored in the base.
    var hasAutoAttendantAndPersonalMailboxes: Bool = false

    // Whether the answering system marks the corresponding caller ID list entry as having left a message.
    var answeringSystemMarksCallerIDListEntries: Bool = false

    // Whether the answering system can be set to answer but not record messages.
    var hasGreetingOnlyMode: Bool = true

    // The type of "new voicemail" detection method. 0 = no indication, 1 = FSK tones, 2 = stutter dial tone, 3 = 1 and 2, 4 = NEON, 5 = polarity reversal, 6 = 1 and 3, 7 = selectable.
    var voicemailIndication: Int = 3

    // Whether the base has voicemail quick dial. 0 = not supported, 1 = button, 2 = speed dial 1 (only if the base has a keypad), 3 = main menu item, 4 = message menu item, 5 = main menu item and button.
    var voicemailQuickDial: Int = 0

    // Whether the phone can store voicemail feature codes for answering system-style access.
    var voicemailFeatureCodes: Bool = false

    // Whether the base has a speakerphone.
    var hasBaseSpeakerphone: Bool = false

    // Whether a handset placed on the base can be picked up during a call on the base speakerphone to switch to the handset.
    var hasPickUpToSwitch: Bool = true

    // Whether the base can be used to dial during a call on the handset like on a corded phone.
    var dialWithBaseDuringHandsetCall: Bool = false

    // How the phone handles picking up the handset or base during a call (not when picking up a cordless device during a call on another cordless device). 0 = not supported, 1 = move call, 2 = conference call.
    var handsetToBaseCallPickupBehavior: Int = 2

    // Whether the base has a keypad.
    var hasBaseKeypad: Bool = false

    // Whether the keypad can be locked.
    var hasKeypadLock: Bool = false

    // Whether the phone has talking caller ID.
    var hasTalkingCallerID: Bool = false

    // Whether digits dialed on the keypad are announced.
    var hasTalkingKeypad: Bool = false

    // Whether names or numbers in the phonebook are announced as they're scrolled through.
    var hasTalkingPhonebook: Bool = false

    // The type of base display. 0 = none, 1 = LED message counter, 2 = LCD message counter with status items, 3 = segmented monochrome, 4 = traditional monochrome, 5 = full-dot monochrome with status items, 6 = full-dot monochrome, 7 = color, 8 = monochrome touchscreen, 9 = color touchscreen.
    var baseDisplayType: Int = 0

    // Whether the base display has brightness and/or contrast adjustment. 0 = none, 1 = contrast, 2 = brightness, 3 = brightness and contrast.
    var baseDisplayBrightnessContrastAdjustment: Int = 0

    // The color themes available on the base display. 0 = white and black, 1 = colors, 2 = colors + white, 3 = colors + black, 4 = colors + white and black.
    var baseDisplayColorThemes: Int = 0

    // The type of cordless base menu. 0 = none, 1 = partial, 2 = full.
    var cordlessBaseMenuType: Int = 0

    // Whether the base display can tilt.
    var baseDisplayCanTilt: Bool = false

    // Whether the base menu shows multiple items at once.
    var baseMenuMultiItems: Bool = false

    // Whether the base shows multiple entries at once.
    var baseDisplayMultiEntries: Bool = false

    // The layout of the base main menu if menus show multiple items. 0 = single item, 1 = list, 2 = carousel, 3 = grid.
    var baseMainMenuLayout: Int = 0

    // Whether the base and/or cordless devices can be named. 0 = not supported, 1 = cordless devices only, 2 = base and cordless devices.
    var handsetRenaming: Int = 0

    // Whether the base has both a display and an LED message counter.
    var baseHasDisplayAndMessageCounter: Bool = false

    // The number of soft keys below the base display.
    var baseSoftKeysBottom: Int = 0

    // The number of soft keys on each side of the base display. For example, if this value is 3, there are 3 soft keys on the left and 3 on the right, making 6 total.
    var baseSoftKeysSide: Int = 0

    // The type of base navigation button. 0 = none, 1 = up/down, 3 = up/down/left/right.
    var baseNavigatorKeyType: Int = 0

    // Whether the base navigation button has shortcuts in standby.
    var baseNavigatorKeyStandbyShortcuts: Bool = false

    // The function of the base navigation button's center button. 0 = no center button, 1 = select, 2 = menu/select, 3 = play/stop, 4 = play/select, 5 = play/stop/select, 6 = other function.
    var baseNavigatorKeyCenterButton: Int = 0

    // Whether the base navigation button's left and right arrows function as the repeat and skip buttons.
    var baseNavigatorKeyLeftRightRepeatSkip: Bool = false

    // Whether the base navigation button's up and down arrows function as the volume buttons.
    var baseNavigatorKeyUpDownVolume: Bool = false

    // How many buttons are backlit. 0 = none, 1 = numbers only, 2 = numbers + some function buttons, 3 = numbers + all function buttons, 4 = numbers + navigation button, 5 = all buttons.
    var baseKeyBacklightAmount: Int = 0

    // The button layer that's backlit. 0 = background, 1 = foreground.
    var baseKeyBacklightLayer: Int = 0

    // The power source if corded. 0 = line power only, 1 = line + batteries, 2 = AC power, 3 = AC power with non-recharging battery backup, 4 = AC power with recharging battery backup.
    var cordedPowerSource: Int = 0

    // The form of power backup mode if cordless. 0 = external battery if available, 1 = handset placed on base if cordless or line power if corded/cordless, 2 = non-recharging batteries in base, 3 = recharging batteries in base.
    var cordlessPowerBackupMode: Int = 0

    // How functional the phone is on backup batteries if corded. 0 = memory retention only, 1 = basic, 2 = full.
    var cordedFunctionalityOnBackupBatteries: Int = 1

    // What happens when power returns during place-on-base power backup. 0 = reboot, 1 = don't reboot.
    var cordlessPowerBackupReturnBehavior: Int = 0

    // Whether dialing codes can be stored for phonebook transfer.
    var supportsPhonebookTransferDialingCodes: Bool = false

    // Whether the international code is among the available dialing formats when dialing from a list.
    var supportsDialingOfInternationalCode: Bool = false

    // Whether the phone supports adding the cell area code to 7-digit numbers dialed on the cell line or when editing the format of a cell phonebook entry for dialing.
    var supportsAddingOfCellAreaCode: Bool = false

    // Whether the phone has features related to local area codes. 0 = not supported, 1 = yours, 2 = yours + additional, 3 = auto-format
    var landlineLocalAreaCodeFeatures: Int = 0

    // Whether the phone can add the PBX line access number when making calls.
    var supportsAddingOfPBXLineAccessNumber: Bool = false

    // Whether the phone can play the cell phone's ringtone.
    var supportsCellRingtone: Bool = false

    // Whether the phone can show/announce/ring for cell phone alerts.
    var supportsCellAlerts: Bool = false

    // The ringtone used for the cell line on the base. 0 = none, 1 = landline ringtone, 2 = cell-line specific ringtone, 3 = selectable.
    var baseCellRingtone: Int = 1

    // Where contacts transferred from a cell phone go. 0 = not supported, 1 = home phonebook, 2 = separate cell phonebook.
    var bluetoothPhonebookTransfers: Int = 0

    // Whether phonebook transfer is possible using the base or without having to keep the transfer screen up on the handset.
    var baseOrInBackgroundPhonebookTransfer: Bool = false

    // Whether the phone can be used to access the cell phone's voice assistant.
    var hasCellPhoneVoiceControl: Bool = false

    // The base's phonebook capacity.
    var basePhonebookCapacity: Int = 50

    // How many numbers can be saved per phonebook entry.
    var numbersPerPhonebookEntry: Int = 1

    // The base's favorite entry capacity.
    var baseFavoriteEntriesCapacity: Int = 0

    // Whether audio tags can be recorded for phonebook entries.
    var phonebookAudioTags: Bool = false

    // Whether the phonebook supports groups.
    var baseSupportsPhonebookGroups: Bool = false

    // Whether ringtones can be assigned to phonebook entries/groups.
    var baseSupportsPhonebookRingtones: Bool = false

    // The base's caller ID list capacity.
    var baseCallerIDCapacity: Int = 50

    // The base's redial capacity.
    var baseRedialCapacity: Int = 0

    // How the phone handles redial when the other end is busy. 0 = not supported, 1 = reset line by pressing redial, 2 = auto-redial.
    var busyRedialMode: Int = 0

    // Whether redial during a call redials the last number or shows the redial list. 0 = not supported, 1 = last number, 2 = list.
    var redialDuringCall: Int = 1

    // The name displayed in the redial list. 0 = number only, 1 = from dialed entry, 2 = phonebook match.
    var redialNameDisplay: Int = 0

    // Whether the phone supports call waiting caller ID.
    var supportsCallWaiting: Bool = true

    // Whether the phone supports call restriction. 0 = not supported, 1 = disallow specific numbers, 2 = only allow emergency calls.
    var callRestriction: Int = 0

    // Whether a call from a phonebook entry shows with its name.
    var callerIDPhonebookMatch: Bool = true

    // The number of base speed dial locations.
    var baseSpeedDialCapacity: Int = 0

    // Whether the base has one-touch emergency calling buttons.
    var hasOneTouchEmergencyCalling: Bool = false

    // The number of one-touch dial buttons on the base.
    var baseOneTouchDialCapacity: Int = 0

    // Numbers per one-touch dial button on the base.
    var numbersPerOneTouchDialButton: Int = 1

    // The type of card for one-touch dial buttons. 0 = none, 1 = paper card/faceplate, 2 = dedicated one-touch dial entry display.
    var baseOneTouchDialCard: Int = 0

    // Whether the phone supports key expansion modules to add additional one-touch dial buttons.
    var baseOneTouchDialExpansionModulesSupported: Bool = false

    // Whether cordless devices can be assigned to the base one-touch dial buttons.
    var oneTouchDialSupportsHandsetNumbers: Bool = false

    // How phonebook entries are assigned to speed dial/one-touch dial buttons. 0 = manual only, 1 = copy, 2 = link.
    var speedDialPhonebookEntryMode: Int = 0

    // The phone's call block list capacity.
    var callBlockCapacity: Int = 0

    var callBlockSupportsPrefixes: Bool = false

    // What blocked callers hear. 0 = silence, 1 = traditional busy tone, 2 = custom busy tone, 3 = voice message.
    var blockedCallersHear: Int = 0

    // Whether the first ring can be suppressed.
    var hasFirstRingSuppression: Bool = false

    // Whether the phone has a one-touch call block button or quick call block menu item.
    var hasOneTouchCallBlock: Bool = false

    // Whether the phone allows everyone not in the phonebook to be blocked.
    var canBlockEveryoneNotInPhonebook: Bool = false

    // Whether the phone can block calls without a phone number (e.g. private).
    var canBlockNumberlessCalls: Bool = false

    // Whether the oldest call block entry is deleted when trying to add a new one when the list is full. 0 = never, 1 = without protection, 2 = with protection.
    var callBlockAutoDeletesOldestEntry: Int = 0

    // The number of pre-programmed call block entries.
    var callBlockPreProgrammedDatabaseEntryCount: Int = 0

    // Whether the phone supports call block pre-screening. 0 = none, 1 = ask for caller name, 2 = ask for code entry.
    var callBlockPreScreening: Int = 0

    // Whether call block pre-screening supports a custom greeting.
    var callBlockPreScreeningCustomGreeting: Bool = false

    // The capacity of the allowed names list.
    var callBlockPreScreeningAllowedNameCapacity: Int = 100

    // The capacity of the allowed numbers list.
    var callBlockPreScreeningAllowedNumberCapacity: Int = 100

    // Whether the allowed numbers are visible to the user or only used as a temporary allowed number database.
    var callBlockPreScreeningAllowedNumberListVisible: Bool = true

    // Whether the phone supports room monitor. 0 = not supported, 1 = room monitor calls destination, 1 = base/cordless device calls room monitor, 3 = room monitor calls destination when sound is detected.
    var roomMonitor: Int = 0

    // Where DTMF input from an external phone is handled when a cordless device makes a sound-activated room monitor call to a phone number. 0 = base, 1 = cordless device.
    var externalRoomMonitorAutomatedSystem: Int = 0

    // The maximum number of smart home devices that can be registered to the base.
    var smartHomeDevicesSupported: Int = 0

    // Whether calls can be answered by voice.
    var answerByVoice: Bool = false

    // The maximum number of smartphones or tablets that can be used as handsets over Wi-Fi.
    var smartphonesAsHandsetsOverWiFi: Int = 0

    // Whether the phone can play a SIT tone when this or any other phone/device on the line is answered.
    var outOfServiceToneOnAnswer: Bool = false

    // Whether one-ring scam calls are marked in the caller ID list.
    var scamCallDetection: Bool = false

    // Whether handsets can be registered by placing them on the base.
    var placeOnBaseAutoRegister: Bool = true

    // Whether the base supports wall mounting. 0 = not supported, 1 = holes on back, 2 = optional bracket, 3 = built-in bracket, 4 = desk/wall bracket.
    var wallMountability: Int = 1

    // Whether the base has antennas. 0 = hidden, 1 = telescopic, 2 = standard left, 3 = standard right, 4 = one on each side.
    var antennas: Int = 0

    // Whether the phone has preset music on hold.
    var musicOnHoldPreset: Bool = false

    // Whether the phone allows recording hold music.
    var musicOnHoldRecord: Bool = false

    // Whether the phone supports playing live audio for music on hold.
    var musicOnHoldLive: Bool = false

    // Whether the base has a similar size as chargers.
    var hasChargerSizeBase: Bool = false

    // The connection type for the landline. 0 = analog, 1 = digital, 2 = Ethernet VoIP, 3 = Wi-Fi VoIP, 4 = cellular, 5 = Ethernet/analog.
    var landlineConnectionType: Int = 0

    // Whether the power and line connections are consolidated into a single cord for the base.
    var usesSingleLinePowerFeed: Bool = false

    // The phone's grade. 0 = residential/small-business, 1 = hotel, 2 = large-business.
    var grade: Int = 0

    // Whether the phone allows communicating with other compatible phones to work like a PBX.
    var supportsPBXFeatures: Bool = false

    // What the user has connected the landline to. 0 = no line, 1 = copper line, 2 = VoIP modem/ATA, 3 = cell-to-landline Bluetooth adaptor, 4 = cellular jack/gateway, 5 = PBX, 6 = phone line simulator, 7 = multiple.
    var landlineConnectedTo: Int = 2

    // Where the phone is in the user's collection. 0 = active and working, 1 = active but broken, 2 = stored on a shelf and working, 3 = stored on a shelf and broken, 4 = stored in a box/bin and working, 5 = stored in a box/bin and broken.
    var storageOrSetup: Int = 0

    // The phone's backstory.
    var phoneDescription: String = String()

    // Whether the 7 key has Q and the 9 key has Z.
    var hasQZ: Bool = true

    // Whether the phone supports Power-over-Ethernet.
    var supportsPoE: Bool = false

    // Whether the user needed to replace the base or a cordless device/charger.
    var neededReplacements: Bool = false

    // How cell calls are rejected. 0 = not supported, 1 = button, 2 = when blocking, 3 = button or when blocking.
    var cellCallRejection: Int = 0

    // Whether the phone prompts for a cell line selection. 0 = manual only, 1 = based on connected cell phones, 2 = specific line or manual.
    var cellLineSelection: Int = 0

    // MARK: - Properties - Supported VoIP Audio Codecs

    // Whether the phone supports the U-law audio codec.
    var supportsULaw: Bool = true

    // Whether the phone supports the A-law audio codec.
    var supportsALaw: Bool = true

    // Whether the phone supports the Opus audio codec.
    var supportsOpus: Bool = true

    // Whether the phone supports the G.729 audio codec.
    var supportsG729: Bool = true

    // Whether the phone supports the G.723 audio codec.
    var supportsG723: Bool = true

    // Whether the phone supports the G.722 audio codec.
    var supportsG722: Bool = true

    // Whether the phone supports the G.726 audio codec.
    var supportsG726: Bool = true

    // Whether the phone supports the iLBC audio codec.
    var supportsILBC: Bool = true

    // MARK: - Properties - Transient (Non-Persistent) Properties

    @Transient
    var mainColorRed: Double {
        get { baseMainColorRed }
        set { baseMainColorRed = newValue }
    }

    @Transient
    var mainColorGreen: Double {
        get { baseMainColorGreen }
        set { baseMainColorGreen = newValue }
    }

    @Transient
    var mainColorBlue: Double {
        get { baseMainColorBlue }
        set { baseMainColorBlue = newValue }
    }

    @Transient
    var secondaryColorRed: Double {
        get { baseSecondaryColorRed }
        set { baseSecondaryColorRed = newValue }
    }

    @Transient
    var secondaryColorGreen: Double {
        get { baseSecondaryColorGreen }
        set { baseSecondaryColorGreen = newValue }
    }

    @Transient
    var secondaryColorBlue: Double {
        get { baseSecondaryColorBlue }
        set { baseSecondaryColorBlue = newValue }
    }

    @Transient
    var accentColorRed: Double {
        get { baseAccentColorRed }
        set { baseAccentColorRed = newValue }
    }

    @Transient
    var accentColorGreen: Double {
        get { baseAccentColorGreen }
        set { baseAccentColorGreen = newValue }
    }

    @Transient
    var accentColorBlue: Double {
        get { baseAccentColorBlue }
        set { baseAccentColorBlue = newValue }
    }

    // Protocol conformance adapters - KeyColorManipulatable requires generic property names
    @Transient
    var keyBackgroundColorRed: Double {
        get { baseKeyBackgroundColorRed }
        set { baseKeyBackgroundColorRed = newValue }
    }

    @Transient
    var keyBackgroundColorGreen: Double {
        get { baseKeyBackgroundColorGreen }
        set { baseKeyBackgroundColorGreen = newValue }
    }

    @Transient
    var keyBackgroundColorBlue: Double {
        get { baseKeyBackgroundColorBlue }
        set { baseKeyBackgroundColorBlue = newValue }
    }

    @Transient
    var keyForegroundColorRed: Double {
        get { baseKeyForegroundColorRed }
        set { baseKeyForegroundColorRed = newValue }
    }

    @Transient
    var keyForegroundColorGreen: Double {
        get { baseKeyForegroundColorGreen }
        set { baseKeyForegroundColorGreen = newValue }
    }

    @Transient
    var keyForegroundColorBlue: Double {
        get { baseKeyForegroundColorBlue }
        set { baseKeyForegroundColorBlue = newValue }
    }

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

    // Whether the model number ends in a dash followed by one or more digits.

    var modelNumberEndsInDashOrPlusFollowedByDigits: Bool {
        if let lastDashIndex = model.lastIndex(of: handsetNumberDigitRepresents == 1 ? "+" : "-") {
            let suffixStart = model.index(after: lastDashIndex)
            let suffix = model[suffixStart...]
            if !suffix.isEmpty && suffix.allSatisfy({ $0.isNumber }) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    // Whether one or more parts of the phone are broken and actively need replacements.
    var isBrokenNeedingReplacements: Bool {
        let baseIsBroken = storageOrSetup % 2 != 0
        let cordlessDevicesAreBroken = !cordlessHandsetsIHave.filter({$0.storageOrSetup % 2 != 0}).isEmpty
        return neededReplacements && (baseIsBroken || cordlessDevicesAreBroken)
    }

    @Transient
    var partsNeedingReplacement: String {
        let baseIsBroken = storageOrSetup % 2 != 0
        let brokenCordlessDevices = cordlessHandsetsIHave.filter({$0.storageOrSetup % 2 != 0})
        var cordlessDeviceNumbers: [String] = []
        for cordlessDevice in brokenCordlessDevices {
            cordlessDeviceNumbers.append("\(cordlessDevice.actualHandsetNumber)")
        }
        let formattedString = ListFormatter.localizedString(byJoining: [String](cordlessDeviceNumbers))
        if !baseIsBroken && !brokenCordlessDevices.isEmpty {
            return brokenCordlessDevices.count == 1 ? "Cordless Device \((cordlessDeviceNumbers.first)!)" : "Cordless Devices \(formattedString)"
        } else if baseIsBroken && !brokenCordlessDevices.isEmpty {
            return brokenCordlessDevices.count == 1 ? "Base and Cordless Device \((cordlessDeviceNumbers.first)!)" : "Base and Cordless Devices \(formattedString)"
        } else {
            return "Base"
        }
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

    // The total call block capacity (call block list + pre-blocked).
    @Transient
    var totalCallBlockCapacity: Int {
        return callBlockCapacity + callBlockPreProgrammedDatabaseEntryCount
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

    // Whether the phone is a slim corded phone with the ringer and other essential circuitry in the base.
    @Transient
    var isSlimCordedWithBaseCircuitry: Bool {
        return isSlimCorded && cordedRingerLocation == 0
    }

    // Whether the keypad is in the corded receiver or the phone is base-less.
    @Transient
    var keypadInReceiver: Bool {
        return (cordedPhoneType == 2 && dialLocation == 1) || cordedPhoneType == 4
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

    // Whether the phone is a DECT cordless phone.
    @Transient
    var isDECTCordless: Bool {
        guard let frequency = Phone.CordlessFrequency(rawValue: frequency) else { return false }
        return frequency.isDECT
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
        return cordlessHandsetsIHave.count >= maxCordlessHandsets + desksetHandsetCount
    }

    @Transient
    var desksets: [CordlessHandset] {
        return cordlessHandsetsIHave.filter { $0.cordlessDeviceType == 1 }
    }

    @Transient
    var cordlessDevicesRegisteredToDesksets: [CordlessHandset] {
        return cordlessHandsetsIHave.filter {
            $0.registeredTo == 1 }
    }

    // The maximum number of additional cordless handsets that can be added to a phone based on the maximum number of cordless handsets supported by each of this phone's cordless desksets.
    @Transient
    var desksetHandsetCount: Int {
        let desksets = cordlessHandsetsIHave.filter { $0.cordlessDeviceType == 1 }
        var count: Int = 0
        for deskset in desksets {
            count += deskset.desksetCordlessHandsetsSupported
        }
        return count
    }

    // Whether the user has added too many cordless devices (at least 1 more than maxCordlessHandsets) to the phone based on how many can be registered to its base.
    @Transient
    var tooManyCordlessDevices: Bool {
        return cordlessHandsetsIHave.count > maxCordlessHandsets + desksetHandsetCount
    }

    // Whether the phone takes AC power.
    @Transient
    var takesACPower: Bool {
        return isCordless || cordedPowerSource > 1
    }

    // Whether the base has a charging area for a cordless handset.
    @Transient
    var baseChargesHandset: Bool {
        return isCordless && !hasCordedReceiver && !hasTransmitOnlyBase
    }

    // Whether the phone is cordless or a push-button corded desk phone.
    @Transient
    var isCordlessOrPushButtonDesk: Bool {
        return isCordless || cordedPhoneType == 0
    }

    // Whether the phone is a push-button corded desk phone or a cordless phone with a dialing base.
    @Transient
    var isPushButtonDeskOrCordlessDialingBase: Bool {
        return cordedPhoneType == 0 || (isCordless && hasBaseKeypad)
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

    // Whether the phone is a business corded/cordless system (i.e., a 4-or-more-line system with a corded base that can accept 8 or more cordless handsets/desksets).
    @Transient
    var isBusinessCordedCordlessSystem: Bool {
        return isCordedCordless && maxCordlessHandsets >= 8 && numberOfLandlines >= 4
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

    // Whether the phone requires AC power or batteries for the selected "new voicemail" detection method.
    @Transient
    var requiresACPowerOrBatteriesForVoicemailIndication: Bool {
        return voicemailIndication == 1 || voicemailIndication == 2 || voicemailIndication == 3 || voicemailIndication == 6
    }

    // The following computed properties check whether the base and/or cordless devices of a cordless phone have a given feature. For corded phones, the cordless device checks don't apply.

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

    // Whether the base or any cordless handset/deskset supports wired headsets.
    @Transient
    var supportsWiredHeadsets: Bool {
        return baseSupportsWiredHeadsets || !cordlessHandsetsIHave.filter({$0.supportsWiredHeadsets}).isEmpty
    }

    // Whether the base or any cordless handset/deskset has a phonebook.
    @Transient
    var hasPhonebook: Bool {
        return basePhonebookCapacity > 0 || !cordlessHandsetsIHave.filter({$0.phonebookCapacity > 0}).isEmpty
    }

    // Whether the base or any cordless handset/deskset has a caller ID list.
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

    // MARK: - Protocol Conformance Adapters

    // BaseColorManipulatable protocol requires generic property names, but Phone uses "base" prefix
    @Transient
    var mainColorBinding: Binding<Color> { baseMainColorBinding }
    
    @Transient
    var secondaryColorBinding: Binding<Color> { baseSecondaryColorBinding }
    
    @Transient
    var accentColorBinding: Binding<Color> { baseAccentColorBinding }

    // MARK: - Initialization

    init(brand: String, model: String) {
        self.brand = brand
        self.model = model
    }

    // MARK: - Set Acquisition Year to Release Year

    // This method sets the phone's acquisition year to its release year.
    func setAcquisitionYearToReleaseYear() {
        acquisitionYear = releaseYear
    }

    // MARK: - Deselect Handset Number Digit

    // This method clears the handset number digit selection.
    func deselectHandsetNumberDigit() {
        handsetNumberDigit = nil
        handsetNumberDigitIndex = nil
    }

    // MARK: - Update All Cordless Devices' Place In Collection

    // This method updates the storageOrSetup property of all the phone's cordless devices.
    func updateAllCordlessDevicePlaceInCollection() {
        for handset in cordlessHandsetsIHave {
            handset.storageOrSetup = storageOrSetup
        }
    }

    // MARK: - Make Corded-Only

    // This method makes the phone corded-only.
    func makeCordedOnly() {
        cordlessHandsetsIHave.removeAll()
        chargersIHave.removeAll()
        numberOfIncludedCordlessHandsets = 0
    }

    // MARK: - Set Key Color To Main

    // This method sets the key background color to the main color.
    func setKeyBackgroundColorToMain() {
        baseKeyBackgroundColorRed = baseMainColorRed
        baseKeyBackgroundColorGreen = baseMainColorGreen
        baseKeyBackgroundColorBlue = baseMainColorBlue
    }

    // MARK: - Set Key Backlight Color To Display Backlight and Vice Versa

    // This method sets the key backlight color to the display backlight color.
    func setKeyBacklightColorToDisplayBacklight() {
        baseKeyBacklightColorRed = baseDisplayBacklightColorRed
        baseKeyBacklightColorGreen = baseDisplayBacklightColorGreen
        baseKeyBacklightColorBlue = baseDisplayBacklightColorBlue
    }

    // This method sets the display backlight color to the key backlight color.
    func setDisplayBacklightColorToKeyBacklight() {
        baseDisplayBacklightColorRed = baseKeyBacklightColorRed
        baseDisplayBacklightColorGreen = baseKeyBacklightColorGreen
        baseDisplayBacklightColorBlue = baseKeyBacklightColorBlue
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
            deselectHandsetNumberDigit()
        } else if array[digitIndex] != String(digit) {
            deselectHandsetNumberDigit()
        }
    }

    func handsetNumberDigitRepresentsChanged(oldValue: Int, newValue: Int) {
        guard handsetNumberDigit != nil else { return }
        if newValue == 1 && oldValue == 0 {
            numberOfIncludedCordlessHandsets += 1
        }
        if newValue == 0 && oldValue == 1 {
            numberOfIncludedCordlessHandsets -= 1
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
            if allMessageDeletion == 0 {
                allMessageDeletion = 1
            }
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
        if newValue == currentYear {
            acquisitionYear = currentYear
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

    func cordedPowerSourceChanged(oldValue: Int, newValue: Int) {
        if newValue == 0 && requiresACPowerOrBatteriesForVoicemailIndication {
            voicemailIndication = 0
        }
    }

    func isCordlessChanged(oldValue: Bool, newValue: Bool) {
        if newValue {
            if dialMode == 0 {
                dialMode = 2
            }
            if !hasBaseKeypad {
                if baseOneTouchDialCard == 2 {
                    baseOneTouchDialCard = 1
                }
                baseOneTouchDialExpansionModulesSupported = false
            }
            cordedPhoneType = 0
            cordedRingerType = 1
            cordedPowerSource = 0
            if baseKeyBacklightAmount > 6 {
                baseKeyBacklightAmount = 5
            }
            basePhoneType = 0
        } else {
            if cordedPowerSource == 0 && requiresACPowerOrBatteriesForVoicemailIndication {
                voicemailIndication = 0
            }
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
        for handset in cordlessHandsetsIHave {
            if handset.handsetNumber + 1 > newValue && handset.registeredTo == 0 {
                handset.registeredTo = 1
            }
        }
        if newValue > 1 {
            if locatorButtons == 0 {
                deregistration = 1
            }
        }
        if newValue < 8 {
            hasAutoAttendantAndPersonalMailboxes = false
        }
        if newValue + desksetHandsetCount < numberOfIncludedCordlessHandsets && newValue >= 1 {
            numberOfIncludedCordlessHandsets = newValue
        }
    }

    func frequencyChanged(oldValue: Double, newValue: Double) {
        if newValue > Phone.CordlessFrequency.analog1_7MHzOver46MHz.rawValue && cordlessDeviceLinkingMethod == 0 {
            cordlessDeviceLinkingMethod = baseChargesHandset ? 3 : 2
        }
        if !isDigitalCordless {
            if cordlessDeviceLinkingMethod == 4 {
                cordlessDeviceLinkingMethod = baseChargesHandset ? 3 : 2
            }
            if maxCordlessHandsets > 1 {
                maxCordlessHandsets = -1
            }
            locatorButtons = 0
            deregistration = 1
        }
        if isDECTCordless && cordlessDeviceLinkingMethod < 4 {
            cordlessDeviceLinkingMethod = 4
        }
    }

    func cordlessDeviceLinkingMethodChanged(oldValue: Int, newValue: Int) {
        if newValue < 4 && maxCordlessHandsets > 1 {
            maxCordlessHandsets = Int.max
            hasTransmitOnlyBase = false
            cordedReceiverMainColorBinding.wrappedValue = .clear
            placeOnBaseAutoRegister = false
            deregistration = 0
            locatorButtons = 0
            for handset in cordlessHandsetsIHave {
                handset.fitsOnBase = true
            }
        }
        if newValue == 4 {
            for handset in cordlessHandsetsIHave {
                handset.ringsOnBase = true
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
            if cordlessDeviceLinkingMethod > 1 && cordlessDeviceLinkingMethod != 4 {
                cordlessDeviceLinkingMethod = 1
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
        if newValue <= 2 {
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
        if newValue == 7 || newValue == 9 {
            baseDisplayBacklightColorBinding.wrappedValue = .white
        }
        if newValue == 8 || newValue < 7 && baseDisplayBrightnessContrastAdjustment > 1 {
            baseDisplayBrightnessContrastAdjustment = 1
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
            if baseOneTouchDialCard == 2 {
                baseOneTouchDialCard = 1
            }
            baseOneTouchDialExpansionModulesSupported = false
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
            if cordlessDeviceLinkingMethod > 1 && cordlessDeviceLinkingMethod != 4 {
                cordlessDeviceLinkingMethod = 1
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
            if baseOneTouchDialCard > 1 {
                baseOneTouchDialCard = 0
            }
            baseOneTouchDialExpansionModulesSupported = false
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

    func checkForRegisteredDesksets() {
        if desksets.isEmpty {
            for cordlessDevice in cordlessDevicesRegisteredToDesksets {
                cordlessDevice.registeredTo = 0
            }
        }
    }

}
