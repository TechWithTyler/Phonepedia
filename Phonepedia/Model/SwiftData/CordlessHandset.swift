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
final class CordlessHandset: BaseHandsetChargerColorManipulatable, ChargeLightColorManipulatable, CordedReceiverColorManipulatable, KeyColorManipulatable {

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

    // MARK: - Cordless Handset Style Enum

    enum Style : String {

        case traditional = "Traditional"

        case futuristic = "Futuristic"

        case cellPhone = "Cell Phone-Style"

        case smartphone = "Smartphone-Style"

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

    // The default model number of a cordless device.
    @Transient
    static var mockModel: String = "MH12"

    // MARK: - Properties - Persistent Data

    // The ID of the cordless device.
    var id = UUID()

    // The phone the cordless device is assigned to.
	var phone: Phone?

    // The cordless device's brand.
	var brand: String

    // The cordless device's model number.
	var model: String

    // The index of the cordless device.
    var handsetNumber: Int = 0

    // The year the cordless device was released.
	var releaseYear: Int = currentYear - 1

    // The year the user purchased/acquired the cordless device.
    var acquisitionYear: Int = currentYear

    // Where the user acquired the phone. 0 = included with base/set, 1 = thrift store/sale, 2 = electronics store (new), 3 = online (used), 4 = online (new), 5 = gift.
    var whereAcquired: Int = 0

    // Whether the handset fits on the base.
	var fitsOnBase: Bool = true

    // The maximum number of bases the cordless device can register to.
	var maxBases: Int = 1

    // The type of cordless device. 0 = handset, 1 = deskset, 2 = headset/speakerphone.
	var cordlessDeviceType: Int = 0

    // The handset's style. 0 = traditional, 1 = futuristic, 2 = cell phone, 3 = smartphone.
    var handsetStyle: Int = 0

    // The main color's red component.
    var mainColorRed: Double = 0

    // The main color's green component.
    var mainColorGreen: Double = 0

    // The main color's blue component.
    var mainColorBlue: Double = 0

    // The secondary color's red component.
    var secondaryColorRed: Double = 0

    // The secondary color's green component.
    var secondaryColorGreen: Double = 0

    // The secondary color's blue component.
    var secondaryColorBlue: Double = 0

    // The accent color's red component.
    var accentColorRed: Double = 0

    // The accent color's green component.
    var accentColorGreen: Double = 0

    // The accent color's blue component.
    var accentColorBlue: Double = 0

    // The display backlight color's red component.
    var displayBacklightColorRed: Double = 255

    // The display backlight color's green component.
    var displayBacklightColorGreen: Double = 255

    // The display backlight color's blue component.
    var displayBacklightColorBlue: Double = 255

    // The display backlight color's alpha component.
    var displayBacklightColorAlpha: Double = 1

    // The key foreground color's red component.
    var keyForegroundColorRed: Double = 255

    // The key foreground color's green component.
    var keyForegroundColorGreen: Double = 255

    // The key foreground color's blue component.
    var keyForegroundColorBlue: Double = 255

    // The key background color's red component.
    var keyBackgroundColorRed: Double = 0

    // The key background color's green component.
    var keyBackgroundColorGreen: Double = 0

    // The key background color's blue component.
    var keyBackgroundColorBlue: Double = 0

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

    // The key backlight color's red component.
    var keyBacklightColorRed: Double = 0

    // The key backlight color's green component.
    var keyBacklightColorGreen: Double = 255

    // The key backlight color's blue component.
    var keyBacklightColorBlue: Double = 0

    // The charge light charging state color's red component.
    var chargeLightColorChargingRed: Double = 255

    // The charge light charging state color's green component.
    var chargeLightColorChargingGreen: Double = 0

    // The charge light charging state color's blue component.
    var chargeLightColorChargingBlue: Double = 0

    // The charge light charged state color's red component.
    var chargeLightColorChargedRed: Double = 0

    // The charge light charged state color's green component.
    var chargeLightColorChargedGreen: Double = 255

    // The charge light charged state color's blue component.
    var chargeLightColorChargedBlue: Double = 0

    // The charge light charged state color's alpha component.
    var chargeLightColorChargedAlpha: Double = 1

    // The cordless handset/deskset earpiece type.
    var earpieceType: Int = 0

    // Whether the cordless device has a charge light.
    var hasChargeLight: Bool = false

    // Whether the handset supports place-on-base power backup
    var supportsPlaceOnBasePowerBackup: Bool = true

    // Whether it's possible to dial before placing the handset on the base for power backup.
    var canDialThenPlaceOnBase: Bool = false

