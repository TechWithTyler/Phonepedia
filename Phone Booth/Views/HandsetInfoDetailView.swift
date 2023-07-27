//
//  HandsetInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct HandsetInfoDetailView: View {

	@Binding var handset: CordlessHandset

	var handsetNumber: Int

	@State var generalExpanded: Bool = true

	var body: some View {
		if let phone = handset.phone {
			Form {
				Section(header: Text("General")) {
					Text("Registered as: Handset \(handsetNumber)")
					TextField("Brand", text: $handset.brand)
					TextField("Model", text: $handset.model)
					TextField("Color", text: $handset.color)
					Toggle(isOn: $handset.hasSpeakerphone) {
						Text("Has Speakerphone")
					}
				}
				Section(header: Text("Ringers")) {
					Stepper("Ringtones: \(handset.ringtones)", value: $handset.ringtones, in: 1...25)
					Stepper("Music Ringtones: \(handset.musicRingtones)", value: $handset.musicRingtones, in: 0...25)
					Toggle(isOn: $handset.canChangeIntercomTone) {
						Text("Can Change Intercom Tone")
					}
					if !handset.canChangeIntercomTone {
						Toggle(isOn: $handset.hasSeparateIntercomTone) {
							Text("Has Separate Intercom Tone")
						}
					}
				}
				Section(header: Text("Display/Backlight")) {
					Picker("Display Type", selection: $handset.displayType) {
						Text("None").tag(0)
						Text("Monochrome Display (traditional)").tag(1)
						Text("Monochrome Display (full-dot with status items)").tag(2)
						Text("Monochrome Display (full-dot)").tag(3)
						Text("Color").tag(4)
					}
				}
				Section(header: Text("Audio Devices")) {
					Toggle("Supports Wired Headsets", isOn: $handset.supportsWiredHeadsets)
					Picker("Maximum Number Of Bluetooth Headphones", selection: $handset.bluetoothHeadphonesSupported) {
						Text("None").tag(0)
						Text("1").tag(1)
						Text("2").tag(2)
						Text("4").tag(4)
					}
				}
				Section(header: Text("Answering System")) {
					if phone.hasAnsweringSystem > 1 {
						Picker("Answering System Menu", selection: $handset.answeringSystemMenu) {
							Text("Settings Only (doesn't require link to base").tag(0)
							Text("Settings Only (requires link to base)").tag(1)
							Text("Full (doesn't require link to base").tag(2)
							Text("Full (requires link to base)").tag(3)
						}
					}
				}
				Section(header: Text("Redial")) {
					TextField("Redial Capacity", value: $handset.redialCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
					if phone.redialNameDisplay == 1 && handset.usesBasePhonebook {
						Text("Although the redial list is stored in the handset, it may still require you to be in range of the base if the handset doesn't have a fallback to display entries without their names.")
							.font(.footnote)
							.foregroundStyle(.secondary)
					}
				}
				Section(header: Text("Phonebook")) {
					TextField("Phonebook Capacity", value: $handset.phonebookCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
					Toggle("Uses Base Phonebook", isOn: $handset.usesBasePhonebook)
				}
				Section(header: Text("Caller ID")) {
					TextField("Caller ID List Capacity", value: $handset.callerIDCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
						.keyboardType(.numberPad)
#endif
#if !os(xrOS)
						.scrollDismissesKeyboard(.interactively)
#endif
					Toggle("Uses Base Caller ID List", isOn: $handset.usesBaseCallerID)
				}
				Section(header: Text("Speed Dial")) {
					Stepper("Dial-Key Speed Dial Capacity: \(handset.speedDialCapacity)", value: $handset.speedDialCapacity, in: 0...10)
					Stepper("One-Touch/Memory Dial: \(handset.oneTouchDialCapacity)", value: $handset.oneTouchDialCapacity, in: 0...4)
					Toggle("Uses Base Speed Dial", isOn: $handset.usesBaseSpeedDial)
					Toggle("Uses Base One-Touch Dial", isOn: $handset.usesBaseOneTouchDial)
				}
			}
			.formStyle(.grouped)
#if os(macOS)
			.toggleStyle(.checkbox)
#else
			.toggleStyle(.switch)
#endif
			.textFieldStyle(.roundedBorder)
		} else {
			Text("Error")
		}
	}
}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}
