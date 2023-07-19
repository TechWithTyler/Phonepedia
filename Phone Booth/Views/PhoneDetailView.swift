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
									return newValue > phone.maxCordlessHandsets
								}
							if phone.numberOfIncludedCordlessHandsets > phone.maxCordlessHandsets {
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
					if !phone.isCordless || phone.hasAnsweringSystem > 0 || phone.hasBaseSpeakerphone {
						Stepper("Base Ringtones: \(phone.baseRingtones)", value: $phone.baseRingtones, in: 1...25)
						Stepper("Base Music Ringtones: \(phone.baseMusicRingtones)", value: $phone.baseMusicRingtones, in: 0...25)
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
						Picker("Blocked Callers Hear", selection: $phone.blockedCallersHear) {
							Text("Silence").tag(0)
							Text("Busy Tone (custom)").tag(1)
							Text("Busy Tone (traditional)").tag(2)
							Text("Voice Prompt").tag(3)
						}
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
				}
				Section(header: Text("Call Block (pre-screening)"), footer: Text("Call block pre-screening asks callers to press a key so the phone can identify whether they're a human or a robot.\nCallers with numbers stored in the phone's allowed number list/database or phonebook, or callers whose caller ID names are stored in the phone's allowed name list, will always ring through.")) {
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