    // Whether the keys are locked on the handset placed on the base during a call when power returns.
    var keyLockWhenPowerReturns: Bool = false

    // The button type.
	var buttonType: Int = 0

    // How the ringer volume is adjusted.
    var ringerVolumeAdjustmentType: Int = 1

    // Whether the ringer can be turned off.
    var supportsRingerOff: Bool = true

    // The clock display type.
    var clock: Int = 1

    // Whether the cordless device backs up the time.
    var supportsTimeBackup: Bool = true

    // How the volume is adjusted.
    var volumeAdjustmentType: Int = 1

    // The display type.
	var displayType: Int = 2

    // Whether the display has brightness and/or contrast adjustment.
    var displayBrightnessContrastAdjustment: Int = 0

    // The color themes available on the display.
    var displayColorThemes: Int = 0

    // The location of the handset display. 0 = front, 1 = back, 2 = front and back.
    var displayLocation: Int = 0

    // How base settings are changed on the cordless device. 0 = not supported, 1 = base settings menu, 2 = handset/deskset/base selection.
    var baseSettingsChangeMethod: Int = 0

    // Whether the handset has dedicated answering system controls.
    var hasAnsweringSystemControls: Bool = false

    // The maximum number of cordless devices that can be registered to the deskset.
    var desksetCordlessHandsetsSupported: Int = 0

    // Where the cordless device is registered. 0 = base, 1 = deskset.
    var registeredTo: Int = 0

    // Whether the deskset display can tilt.
    var desksetDisplayCanTilt: Bool = false

    // Whether the handset/deskset shows multiple entries at once.
    var displayMultiEntries: Bool = false

    // Whether the menu shows multiple items at once.
    var menuMultiItems: Bool = false

    // The layout of the base main menu if menus show multiple items.
    var mainMenuLayout: Int = 0

    // The type of battery. 0 = pack with plug, 1 = pack with contacts, 2 = standard rechargeable.
    var batteryType: Int = 0

    // Whether the deskset supports backup batteries.
    var desksetSupportsBackupBatteries: Bool = true

    // Whether the deskset is a slim corded phone.
    var isSlimCordedDeskset: Bool = false

    // The corded receiver switch hook type.
    var switchHookType: Int = 0

    // The corded receiver hook type.
    var cordedReceiverHookType: Int = 0

    // The menu update mode. 0 = menus are determined by the base the handset/deskset is registered to, 1 = update in real time based on available features.
	var menuUpdateMode: Int = 0

    // Whether the cordless device has speakerphone.
	var hasSpeakerphone: Bool = true

    // The intercom auto-answer type.
    var intercomAutoAnswer: Int = 0

    // Whether the handset supports direct communication with other registered handsets without needing the base.
    var hasDirectCommunication: Bool = false

    // Whether the handset allows answering calls by simply picking it up off charge.
    var hasAutoAnswer: Bool = false

    // What happens when the handset is put on charge during a call. 0 = auto-hangup, 1 = switch to speakerphone/stay on call.
    var chargeDuringCall: Int = 0

    // Whether the handset sounds a tone when put on charge.
    var hasChargeTone: Bool = false

    // Whether the handset can be turned on and off.
    var canPowerOff: Bool = false

    // The type of line buttons. 0 = physical line buttons, 1 = soft keys.
	var lineButtons: Int = 0

    // Whether the cordless device has a visual ringer. 0 = none, 1 = ignore ring signal, 2 = follow ring signal.
	var visualRinger: Int = 0

    // The number of ringtones.
	var ringtones: Int = 5

    // The number of music/melody ringtones.
    var musicRingtones: Int = 5

    // Whether the handset has a vibrator motor.
    var hasVibratorMotor: Bool = false

    // The source for custom ringtones. 0 = not supported, 1 = recording only, 2 = audio files only, 3 = recording or audio files.
    var customRingtonesSource: Int = 0

    // The ringtone used for intercom.
    var intercomRingtone: Int = 0

    // Whether the handset rings when on the base of a single-handset "security code set by placing on base" phone with the base ringer turned on.
    var ringsOnBase: Bool = true

    // The type of silent mode for the cordless device.
    var silentMode: Int = 0

    // Whether a join/leave tone sounds when the base/another cordless device joins/leaves a call.
    var joinLeaveTone: Int = 0

    // Whether phonebook entries/groups can break through silent mode.
    var supportsSilentModeBypass: Bool = false

    // The number of one-touch dial buttons.
	var oneTouchDialCapacity: Int = 0

    // Whether the cordless device has one-touch emergency calling buttons.
    var hasOneTouchEmergencyCalling: Bool = false

