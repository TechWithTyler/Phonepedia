//
//  PhoneDetailView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//

import SwiftUI
import SwiftData
import PhotosUI

struct PhoneDetailView: View {

	@Bindable var phone: Phone

	@State var selectedPhoto: PhotosPickerItem? = nil

	#if os(iOS)
	@State var takingPhoto: Bool = false
	#endif

	@State var showingResetAlert: Bool = false

	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("General")) {
					HStack {
						Spacer()
						PhoneImage(phone: phone, thumb: false)
						Spacer()
					}
					#if os(iOS)
					Button {
						takingPhoto = true
					} label: {
						Text("Take Photo…")
					}
					#endif
					PhotosPicker("Select From Library…", selection: $selectedPhoto)
						.onChange(of: selectedPhoto) { oldValue, newValue in
							updatePhonePhoto(oldValue: oldValue, newValue: newValue)
						}
					Button {
						showingResetAlert = true
					} label: {
						Text("Use Placeholder…")
					}
					TextField("Brand", text: $phone.brand)
					TextField("Model", text: $phone.model)
					Text("Phone type: \(phoneTypeText)")
					if phone.isCordless {
						Picker("Wireless Frequency", selection: $phone.frequency) {
							Section(header: Text("46-49MHz")) {
								Text("46-49MHz Analog or Older").tag(0)
							}
							Section(header: Text("900MHz")) {
								Text("900MHz Analog").tag(1)
								Text("900MHz Voice Scramble Analog").tag(2)
								Text("900MHz Digital").tag(3)
								Text("900MHz Digital Spread Spectrum (DSS)").tag(4)
							}
							Section(header: Text("2.4GHz")) {
								Text("2.4GHz Analog").tag(5)
								Text("2.4GHz/900MHz Analog").tag(6)
								Text("2.4GHz Digital").tag(7)
								Text("2.4GHz/900MHz Digital").tag(8)
								Text("2.4GHz Digital Spread Spectrum (DSS)").tag(7)
								Text("2.4GHz/900MHz Digital Spread Spectrum (DSS)").tag(8)
								Text("2.4GHz Digital Frequency-Hopping Spread Spectrum (FHSS)").tag(9)
								Text("2.4GHz/900MHz Digital Frequency-Hopping Spread Spectrum (FHSS)").tag(10)
							}
							Section(header: Text("5.8GHz")) {
								Text("5.8GHz Analog").tag(11)
								Text("5.8GHz/900MHz Analog").tag(12)
								Text("5.8GHz/2.4GHz Analog").tag(13)
								Text("5.8GHz Digital").tag(14)
								Text("5.8GHz/900MHz Digital").tag(15)
								Text("5.8GHz/2.4GHz Digital").tag(16)
								Text("5.8GHz Digital Spread Spectrum (DSS)").tag(17)
								Text("5.8GHz/900MHz Digital Spread Spectrum (DSS)").tag(18)
								Text("5.8GHz/2.4GHz Digital Spread Spectrum (DSS)").tag(19)
								Text("5.8GHz Digital Frequency-Hopping Spread Spectrum (FHSS)").tag(20)
								Text("5.8GHz/900MHz Digital Frequency-Hopping Spread Spectrum (FHSS)").tag(21)
								Text("5.8GHz/2.4GHz Digital Frequency-Hopping Spread Spectrum (FHSS)").tag(22)
							}
							Section(header: Text("DECT")) {
								Text("DECT (1.88-1.90GHz)").tag(23)
								Text("DECT (1.90-1.92GHz)").tag(24)
								Text("DECT 6.0 (1.92-1.93GHz)").tag(25)
							}
						}
						Toggle("Supports Range Extenders", isOn: $phone.supportsRangeExtenders)
						HStack {
							Image(systemName: "info.circle")
							Text("A range extender extends the range of the base its registered to. Devices communicating with the base choose the base or a range extender based on which has the strongest signal.")
						}
								.font(.footnote)
								.foregroundStyle(.secondary)
						if !phone.isCordedCordless {
							Toggle("Base Is Transmit-Only", isOn: $phone.hasTransmitOnlyBase)
							HStack {
								Image(systemName: "info.circle")
								Text("A transmit-only base doesn't have a charging area for a cordless handset and doesn't have a corded receiver. Sometimes these kinds of bases have speakerphone, but usually they only have a locator button and nothing else. A transmit-only base with no features on it is often called a \"hidden base\".")
							}
								.font(.footnote)
								.foregroundStyle(.secondary)
								.onChange(of: phone.hasTransmitOnlyBase) { oldValue, newValue in
									transmitOnlyBaseChanged(oldValue: oldValue, newValue: newValue)
								}
						}
						}
					Stepper("Number of Included Cordless Handsets (0 if corded only): \(phone.numberOfIncludedCordlessHandsets)", value: $phone.numberOfIncludedCordlessHandsets, in: 0...Int.max-1)
						.onChange(of: phone.isCordless) { oldValue, newValue in
							isCordlessChanged(oldValue: oldValue, newValue: newValue)
						}
					if phone.isCordless {
						Group {
							Stepper("Maximum Number of Cordless Handsets (-1 if using \"security codes must match\"): \(phone.maxCordlessHandsets)", value: $phone.maxCordlessHandsets, in: -1...15)
								.onChange(of: phone.maxCordlessHandsets) { oldValue, newValue in
									maxCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
								}
								.sensoryFeedback(.error, trigger: phone.numberOfIncludedCordlessHandsets) { oldValue, newValue in
									return newValue > phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1
								}
							if phone.maxCordlessHandsets == -1 {
								HStack {
									Image(systemName: "info.circle")
									Text("When placing the handset on the base, the handset and base exchange a digital security code, which makes sure the handset only communicates with that base. You can add as many handsets as you want--the base doesn't know or care how many handsets are being used on it.")
								}
								.foregroundStyle(.secondary)
								.font(.footnote)
							}
							if phone.numberOfIncludedCordlessHandsets > phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1 {
								HStack {
									Image(systemName: "exclamationmark.triangle")
										.symbolRenderingMode(.multicolor)
									Text("The base of the \(phone.brand) \(phone.model) can only register up to \(phone.maxCordlessHandsets) handsets (trying to register \(phone.numberOfIncludedCordlessHandsets)).")
								}
								.font(.callout)
								.foregroundStyle(.secondary)
							}
						}
						Picker("Charge Light", selection: $phone.chargeLight) {
							Text("None").tag(0)
							if !phone.hasTransmitOnlyBase {
								Text("Base Only").tag(1)
								Text("Base/Charger").tag(2)
							} else {
								Text("Charger").tag(2)
							}
							Text("Handset").tag(3)
						}
						if !phone.hasTransmitOnlyBase {
							Group {
								Picker("Base Charging Direction", selection: $phone.baseChargingDirection) {
									Text("Forward (stand up)").tag(0)
									Text("Forward (lean back)").tag(1)
									Text("Forward (lay down)").tag(2)
									Text("Backward (lay down)").tag(3)
									Text("Backward (stand up)").tag(4)
									Text("Backward (lean back)").tag(5)
									Text("Forward Or Backward Lay Down (reversible handset)").tag(6)
								}
								if !phone.isCordedCordless {
									Picker("Base Charge Contact Placement", selection: $phone.baseChargeContactPlacement) {
										Text("Bottom").tag(0)
										Text("Back").tag(1)
										Text("One On Each Side").tag(2)
									}
									Picker("Base Charge Contact Mechanism", selection: $phone.baseChargeContactMechanism) {
										Text("Press Down").tag(0)
										Text("Click").tag(1)
										Text("Inductive").tag(2)
									}
									ChargingContactInfoView()
									Toggle("Base Has Separate Data Contact", isOn: $phone.baseHasSeparateDataContact)
									HStack {
										Image(systemName: "info.circle")
										Text("""
  Most modern cordless phones pass data through the 2 charging contacts for various features including the following. However, many older cordless phones, especially 46-49MHz and 900MHz models, used a separate, 3rd contact for data.
  • Detecting the handset being placed on the base for registration.
  • Detecting the handset being lifted off the base to switch from the base speakerphone to the handset.
  In most cases, if the base has a charge light, the completion of the charge circuit turns it on, but sometimes that's handled by the separate data contact if the phone has one.
  """)
									}
									.font(.footnote)
									.foregroundStyle(.secondary)
								}
							}
						}
					}
				}
				PhonePartInfoView(phone: phone)
				Section(header: Text("Power")) {
					if !phone.isCordless {
						Picker("Power Source", selection: $phone.cordedPowerSource) {
							Text("Line Power Only").tag(0)
							Text("Batteries").tag(1)
							Text("AC Power").tag(2)
							Text("AC Power with Battery Backup (non-recharging)").tag(3)
							Text("AC Power with Battery Backup (recharging)").tag(4)
						}
					}
					if phone.isCordless {
						Picker("Power Backup", selection: $phone.cordlessPowerBackupMode) {
							Text("External Battery Backup (if available)").tag(0)
							if phone.isCordedCordless {
								Text("Line Power").tag(1)
							} else {
								if !phone.hasTransmitOnlyBase {
									Text("Place Handset On Base").tag(1)
								}
							}
							Text("Batteries in Base (non-recharging)").tag(2)
							Text("Batteries in Base (recharging)").tag(3)
						}
						.onChange(of: phone.cordlessPowerBackupMode) { oldValue, newValue in
							if newValue != 1 {
								phone.cordlessPowerBackupReturnBehavior = 0
							}
						}
						if phone.cordlessPowerBackupMode == 0 {
							HStack {
								Image(systemName: "info.circle")
								Text("You can plug an external battery into the base power port to use it when the power goes out.")
							}
							.font(.footnote)
							.foregroundStyle(.secondary)
						}
						if phone.cordlessPowerBackupMode == 3 {
							HStack {
								Image(systemName: "exclamationmark.triangle")
									.symbolRenderingMode(.multicolor)
								Text("If you use non-rechargeable batteries, you MUST remember to remove them from the base as soon as possible once power returns to prevent leakage!")
							}
							.font(.footnote)
							.foregroundStyle(.secondary)
						}
						if phone.cordlessPowerBackupMode == 1 && !phone.hasTransmitOnlyBase && !phone.isCordedCordless {
							Picker("When Power Returns", selection: $phone.cordlessPowerBackupReturnBehavior) {
								Text("Reboot/Refresh Handset Menus").tag(0)
								Text("Restore Full Functionality Without Rebooting").tag(1)
							}
							VStack(alignment: .leading) {
								HStack {
									Image(systemName: "info.circle")
									Text("When the power goes out, placing a charged handset on the base can give it power. None of the base buttons will work, however, the display/lights may flash to indicate the base is booting up. Features like the answering system and base Bluetooth aren't available while the handset is powering the base.")
								}
								if phone.cordlessHandsetsIHave.filter({$0.fitsOnBase}).isEmpty {
									HStack {
										Image(systemName: "exclamationmark.triangle")
											.symbolRenderingMode(.multicolor)
										Text("You must have at least one handset which fits on the base to use power backup!")
									}
								}
							}
							.font(.footnote)
							.foregroundStyle(.secondary)
						}
					}
				}
				Section(header: Text("Speakerphone/Intercom/Base Keypad")) {
					if !phone.isCordedCordless {
						Toggle(isOn: $phone.hasBaseSpeakerphone) {
							Text("Has Base Speakerphone")
						}
						.onChange(of: phone.hasBaseSpeakerphone) { oldValue, newValue in
							if newValue {
								phone.hasBaseIntercom = true
							}
						}
					}
					if !phone.isCordless || (phone.isCordless && phone.hasBaseSpeakerphone) {
						Toggle(isOn: $phone.hasBaseKeypad) {
							Text("Has Base Keypad")
						}
						HStack {
							Image(systemName: "info.circle")
							Text("Some cordless phones have a base speakerphone and keypad, which allow you to make calls if the handset isn't nearby or if it needs to charge. Bases with keypads are a great option for office spaces.")
								.foregroundStyle(.secondary)
								.font(.footnote)
						}
					}
					if phone.isCordless {
						Toggle(isOn: $phone.hasIntercom) {
							Text("Has Intercom")
						}
						if phone.hasIntercom && !phone.hasBaseSpeakerphone && !phone.isCordedCordless {
							Toggle(isOn: $phone.hasBaseIntercom) {
								Text("Has Base Intercom")
							}
						}
						if phone.hasIntercom && !phone.hasBaseIntercom && phone.cordlessHandsetsIHave.count <= 1 {
							Text("Intercom requires 2 or more handsets to be registered to the base.")
								.font(.footnote)
								.foregroundStyle(.secondary)
						}
					}
				}
				Section(header: Text("Ringers")) {
					if !phone.isCordless || (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) || phone.hasBaseSpeakerphone {
						Stepper("Base Ringtones: \(phone.baseRingtones)", value: $phone.baseRingtones, in: !phone.isCordless || phone.hasBaseSpeakerphone ? 1...25 : 0...25)
						if phone.baseRingtones > 0 {
							Stepper("Base Music Ringtones: \(phone.baseMusicRingtones)", value: $phone.baseMusicRingtones, in: 0...25)
						}
						Text("Total Ringtones: \(phone.baseRingtones + phone.baseMusicRingtones)")
					}
					if phone.isCordless && phone.hasBaseIntercom {
						Toggle(isOn: $phone.canChangeBaseIntercomTone) {
							Text("Can Change Base Intercom Tone")
						}
						if !phone.canChangeBaseIntercomTone {
							Toggle(isOn: $phone.baseHasSeparateIntercomTone) {
								Text("Base Has Separate Intercom Tone")
							}
						}
					}
				}
				Section(header: Text("Answering System/Voicemail")) {
					Picker("Answering System", selection: $phone.hasAnsweringSystem) {
						if phone.isCordless {
							Text("None").tag(0)
							Text("Base Only").tag(1)
							Text("Handset Only").tag(2)
							Text("Base or Handset").tag(3)
						} else {
							Text("No").tag(0)
							Text("Yes").tag(1)
						}
					}
					if !phone.isCordless && phone.hasAnsweringSystem == 1 {
						Picker("Answering System Menu", selection: $phone.answeringSystemMenuOnBase) {
							Text("Voice Prompts").tag(0)
							if phone.baseDisplayType > 0 {
								Text("Display Menu").tag(1)
							}
						}
					} else if phone.isCordless && (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) {
						Picker("Answering System Menu (base)", selection: $phone.answeringSystemMenuOnBase) {
							Text("None").tag(0)
							Text("Voice Prompts").tag(1)
							if phone.baseDisplayType > 0 {
								Text("Display Menu").tag(2)
							}
						}
					}
					if phone.hasAnsweringSystem == 3 {
						Picker("Greeting Management From", selection: $phone.greetingRecordingOnBaseOrHandset) {
							Text("Base Only").tag(0)
							Text("Handset Only").tag(1)
							Text("Base or Handset").tag(2)
						}
					}
					if phone.hasAnsweringSystem > 0 {
						Toggle("Has Greeting Only Mode", isOn: $phone.hasGreetingOnlyMode)
						HStack {
							Image(systemName: "info.circle")
							Text("Greeting Only, sometimes called Announce Only or Answer Only, answers calls but doesn't accept incoming messages. Some phones allow you to record a separate greeting for both modes, allowing you to easily switch between modes without having to re-record your greeting each time.")
						}
							.font(.footnote)
							.foregroundStyle(.secondary)
						Toggle("Has Message Alert by Call", isOn: $phone.hasMessageAlertByCall)
						HStack {
							Image(systemName: "info.circle")
							Text("This feature allows the answering system to call out to a stored phone number each time a new message is left, so you don't have to constantly be calling to check for new messages while you're away.")
						}
							.font(.footnote)
							.foregroundStyle(.secondary)
					}
					Picker("\"New Voicemail\" Detection Method", selection: $phone.voicemailIndication) {
						Text("None").tag(0)
						Text("Frequency-Shift-Keying (FSK) Tones").tag(1)
						Text("Listen For Stutter Dial Tones").tag(2)
						Text("FSK and Stutter Dial Tone").tag(3)
					}
					HStack {
						Image(systemName: "info.circle")
						Text("""
A phone's voicemail indicator works in one or both of the following ways:
• Your phone company may send special tones, called Frequency-Shift-Keying (FSK) tones to the phone whenever a new voicemail is left, and another when all new voicemails are played, to tell the phone to turn on or off its voicemail indicator. You can't hear these tones unless you use a device to listen in on the phone line without picking it up (e.g. a butt-set phone in monitor mode).
• The phone may go off-hook for a few seconds periodically or when you hang up or it stops ringing, to listen for a stutter dial tone ("bee-bee-bee-beeeeeeeep") which your phone company may use as an audible indication of new voicemails.
""")
					}
					.font(.footnote)
					.foregroundStyle(.secondary)
					Picker("Voicemail Quick Dial", selection: $phone.voicemailQuickDial) {
						Text("None").tag(0)
						Text("Button").tag(1)
						Text("Speed Dial 1").tag(2)
						Text("Message Menu Item").tag(3)
						Text("Main Menu Item").tag(4)
						Text("Main Menu Item and Button").tag(5)
					}
					HStack {
						Image(systemName: "info.circle")
						Text("You can store your voicemail access number (e.g. *99) into the phone and quickly dial it using a button or menu item.")
					}
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
				Section(header: Text("Display/Backlight/Buttons")) {
					Picker("Button Type", selection: $phone.buttonType) {
						Text("Spaced").tag(0)
						Text("Spaced with Click Feel").tag(1)
						Text("Some Spaced, Some Diamond-Cut").tag(2)
						Text("Some Spaced with Click Feel, Some Diamond-Cut").tag(3)
						Text("Diamond-Cut (no space between buttons, click feel)").tag(4)
					}
					Picker(phone.isCordless ? "Display Type (base)" : "Display Type", selection: $phone.baseDisplayType) {
						Text("None").tag(0)
						if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
							Text("LED Message Counter").tag(1)
							Text("LCD Message Counter With Status Items").tag(2)
						}
						Text("Monochrome Display (traditional)").tag(3)
						Text("Monochrome Display (full-dot with status items)").tag(4)
						Text("Monochrome Display (full-dot)").tag(5)
						Text("Color Display").tag(6)
					}
					.onChange(of: phone.baseDisplayType) { oldValue, newValue in
						baseDisplayTypeChanged(oldValue: oldValue, newValue: newValue)
					}
					if phone.baseDisplayType > 2 && phone.baseDisplayType < 6 {
						TextField("Base Display Backlight Color", text: $phone.baseDisplayBacklightColor)
					}
					if phone.baseDisplayType >= 3 {
						Toggle("Base Has LED Message Counter In Addition To Display", isOn: $phone.baseHasDisplayAndMessageCounter)
					}
					if phone.baseDisplayType == 1 || phone.baseHasDisplayAndMessageCounter {
						TextField("LED Message Counter Color", text: $phone.baseLEDMessageCounterColor)
					}
					if phone.baseDisplayType > 0 {
						Picker("Base Navigation Button Type", selection: $phone.baseNavigatorKeyType) {
							Text("None").tag(0)
							Text("Up/Down").tag(1)
							Text("Up/Down/Left/Right").tag(3)
						}
						Picker("Base Navigation Button Center Button", selection: $phone.baseNavigatorKeyType) {
							Text("None").tag(0)
							Text("Select").tag(1)
							Text("Menu/Select").tag(2)
							if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
								Text("Play").tag(3)
								Text("Play/Select").tag(4)
							}
							Text("Other Function").tag(5)
						}
						Toggle("Base Navigation Button Up/Down for Volume", isOn: $phone.baseNavigatorKeyUpDownVolume)
						if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
							Toggle("Base Navigation Button Left/Right for Repeat/Skip", isOn: $phone.baseNavigatorKeyLeftRightRepeatSkip)
						}
						Toggle("Base Navigation Button Standby Shortcuts", isOn: $phone.baseNavigatorKeyStandbyShortcuts)
						if phone.baseDisplayType > 2 {
							Stepper("Base Soft Keys (bottom): \(phone.baseSoftKeysBottom)", value: $phone.baseSoftKeysBottom, in: 0...4)
								.onChange(of: phone.baseSoftKeysBottom) { oldValue, newValue in
									baseSoftKeysBottomChanged(oldValue: oldValue, newValue: newValue)
								}
							Stepper("Base Soft Keys (side): \(phone.baseSoftKeysBottom)", value: $phone.baseSoftKeysBottom, in: 0...3)
								.onChange(of: phone.baseSoftKeysSide) { oldValue, newValue in
									baseSoftKeysSideChanged(oldValue: oldValue, newValue: newValue)
								}
							SoftKeyExplanationView()
							HStack {
								Image(systemName: "info.circle")
								Text("Side soft keys are often used for programmable functions or speed dials in standby or one-touch menu selections in menus. For example, in a menu with 5 options, instead of scrolling up or down through the menu and then pressing the select button, you can press the corresponding side soft key.")
							}
								.font(.footnote)
								.foregroundStyle(.secondary)
						}
					}
					Picker("Button Backlight Type", selection: $phone.baseKeyBacklightAmount) {
						Text("None").tag(0)
						Text("Numbers Only").tag(1)
						Text("Numbers + Some Function Buttons").tag(2)
						Text("Numbers + All Function Buttons").tag(2)
						Text("Numbers + Navigation Button").tag(3)
						Text("All Buttons").tag(3)
					}
					if phone.baseKeyBacklightAmount > 0 {
						TextField("Button Backlight Color", text: $phone.baseKeyBacklightColor)
					}
					TextField("Button Foreground Color", text: $phone.baseKeyForegroundColor)
					TextField("Button Background Color", text: $phone.baseKeyBackgroundColor)
				}
				Section(header: Text("Audio Devices (e.g. headsets)")) {
					if !phone.isCordless || phone.hasBaseSpeakerphone {
						Toggle("Base Supports Wired Headsets", isOn: $phone.baseSupportsWiredHeadsets)
						Picker("Maximum Number Of Bluetooth Headphones (base)", selection: $phone.baseBluetoothHeadphonesSupported) {
							Text("None").tag(0)
							Text("1").tag(1)
							Text("2").tag(2)
							Text("4").tag(4)
						}
					}
				}
				Section(header: Text("Landline")) {
					Picker("Number Of Lines", selection: $phone.numberOfLandlines) {
						Text("1").tag(1)
						Text("2").tag(2)
						Text("4").tag(4)
					}
					HStack {
						Image(systemName: "info.circle")
						Text("On a 2- or 4-line phone, you can either plug each line into a separate jack, or use a single jack for 2 lines. For example, to plug a 2-line phone into a single 2-line jack, you would plug into the line 1/2 jack, or to plug into 2 single-line jacks, you would plug into both the line 1 and line 2 jacks. To use the one-jack-for-both-lines method, you need to make sure the phone cord has 4 copper contacts instead of just 2. With some phones, the included line cords are color-coded so you can easily tell which line they're for (e.g. black for line 1 and green for line 2).")
					}
						.font(.footnote)
						.foregroundStyle(.secondary)
					Picker("Landline In Use Status On Base", selection: $phone.landlineInUseStatusOnBase) {
						Text("None").tag(0)
						Text("Light").tag(1)
						if phone.baseDisplayType > 1 {
							Text("Display").tag(2)
							Text("Display and Light").tag(3)
						}
					}
					if phone.landlineInUseStatusOnBase == 1 {
						Toggle("Landline In Use Light Follows Ring Signal", isOn: $phone.landlineInUseVisualRingerFollowsRingSignal)
						HStack {
							Image(systemName: "info.circle")
							Text("An in use light that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. An in use light that ignores the ring signal starts flashing when the ring signal starts and continues flashing for as long as the base is indicating an incoming call.")
						}
							.font(.footnote)
							.foregroundStyle(.secondary)
					}
				}
				Section(header: Text("Bluetooth Cell Phone Linking")) {
					Picker("Maximum Number Of Paired Cell Phones", selection: $phone.baseBluetoothCellPhonesSupported) {
						Text("None/Phonebook Transfers Only").tag(0)
						Text("1").tag(1)
						Text("2").tag(2)
						Text("4").tag(4)
						Text("5").tag(5)
						Text("10").tag(10)
						Text("15").tag(15)
					}
					if phone.baseBluetoothCellPhonesSupported > 0 {
						Picker("Cell Line In Use Status On Base", selection: $phone.cellLineInUseStatusOnBase) {
							Text("None").tag(0)
							Text("Light").tag(1)
							if phone.baseDisplayType > 1 {
								Text("Display and Light").tag(2)
							}
						}
						Picker("Cell Line Only Behavior", selection: $phone.cellLineOnlyBehavior) {
							Text("Optional \"No Line\" Alert").tag(0)
							Text("Auto-Suppressed \"No Line\" Alert").tag(1)
							Text("Cell Line Only Mode").tag(2)
						}
						HStack {
							Image(systemName: "info.circle")
							Text("If you use only cell lines, the \"no line\" alert will be suppressed automatically or can be supressed manually, depending on the phone. A dedicated cell line only mode allows the phone to disable most landline-related features.")
						}
						.foregroundStyle(.secondary)
						.font(.footnote)
						Toggle("Has Cell Phone Voice Control", isOn: $phone.hasCellPhoneVoiceControl)
						HStack {
							Image(systemName: "info.circle")
							Text("You can talk to your cell phone voice assistant (e.g. Siri or Google Now) using the base or handset.")
						}
						.foregroundStyle(.secondary)
						.font(.footnote)
					}
				}
				Group {
					if phone.hasBaseSpeakerphone || !phone.isCordless || phone.isCordedCordless {
						Section(header: Text("Redial")) {
							TextField(phone.isCordless ? "Redial Capacity (base)" : "Redial Capacity", value: $phone.baseRedialCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
								.keyboardType(.numberPad)
#endif
#if !os(xrOS)
								.scrollDismissesKeyboard(.interactively)
#endif
							if phone.baseRedialCapacity > 1 && phone.basePhonebookCapacity > 0 {
								Picker("Redial Name Display", selection: $phone.redialNameDisplay) {
									Text("None").tag(0)
									Text("Phonebook Match").tag(1)
									Text("From Dialed Entry").tag(2)
								}
							}
						}
					}
					Section(header: Text("Phonebook")) {
						TextField(phone.isCordless ? "Phonebook Capacity (base)" : "Phonebook Capacity", value: $phone.basePhonebookCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
							.keyboardType(.numberPad)
#endif
#if !os(xrOS)
							.scrollDismissesKeyboard(.interactively)
#endif
						if phone.basePhonebookCapacity > 100 {
							Picker("Bluetooth Phonebook Transfers", selection: $phone.bluetoothPhonebookTransfers) {
								if phone.baseBluetoothCellPhonesSupported == 0 {
									Text("Not Supported").tag(0)
								}
								Text("To Home Phonebook").tag(1)
								Text("To Separate Cell Phonebook").tag(2)
							}
							.onChange(of: phone.baseBluetoothCellPhonesSupported) {
								newValue, oldValue in
								baseBluetoothCellPhonesSupportedChanged(oldValue: oldValue, newValue: newValue)
							}
						}
					}
					Section(header: Text("Caller ID")) {
						if phone.basePhonebookCapacity > 0 {
							Toggle(isOn: $phone.callerIDPhonebookMatch) {
								Text("Caller ID Uses Matching Phonebook Entry Name")
							}
						}
						Toggle(isOn: $phone.hasTalkingCallerID) {
							Text("Talking Caller ID")
						}
						TextField(phone.isCordless ? "Caller ID List Capacity (base)" : "Caller ID List Capacity", value: $phone.baseCallerIDCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
							.keyboardType(.numberPad)
#endif
#if !os(xrOS)
							.scrollDismissesKeyboard(.interactively)
#endif
					}
					Section(header: Text("Speed Dial"), footer: Text(
   """
   Speed dial is usually used by holding down the desired number key or by pressing a button (usually called "Auto") followed by the desired number key. One-touch/memory dial is when the phone has dedicated speed dial buttons which either start dialing immediately when pressed, or which display/announce the stored number which can be dialed by then going off-hook. Some phones tie the one-touch/memory dial buttons to the first few speed dial locations (e.g. a phone with 10 speed dials (1-9 and 0) and memory dial A-C might use memory dial A-C as a quicker way to dial the number in speed dial 1-3.
   
   The speed dial entry mode describes how phonebook entries are saved to speed dial locations and whether they allow numbers to be manually entered. "Copy" means the phonebook entry will be copied to the speed dial location, and any changes made to the phonebook entry won't apply to the speed dial entry. "Link" means the speed dial entry is tied to the corresponding phonebook entry, so changing the phonebook entry will change the speed dial entry and vice versa, and the speed dial entry will be deleted if the corresponding phonebook entry is deleted.
   
   By assigning a handset number to a cordless phone base's one-touch dial button, you can press it to quickly intercom/transfer a call to that handset.
   """)) {
	   Stepper(phone.isCordless ? "Dial-Key Speed Dial Capacity (base): \(phone.baseSpeedDialCapacity)" : "Dial-Key Speed Dial Capacity: \(phone.baseSpeedDialCapacity)", value: $phone.baseSpeedDialCapacity, in: 0...50)
	   if phone.baseSpeedDialCapacity > 10 {
		   HStack {
			   Image(systemName: "info.circle")
			   Text("Speed dial locations 11-\(phone.baseSpeedDialCapacity) are accessed by pressing the speed dial button and then entering/scrolling to the desired location number.")
		   }
			   .font(.footnote)
			   .foregroundStyle(.secondary)
	   }
	   Stepper(phone.isCordless ? "One-Touch/Memory Dial (base): \(phone.baseOneTouchDialCapacity)" : "One-Touch Dial: \(phone.baseOneTouchDialCapacity)", value: $phone.baseOneTouchDialCapacity, in: 0...20)
	   if phone.isCordless && phone.baseOneTouchDialCapacity > 0 {
		   Toggle("Base One-Touch/Memory Dial Supports Handset Numbers", isOn: $phone.oneTouchDialSupportsHandsetNumbers)
	   }
	   if (phone.basePhonebookCapacity > 0 && (phone.baseSpeedDialCapacity > 0 || phone.baseOneTouchDialCapacity > 0)) {
		   Picker("Speed Dial Entry Mode", selection: $phone.speedDialPhonebookEntryMode) {
			   Text("Manual or Phonebook (copy)").tag(0)
			   Text("Phonebook Only (copy)").tag(1)
			   Text("Phonebook Only (link)").tag(2)
		   }
	   }
   }
					Section(header: Text("Call Block (manual)")) {
						TextField("Call Block List Capacity", value: $phone.callBlockCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
							.keyboardType(.numberPad)
#endif
#if !os(xrOS)
							.scrollDismissesKeyboard(.interactively)
#endif
						if phone.callBlockCapacity > 0 {
							Toggle(isOn: $phone.callBlockSupportsPrefixes) {
								Text("Can Block Number Prefixes")
							}
							HStack {
								Image(systemName: "info.circle")
								Text("When a number prefix (e.g. an area code) is stored in the call block list, all numbers beginning with that prefix are blocked.")
							}
								.font(.footnote)
								.foregroundStyle(.secondary)
							if phone.callBlockPreScreening == 0 {
								Toggle(isOn: $phone.hasFirstRingSuppression) {
									Text("Has First Ring Suppression")
								}
								HStack {
									Image(systemName: "info.circle")
									Text("""
Suppressing the first ring means the phone won't ring:
• Until allowed caller ID is received.
• At all for calls from blocked numbers.
When the first ring is suppressed, the number of rings you hear will be one less than the number of rings of the answering system/voicemail service.
""")
								}
								.font(.footnote)
								.foregroundStyle(.secondary)
							}
							Picker("Blocked Callers Hear", selection: $phone.blockedCallersHear) {
								Text("Silence").tag(0)
								Text("Busy Tone (custom)").tag(1)
								Text("Busy Tone (traditional)").tag(2)
								Text("Voice Prompt").tag(3)
							}
							HStack {
								Image(systemName: "info.circle")
								Text("A custom busy tone is often the same one used for the intercom busy tone on \(phone.brand)'s cordless phones. A traditional busy tone is that of one of the countries where the phone is sold.")
							}
									.font(.footnote)
								.foregroundStyle(.secondary)
							Toggle(isOn: $phone.hasOneTouchCallBlock) {
								Text("Has One-Touch Call Block")
							}
						}
						TextField("Pre-Programmed Call Block Database Entry Count", value: $phone.callBlockPreProgrammedDatabaseEntryCount, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
							.keyboardType(.numberPad)
#endif
#if !os(xrOS)
							.scrollDismissesKeyboard(.interactively)
#endif
						if phone.callBlockPreProgrammedDatabaseEntryCount > 0 {
							HStack {
								Image(systemName: "info.circle")
								Text("Numbers in the pre-programmed call block database are not visible to the user and might be excluded from the caller ID list. Numbers from this database can be saved to the phonebook if they happen to become safe in the future.")
							}
								.font(.footnote)
								.foregroundStyle(.secondary)
						}
					}
					Section(header: Text("Call Block (pre-screening)"), footer: Text("Call block pre-screening asks callers to press a key so the phone can identify whether they're a human or a robot.\nCallers with numbers stored in the phone's allowed number list/database or phonebook, or callers whose caller ID names are stored in the phone's allowed name list, will always ring through. Asking for the caller name allows you to hear the caller's real name in their own voice when you pick up\(phone.hasTalkingCallerID ? " or as the caller ID announcement" : String()).")) {
						Picker("Mode", selection: $phone.callBlockPreScreening) {
							Text("Not Supported").tag(0)
							Text("Caller Name").tag(1)
							Text("Code").tag(2)
						}
						if phone.callBlockPreScreening > 0 {
							if phone.hasAnsweringSystem == 0 {
								HStack {
									Image(systemName: "info.circle")
									Text("Calls can't go to a voicemail service once answered by a call block pre-screening system.")
								}
									.font(.footnote)
									.foregroundStyle(.secondary)
							}
							Toggle("Supports Custom Greeting", isOn: $phone.callBlockPreScreeningCustomGreeting)
							TextField("Allowed Numbers Capacity", value: $phone.callBlockPreScreeningAllowedNumberCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
								.keyboardType(.numberPad)
#endif
#if !os(xrOS)
								.scrollDismissesKeyboard(.interactively)
#endif
							Toggle("Allowed Numbers List Visible To User", isOn: $phone.callBlockPreScreeningAllowedNumberListVisible)
							TextField("Allowed Names Capacity", value: $phone.callBlockPreScreeningAllowedNumberCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
								.keyboardType(.numberPad)
#endif
#if !os(xrOS)
								.scrollDismissesKeyboard(.interactively)
#endif
						}
					}
				}
			}
			.formStyle(.grouped)
#if os(macOS)
			.toggleStyle(.checkbox)
#else
			.toggleStyle(.switch)
#endif
			.textFieldStyle(.roundedBorder)
		}
		#if os(iOS)
		.sheet(isPresented: $takingPhoto) {
			CameraViewController(view: self, phone: phone)
		}
		#endif
		.alert("Reset photo?", isPresented: $showingResetAlert) {
			Button(role: .destructive) {
				phone.photoData = Phone.previewPhotoData
				showingResetAlert = false
			} label: {
				Text("Delete")
			}
			Button(role: .cancel) {
				showingResetAlert = false
			} label: {
				Text("Cancel")
			}
		}
	}

	var phoneTypeText: String {
		if phone.isCordedCordless {
			return "Corded/Cordless"
		} else if phone.isCordless {
			if phone.hasTransmitOnlyBase {
				return "Cordless with Transmit-Only Base"
			}
			return "Cordless"
		} else {
			return "Corded"
		}
	}

	func updatePhonePhoto(oldValue: PhotosPickerItem?, newValue: PhotosPickerItem?) {
		guard newValue != nil else { return }
		Task {
			if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
				phone.photoData = data
				selectedPhoto = nil
			} else {
				fatalError("Photo picker error!")
			}
		}
	}

	func transmitOnlyBaseChanged(oldValue: Bool, newValue: Bool) {
		if newValue {
			for handset in phone.cordlessHandsetsIHave {
				handset.fitsOnBase = false
			}
			phone.baseHasSeparateDataContact = false
			phone.baseChargeContactMechanism = 0
			phone.baseChargeContactPlacement = 0
			phone.baseChargingDirection = 0
			if phone.cordlessPowerBackupMode == 1 {
				phone.cordlessPowerBackupMode = 0
			}
		}
	}

	func isCordlessChanged(oldValue: Bool, newValue: Bool) {
		if !newValue {
			phone.hasTransmitOnlyBase = false
			phone.supportsRangeExtenders = false
			phone.baseChargingDirection = 0
			phone.baseChargeContactMechanism = 0
			phone.baseChargeContactPlacement = 0
			phone.baseHasSeparateDataContact = false
			phone.cordlessHandsetsIHave.removeAll()
			phone.chargersIHave.removeAll()
		}
	}

	func baseDisplayTypeChanged(oldValue: Int, newValue: Int) {
		if newValue <= 1 {
			phone.baseSoftKeysBottom = 0
			phone.baseSoftKeysSide = 0
		}
		if newValue < 3 || newValue > 5 {
			phone.baseDisplayBacklightColor = String()
		}
	}

	func maxCordlessHandsetsChanged(oldValue: Int, newValue: Int) {
		if newValue == -1 {
			for handset in phone.cordlessHandsetsIHave {
				handset.fitsOnBase = true
			}
		}
		if newValue == 0 && oldValue == -1 {
			phone.maxCordlessHandsets = 1
		} else if newValue == 0 && oldValue == 1 {
			phone.maxCordlessHandsets = -1
		}
	}

	func baseSoftKeysBottomChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue == 1 {
			phone.baseSoftKeysBottom = 2
		} else if oldValue == 2 && newValue == 1 {
			phone.baseSoftKeysBottom = 0
		}
	}

	func baseSoftKeysSideChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue == 1 {
			phone.baseSoftKeysSide = 2
		} else if oldValue == 2 && newValue == 1 {
			phone.baseSoftKeysSide = 0
		}
	}

	func baseBluetoothCellPhonesSupportedChanged(oldValue: Int, newValue: Int) {
		if oldValue == 0 && newValue > 0 {
			phone.bluetoothPhonebookTransfers = 1
		}
	}

}

//#Preview {
//	PhoneDetailView(phone: Phone.preview)
//}
