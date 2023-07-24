//
//  PhoneDetailView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/16/23.
//

import SwiftUI
import SwiftData

struct PhoneDetailView: View {

	@Bindable var phone: Phone

	var body: some View {
		Form {
			Section(header: Text("General")) {
				HStack {
					Spacer()
					PhoneImage(phone: phone, thumb: false)
					Spacer()
				}
				Button {
					// Action here
				} label: {
					Text("Take Photo…")
				}
				Button {
					// Action here
				} label: {
					Text("Select From Library…")
				}
				Button {
					// Action here
				} label: {
					Text("Use Placeholder…")
				}
				TextField("Brand", text: $phone.brand)
				TextField("Model", text: $phone.model)
				Text("Phone type: \(phoneTypeText)")
				Stepper("Number of Included Cordless Handsets (0 if corded only): \(phone.numberOfIncludedCordlessHandsets)", value: $phone.numberOfIncludedCordlessHandsets, in: 0...Int.max-1)
				if phone.isCordless {
					Group {
						Stepper("Maximum Number of Cordless Handsets (-1 if using \"security codes must match\"): \(phone.maxCordlessHandsets)", value: $phone.maxCordlessHandsets, in: -1...15)
							.onChange(of: phone.maxCordlessHandsets) { oldValue, newValue in
								if newValue == 0 && oldValue == -1 {
									phone.maxCordlessHandsets = 1
								} else if newValue == 0 && oldValue == 1 {
									phone.maxCordlessHandsets = -1
								}
							}
							.sensoryFeedback(.error, trigger: phone.numberOfIncludedCordlessHandsets) { oldValue, newValue in
								return newValue > phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1
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
					Picker("Power Backup", selection: $phone.cordedPowerSource) {
						Text("External Battery Backup (if available)").tag(0)
						if phone.isCordedCordless {
							Text("Line Power").tag(1)
						} else {
							Text("Place Handset On Base").tag(1)
						}
						Text("Batteries in Base (non-recharging)").tag(2)
						Text("Batteries in Base (recharging)").tag(3)
					}
				}
			}
			Section(header: Text("Speakerphone/Base Keypad/Base Intercom")) {
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
				}
				if phone.isCordless {
					Toggle(isOn: $phone.hasHandsetSpeakerphone) {
						Text("Has Handset Speakerphone")
					}
					if !phone.hasBaseSpeakerphone && !phone.isCordedCordless {
						Toggle(isOn: $phone.hasBaseIntercom) {
							Text("Has Base Intercom")
						}
					}
				}
			}
			Section(header: Text("Ringers")) {
				if phone.isCordless {
					Stepper("Handset Ringtones: \(phone.handsetRingtones)", value: $phone.handsetRingtones, in: 1...25)
					Stepper("Handset Music Ringtones: \(phone.handsetMusicRingtones)", value: $phone.handsetMusicRingtones, in: 0...25)
					Toggle(isOn: $phone.canChangeHandsetIntercomTone) {
						Text("Can Change Handset Intercom Tone")
					}
					if !phone.canChangeHandsetIntercomTone {
						Toggle(isOn: $phone.handsetHasSeparateIntercomTone) {
							Text("Handset Has Separate Intercom Tone")
						}
					}
				}
				if !phone.isCordless || (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) || phone.hasBaseSpeakerphone {
					Stepper("Base Ringtones: \(phone.baseRingtones)", value: $phone.baseRingtones, in: !phone.isCordless || phone.hasBaseSpeakerphone ? 1...25 : 0...25)
					if phone.baseRingtones > 0 {
						Stepper("Base Music Ringtones: \(phone.baseMusicRingtones)", value: $phone.baseMusicRingtones, in: 0...25)
					}
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
						Text("Display Menu").tag(1)
					}
				} else if phone.isCordless && (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) {
					Picker("Answering System Menu (base)", selection: $phone.answeringSystemMenuOnBase) {
						Text("None").tag(0)
						Text("Voice Prompts").tag(1)
						Text("Display Menu").tag(2)
					}
				}
				if phone.isCordless && phone.hasAnsweringSystem > 1 {
					Picker("Answering System Menu (handset)", selection: $phone.answeringSystemMenuOnHandset) {
						Text("Settings Only (doesn't require link to base").tag(0)
						Text("Settings Only (requires link to base)").tag(1)
						Text("Full (doesn't require link to base").tag(2)
						Text("Full (requires link to base)").tag(3)
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
					Text("Greeting Only, sometimes called Announce Only or Answer Only, answers calls but doesn't accept incoming messages. Some phones allow you to record a separate greeting for both modes, allowing you to easily switch between modes without having to re-record your greeting each time.")
						.font(.footnote)
						.foregroundStyle(.secondary)
					Toggle("Has Message Alert by Call", isOn: $phone.hasMessageAlertByCall)
					Text("This feature allows the answering system to call out to a stored phone number each time a new message is left, so you don't have to constantly be calling to check for new messages while you're away.")
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
				Picker("\"New Voicemail\" Detection Method", selection: $phone.voicemailIndication) {
					Text("None").tag(0)
					Text("Frequency-Shift-Keying (FSK) Tones").tag(1)
					Text("Listen For Stutter Dial Tones").tag(2)
					Text("FSK and Stutter Dial Tone").tag(3)
				}
				Text("""
A phone's voicemail indicator works in one or both of the following ways:
• Your phone company may send special tones, called Frequency-Shift-Keying (FSK) tones to the phone whenever a new voicemail is left, and another when all new voicemails are played, to tell the phone to turn on or off its voicemail indicator.
• The phone may go off-hook for a few seconds periodically or when you hang up or it stops ringing, to listen for a stutter dial tone ("bee-bee-bee-beeeeeeeep") which your phone company may use as an audible indication of new voicemails.
""")
				Picker("Voicemail Quick Dial", selection: $phone.voicemailQuickDial) {
					Text("None").tag(0)
					Text("Button").tag(1)
					Text("Speed Dial 1").tag(2)
					Text("Message Menu Item").tag(3)
					Text("Main Menu Item").tag(4)
					Text("Main Menu Item and Button").tag(5)
				}
				Text("You can store your voicemail access number (e.g. *99) into the phone and quickly dial it using a button or menu item.")
					.font(.footnote)
					.foregroundStyle(.secondary)
			}
			Section(header: Text("Redial")) {
				if phone.isCordless {
					TextField("Redial Capacity (handset)", value: $phone.handsetRedialCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
				}
				if phone.hasBaseSpeakerphone || !phone.isCordless || phone.isCordedCordless {
					TextField(phone.isCordless ? "Redial Capacity (base)" : "Redial Capacity", value: $phone.handsetRedialCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
				}
				Picker("Redial Name Display", selection: $phone.redialNameDisplay) {
					Text("None").tag(0)
					Text("Phonebook Match").tag(1)
					Text("From Dialed Entry").tag(2)
				}
				if phone.redialNameDisplay == 1 && phone.hasSharedPhonebook {
					Text("Although the redial list is stored in the handset, it may still require you to be in range of the base if the handset doesn't have a fallback to display entries without their names.")
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
			}
			Section(header: Text("Phonebook")) {
				if phone.isCordless {
					TextField("Phonebook Capacity (handset)", value: $phone.handsetPhonebookCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
					if phone.handsetPhonebookCapacity == 0 && phone.basePhonebookCapacity > 0 {
						Text("Phonebook is stored in the base and is shared by the base and all registered handsets.")
							.font(.footnote)
							.foregroundStyle(.secondary)
					}
				}
				TextField(phone.isCordless ? "Phonebook Capacity (base)" : "Phonebook Capacity", value: $phone.basePhonebookCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
					.keyboardType(.numberPad)
#endif
#if !os(xrOS)
					.scrollDismissesKeyboard(.interactively)
#endif
			}
			Section(header: Text("Caller ID")) {
				Toggle(isOn: $phone.hasTalkingCallerID) {
					Text("Talking Caller ID")
				}
				if phone.isCordless {
					TextField("Caller ID List Capacity (handset)", value: $phone.handsetCallerIDCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
					if phone.hasSharedPhonebook {
						Text("Caller ID list is stored in the base and is shared by the base and all registered handsets.")
							.font(.footnote)
							.foregroundStyle(.secondary)
					}
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
	   if phone.isCordless {
		   Stepper("Dial-Key Speed Dial Capacity (handset): \(phone.handsetSpeedDialCapacity)", value: $phone.handsetSpeedDialCapacity, in: 0...10)
	   }
	   Stepper(phone.isCordless ? "Dial-Key Speed Dial Capacity (base): \(phone.baseSpeedDialCapacity)" : "Dial-Key Speed Dial Capacity: \(phone.baseSpeedDialCapacity)", value: $phone.baseSpeedDialCapacity, in: 0...50)
	   if phone.baseSpeedDialCapacity > 10 {
		   Text("Speed dial locations 11-\(phone.baseSpeedDialCapacity) are accessed by pressing the speed dial button and then entering/scrolling to the desired location number.")
			   .font(.footnote)
			   .foregroundStyle(.secondary)
	   }
	   if phone.isCordless {
		   Stepper("One-Touch/Memory Dial (handset): \(phone.handsetOneTouchDialCapacity)", value: $phone.handsetOneTouchDialCapacity, in: 0...4)
	   }
	   Stepper(phone.isCordless ? "One-Touch/Memory Dial (base): \(phone.baseOneTouchDialCapacity)" : "One-Touch Dial: \(phone.baseOneTouchDialCapacity)", value: $phone.baseOneTouchDialCapacity, in: 0...20)
	   if phone.isCordless && phone.baseOneTouchDialCapacity > 0 {
		   Toggle("Base One-Touch/Memory Dial Supports Handset Numbers", isOn: $phone.oneTouchDialSupportsHandsetNumbers)
	   }
	   if phone.isCordless && phone.handsetSpeedDialCapacity == phone.baseSpeedDialCapacity {
		   Toggle("Handsets and Base Share Speed Dials", isOn: $phone.hasSharedSpeedDial)
	   }
	   if phone.isCordless && phone.handsetOneTouchDialCapacity == phone.baseOneTouchDialCapacity {
		   Toggle("Handsets and Base Share One-Touch/Memory Dials", isOn: $phone.hasSharedOneTouchDial)
	   }
	   if (phone.basePhonebookCapacity > 0 && (phone.baseSpeedDialCapacity > 0 || phone.baseOneTouchDialCapacity > 0)) || (phone.isCordless && phone.handsetPhonebookCapacity > 0 && (phone.handsetSpeedDialCapacity > 0 || phone.handsetOneTouchDialCapacity > 0)) {
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
					Text("When a number prefix (e.g. an area code) is stored in the call block list, all numbers beginning with that prefix are blocked.")
						.font(.footnote)
						.foregroundStyle(.secondary)
					if phone.callBlockPreScreening == 0 {
						Toggle(isOn: $phone.hasFirstRingSuppression) {
							Text("Has First Ring Suppression")
						}
						Text("""
Suppressing the first ring means the phone won't ring:
• Until allowed caller ID is received.
• At all for calls from blocked numbers.
""")
						.font(.footnote)
						.foregroundStyle(.secondary)
					}
					Picker("Blocked Callers Hear", selection: $phone.blockedCallersHear) {
						Text("Silence").tag(0)
						Text("Busy Tone (custom)").tag(1)
						Text("Busy Tone (traditional)").tag(2)
						Text("Voice Prompt").tag(3)
					}
					Text("A custom busy tone is often the same one used for the intercom busy tone on \(phone.brand)'s cordless phones. A traditional busy tone is that of one of the countries where the phone is sold.")
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
					Text("Numbers in the pre-programmed call block database are not visible to the user and might be excluded from the caller ID list. Numbers from this database can be saved to the phonebook if they happen to become safe in the future.")
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
					TextField("Allowed Numbers Capacity", value: $phone.callBlockPreScreeningAllowedNumberCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
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
		.formStyle(.grouped)
#if os(macOS)
		.toggleStyle(.checkbox)
#else
		.toggleStyle(.switch)
#endif
		.textFieldStyle(.roundedBorder)
	}

	var phoneTypeText: String {
		if phone.isCordedCordless {
			return "Corded/Cordless"
		} else if phone.isCordless {
			return "Cordless"
		} else {
			return "Corded"
		}
	}
}

//#Preview {
//	PhoneDetailView(phone: Phone.preview)
//}