    // The number of speed dial locations.
	var speedDialCapacity: Int = 0

    // The redial capacity.
	var redialCapacity: Int = 5

    // How the handset/deskset handles redial when the other end is busy.
    var busyRedialMode: Int = 0

    // The number of soft keys below or above the display.
	var softKeys: Int = 0

    // Whether the soft keys shown in standby are customizable.
    var standbySoftKeysCustomizable: Bool = false

    // The type of navigation button. 0 = none, 1 = up/down, 2 = up/down/left/right button, 3 = up/down/left/right joystick, 4 = up/down side buttons, left/right face buttons.
	var navigatorKeyType: Int = 1

    // Whether the navigation button's up and down arrows function as the volume buttons.
	var navigatorKeyUpDownVolume: Bool = true

    // Whether the navigation button has shortcuts in standby.
	var navigatorKeyStandbyShortcuts: Bool = true

    // The function of the navigation button's center button. 0 = no center button, 1 = select, 2 = menu/select, 3 = middle soft key (if the handset/deskset has 3 soft keys), 4 = other function.
	var navigatorKeyCenterButton: Int = 0

    // Whether the handset has side volume buttons.
	var sideVolumeButtons: Bool = false

    // What happens when buttons are pressed while on charge. 0 = locked, 1 = prompt to pick up, 2 = normal.
    var buttonPressOnChargeBehavior: Int = 0

    // How many buttons are backlit.
	var keyBacklightAmount: Int = 0

    // The button layer that's backlit.
    var keyBacklightLayer: Int = 0

    // Whether the handset/deskset supports wired headsets.
	var supportsWiredHeadsets: Bool = false

    // The type of answering system menu. 0 = none, 1 = settings only, doesn't require link to base to access, 2 = settings only, requires link to base to access, 3 = full, doesn't require link to base to access, 4 = full, requires link to base to access.
	var answeringSystemMenu: Int = 3

    // Whether the handset has a message list.
    var hasMessageList: Bool = false

    // Whether the handset has voicemail quick dial.
    var voicemailQuickDial: Int = 0

    // The phonebook capacity.
	var phonebookCapacity: Int = 0

    // How many numbers can be saved per phonebook entry.
    var numbersPerPhonebookEntry: Int = 1

    // Whether the phonebook supports groups.
    var supportsPhonebookGroups: Bool = false

    // Whether ringtones can be assigned to phonebook entries/groups.
    var supportsPhonebookRingtones: Bool = false

    // The favorite entry capacity.
    var favoriteEntriesCapacity: Int = 0

    // The caller ID list capacity.
    var callerIDCapacity: Int = 0

    // Whether a call from a phonebook entry shows with its name.
	var callerIDPhonebookMatch: Bool = false

    // Whether the handset/deskset uses the base's phonebook instead of or in addition to its own.
	var usesBasePhonebook: Bool = true

    // Whether the handset/deskset uses the base's caller ID list instead of its own.
	var usesBaseCallerID: Bool = true

    // Whether the handset/deskset uses the base's speed dial entries instead of its own.
	var usesBaseSpeedDial: Bool = false

    // Whether the handset/deskset uses the base's one-touch dial entries instead of its own.
	var usesBaseOneTouchDial: Bool = false

    // How phonebook entries are assigned to speed dial/one-touch dial.
	var speedDialPhonebookEntryMode: Int = 0

    // Whether redial during a call redials the last number or shows the redial list.
    var redialDuringCall: Int = 1

    // The name displayed in the redial list.
	var redialNameDisplay: Int = 0

    // Whether pressing the cell button in standby shows the redial list or prompts to dial the number. 0 = dial number, 1 = redial list.
    var standbyCellCallDialing: Int = 0

    // Whether the handset/deskset prompts for a cell line selection.
    var cellLineSelection: Int = 0

    // The maximum number of Bluetooth headphones that can be paired.
	var bluetoothHeadphonesSupported: Int = 0

    // Whether the handset/deskset supports Bluetooth cell phonebook transfers.
	var bluetoothPhonebookTransfers: Bool = false

    // The maximum number of key finders that can be registered.
	var keyFindersSupported: Int = 0

    // Whether the handset has an antenna. 0 = hidden, 1 = short antenna for style, 2 = long antenna for transmission, 3 = telescopic..
	var antenna: Int = 0

    // Whether the handset has an alarm. 0 = not supported, 1 = ringtone, 2 = ringtone or voice.
    var alarm: Int = 0

    // Whether the keypad can be locked.
    var hasKeypadLock: Bool = false

    // Whether the cordless device has talking caller ID.
    var hasTalkingCallerID: Bool = false

    // Whether digits dialed on the keypad are announced.
    var hasTalkingKeypad: Bool = false

    // Whether names or numbers in the phonebook are announced as they're scrolled through.
    var hasTalkingPhonebook: Bool = false

    // The type of audible low battery alert. 0 = beep during call, 1 = beep after hangup, 2 = beep in standby, 3 = beep or announce after hangup, 4 = beep or announce after hangup or in standby.
    var audibleLowBatteryAlert: Int = 0

    // The type of talk/off buttons. 0 = single talk/off button or switch, 1 = talk and off, 2 = talk/flash and off, 3 = talk/speaker and off, 4 = line buttons + off.
    var talkOffButtonType = 1

    // The talk/off button layer that's colored. 0 = background, 1 = foreground.
    var talkOffColorLayer: Int = 1

    // The speakerphone button layer that's colored. 0 = background, 1 = foreground.
    var speakerphoneColorLayer: Int = 1

    // Whether the speakerphone button lights up when active.
    var hasSpeakerphoneButtonLight: Bool = false

    // Where the cordless device is in the user's collection.
    var storageOrSetup: Int = 0

    // Whether the 7 key has Q and the 9 key has Z.
    var hasQZ: Bool = true

    // MARK: - Properties - Transient (Non-Persistent) Properties

    // The age of the cordless device.
    @Transient
    var age: String {
        let age = currentYear - releaseYear
        let yearsSingularOrPlural = age == 1 ? "year" : "years"
        return "\(age) \(yearsSingularOrPlural)"
    }

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

    // The actual number of the cordless device, which is handsetNumber (the index of the cordless device) + 1.
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
        Color.rgbaQuantizedAlphaBinding(get: { [self] in (displayBacklightColorRed, displayBacklightColorGreen, displayBacklightColorBlue, displayBacklightColorAlpha) }, set: { [self] r, g, b, a in
            displayBacklightColorRed = r
            displayBacklightColorGreen = g
            displayBacklightColorBlue = b
            displayBacklightColorAlpha = a
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

    // MARK: - Set Corded Receiver Colors to Deskset Colors

    // This method sets the corded receiver outer color to the main color.
    func setCordedReceiverOuterColorToMain() {
        cordedReceiverMainColorRed = mainColorRed
        cordedReceiverMainColorGreen = mainColorGreen
        cordedReceiverMainColorBlue = mainColorBlue
        cordedReceiverMainColorAlpha = 1
    }

    // This method sets the corded receiver inner color to the secondary color.
    func setCordedReceiverInnerColorToSecondary() {
        cordedReceiverSecondaryColorRed = secondaryColorRed
        cordedReceiverSecondaryColorGreen = secondaryColorGreen
        cordedReceiverSecondaryColorBlue = secondaryColorBlue
    }

    // This method sets the corded receiver accent color to the deskset accent color.
    func setCordedReceiverAccentColorToDesksetAccent() {
        cordedReceiverAccentColorRed = accentColorRed
        cordedReceiverAccentColorGreen = accentColorGreen
        cordedReceiverAccentColorBlue = accentColorBlue
    }

    // MARK: - Set Key Background Color to Main

    // This method sets the key background color to the main color.
    func setKeyBackgroundColorToMain() {
        keyBackgroundColorRed = mainColorRed
        keyBackgroundColorGreen = mainColorGreen
        keyBackgroundColorBlue = mainColorBlue
    }

    // MARK: - Set Key Backlight Color to Display Backlight and Vice Versa

    // This method sets the key backlight color to the display backlight color.
    func setKeyBacklightColorToDisplayBacklight() {
        keyBacklightColorRed = displayBacklightColorRed
        keyBacklightColorGreen = displayBacklightColorGreen
        keyBacklightColorBlue = displayBacklightColorBlue
    }

    // This method sets the display backlight color to the key backlight color.
    func setDisplayBacklightColorToKeyBacklight() {
        displayBacklightColorRed = keyBacklightColorRed
        displayBacklightColorGreen = keyBacklightColorGreen
        displayBacklightColorBlue = keyBacklightColorBlue
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
            if let phone = phone {
                phone.checkForRegisteredDesksets()
            }
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
        if newValue == currentYear {
            acquisitionYear = currentYear
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
        newHandset.desksetCordlessHandsetsSupported = self.desksetCordlessHandsetsSupported
        newHandset.registeredTo = self.registeredTo
        // 4. Return the duplicated handset.
        return newHandset
    }

}
