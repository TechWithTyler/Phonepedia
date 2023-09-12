//
//  HandsetInfoRowView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftUI

struct HandsetInfoDetailView: View {

	@Binding var handset: CordlessHandset

	@Environment(\.dismiss) var dismiss

	var handsetNumber: Int

	var body: some View {
		if let phone = handset.phone {
			Form {
				Section(header: Text("General")) {
					HStack {
						Text("Registered as: Handset \(handsetNumber)")
						Button {
							phone.cordlessHandsetsIHave.removeAll { $0 == handset }
							dismiss()
						} label: {
							Text("Deregister")
						}
					}
					TextField("Brand", text: $handset.brand)
					TextField("Model", text: $handset.model)
					TextField("Color", text: $handset.color)
					Stepper("Maximum Number Of Bases: \(handset.maxBases)", value: $handset.maxBases, in: 1...4)
					HStack {
						Image(systemName: "info.circle")
						Text("Registering a handset to more than one base allows you to extend the coverage area and access the answering system, shared lists, etc. of multiple bases without having to register the handset to one of those bases at a time.")
					}
						.foregroundStyle(.secondary)
						.font(.footnote)
					Picker("Cordless Device Type", selection: $handset.cordlessDeviceType) {
						Text("Handset").tag(0)
						Text("Deskset").tag(1)
						Text("Headset/Speakerphone").tag(2)
					}
					.onChange(of: handset.cordlessDeviceType) { oldValue, newValue in
						handset.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
					}
					HStack {
						Image(systemName: "info.circle")
						Text("A deskset is a corded phone that connects wirelessly to a main base and is treated like a handset.")
					}
					.foregroundStyle(.secondary)
					.font(.footnote)
					if handset.cordlessDeviceType == 0 && !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.maxCordlessHandsets != -1 {
						Toggle("Fits On Base", isOn: $handset.fitsOnBase)
						if !handset.fitsOnBase {
							HStack {
								Image(systemName: "info.circle")
								Text("A handset which doesn't fit on the base misses out on many features including place-on-base power backup and place-on-base auto-register.")
							}
							.foregroundStyle(.secondary)
							.font(.footnote)
						}
					}
					if handset.cordlessDeviceType == 1 {
						TextField("Corded Receiver Color", text: $handset.cordedReceiverColor)
					}
					Picker("Visual Ringer", selection: $handset.visualRinger) {
						Text("None").tag(0)
						Text("Ignore Ring Signal").tag(1)
						Text("Follow Ring Signal").tag(2)
					}
					HStack {
						Image(systemName: "info.circle")
						Text("A visual ringer that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. A visual ringer that ignores the ring signal starts flashing when the ring signal starts and continues flashing for as long as the handset is indicating an incoming call.")
					}
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
				if handset.cordlessDeviceType < 2 {
					Section(header: Text("Ringers")) {
						Stepper("Ringtones: \(handset.ringtones)", value: $handset.ringtones, in: 1...25)
						Stepper("Music Ringtones: \(handset.musicRingtones)", value: $handset.musicRingtones, in: 0...25)
						Text("Total Ringtones: \(phone.baseRingtones + phone.baseMusicRingtones)")
						Toggle(isOn: $handset.canChangeIntercomTone) {
							Text("Can Change Intercom Tone")
						}
						if !handset.canChangeIntercomTone {
							Toggle(isOn: $handset.hasSeparateIntercomTone) {
								Text("Has Separate Intercom Tone")
							}
						}
					}
					Section(header: Text("Display/Backlight/Buttons")) {
						if handset.softKeys > 0 {
							Picker("Line Buttons", selection: $handset.lineButtons) {
								Text("Physical").tag(0)
								Text("Soft Keys").tag(1)
							}
						}
						Picker("Button Type", selection: $handset.buttonType) {
							Text("Spaced").tag(0)
							Text("Spaced with Click Feel").tag(1)
							Text("Some Spaced, Some Diamond-Cut").tag(2)
							Text("Some Spaced with Click Feel, Some Diamond-Cut").tag(3)
							Text("Diamond-Cut (no space between buttons, click feel)").tag(4)
						}
						Picker("Display Type", selection: $handset.displayType) {
							Text("None").tag(0)
							Text("Monochrome (segmented)").tag(1)
							Text("Monochrome (traditional)").tag(2)
							Text("Monochrome (full-dot with status items)").tag(3)
							Text("Monochrome (full-dot)").tag(4)
							Text("Color").tag(5)
						}
						.onChange(of: handset.displayType) { oldValue, newValue in
							handset.displayTypeChanged(oldValue: oldValue, newValue: newValue)
						}
						if handset.displayType > 0 && handset.displayType < 5 {
							TextField("Display Backlight Color", text: $handset.displayBacklightColor)
						}
						if handset.displayType > 0 {
							Picker("Update Available Handset Menus", selection: $handset.menuUpdateMode) {
								Text("Based on Registered Base").tag(0)
								Text("In Real-Time").tag(1)
							}
							HStack {
								Image(systemName: "info.circle")
								Text("When a handset menu is updated based on the base it's registered to, the available options are updated only when registering the handset to a base, and those same options will be available when the handset boots up. When a handset menu is updated in real-time, the available options depend on the state of the registered base (e.g. whether it's on power backup or if there's enough devices to support intercom), and some options might not be available when the handset boots up.")
							}
								.foregroundStyle(.secondary)
								.font(.footnote)
							Picker("Navigation Button Type", selection: $handset.navigatorKeyType) {
								Text("None").tag(0)
								Text("Up/Down Button").tag(1)
								Text("Up/Down/Left/Right Button").tag(2)
								Text("Up/Down/Left/Right Joystick").tag(3)
								Text("Up/Down Side Buttons, Left/Right Face Buttons").tag(4)
							}
							Picker("Navigation Button Center Button", selection: $handset.navigatorKeyCenterButton) {
								Text("None").tag(0)
								Text("Select").tag(1)
								Text("Menu/Select").tag(2)
								if handset.softKeys == 3 {
									Text("Middle Soft Key").tag(3)
								}
								Text("Other Function").tag(4)
							}
							if handset.sideVolumeButtons {
								Toggle("Navigation Button Up/Down for Volume", isOn: $handset.navigatorKeyUpDownVolume)
							}
							Toggle("Navigation Button Standby Shortcuts", isOn: $handset.navigatorKeyStandbyShortcuts)
							if handset.displayType > 1 {
								Stepper("Soft Keys: \(handset.softKeys)", value: $handset.softKeys, in: 0...3)
									.onChange(of: handset.softKeys) { oldValue, newValue in
										handset.softKeysChanged(oldValue: oldValue, newValue: newValue)
									}
								SoftKeyExplanationView()
							}
						}
						if handset.navigatorKeyType != 4 {
							Toggle("Has Side Volume Buttons", isOn: $handset.sideVolumeButtons)
								.onChange(of: handset.sideVolumeButtons) { oldValue, newValue in
									handset.sideVolumeButtonsChanged(oldValue: oldValue, newValue: newValue)
								}
						}
						Picker("Button Backlight Type", selection: $handset.keyBacklightAmount) {
							Text("None").tag(0)
							Text("Numbers Only").tag(1)
							Text("Numbers + Some Function Buttons").tag(2)
							Text("Numbers + All Function Buttons").tag(2)
							Text("Numbers + Navigation Button").tag(3)
							Text("All Buttons").tag(3)
						}
						if handset.keyBacklightAmount > 0 {
							TextField("Button Backlight Color", text: $handset.keyBacklightColor)
						}
						TextField("Button Foreground Color", text: $handset.keyForegroundColor)
						TextField("Button Background Color", text: $handset.keyBackgroundColor)
					}
					Section(header: Text("Audio")) {
						Toggle("Has Speakerphone", isOn: $handset.hasSpeakerphone)
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
						if handset.redialCapacity > 1 && (handset.phonebookCapacity > 0 || (phone.basePhonebookCapacity > 0 && handset.usesBasePhonebook)) {
							Picker("Redial Name Display", selection: $handset.redialNameDisplay) {
								Text("None").tag(0)
								Text("Phonebook Match").tag(1)
								Text("From Dialed Entry").tag(2)
							}
						}
						if handset.redialNameDisplay == 1 && handset.usesBasePhonebook {
							HStack {
								Image(systemName: "info.circle")
								Text("Although the redial list is stored in the handset, it may still require you to be in range of the base if the handset doesn't have a fallback to display entries without their names.")
							}
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
						if handset.phonebookCapacity > 100 {
							Picker("Bluetooth Phonebook Transfers", selection: $handset.bluetoothPhonebookTransfers) {
								Text("Not Supported").tag(0)
								Text("To Home Phonebook").tag(1)
								Text("To Separate Cell Phonebook").tag(2)
							}
						}
					}
					Section(header: Text("Caller ID")) {
						if handset.phonebookCapacity > 0 || (phone.basePhonebookCapacity > 0 && handset.usesBasePhonebook) {
							Toggle(isOn: $handset.callerIDPhonebookMatch) {
								Text("Caller ID Uses Matching Phonebook Entry Name")
							}
						}
						TextField("Caller ID List Capacity", value: $handset.callerIDCapacity, formatter: NumberFormatter())
#if os(iOS) || os(tvOS) || os(xrOS)
							.keyboardType(.numberPad)
#endif
#if !os(xrOS)
							.scrollDismissesKeyboard(.interactively)
#endif
							.onChange(of: handset.callerIDCapacity) { oldValue, newValue in
								handset.callerIDCapacityChanged(oldValue: oldValue, newValue: newValue)
							}
						if handset.callerIDCapacity == 0 {
							Toggle("Uses Base Caller ID List", isOn: $handset.usesBaseCallerID)
						}
					}
					Section(header: Text("Speed Dial")) {
						Stepper("Dial-Key Speed Dial Capacity: \(handset.speedDialCapacity)", value: $handset.speedDialCapacity, in: 0...10)
						Stepper("One-Touch/Memory Dial: \(handset.oneTouchDialCapacity)", value: $handset.oneTouchDialCapacity, in: 0...4)
						Toggle("Uses Base Speed Dial", isOn: $handset.usesBaseSpeedDial)
						Toggle("Uses Base One-Touch Dial", isOn: $handset.usesBaseOneTouchDial)
						Picker("Speed Dial Entry Mode", selection: $handset.speedDialPhonebookEntryMode) {
							Text("Manual or Phonebook (copy)").tag(0)
							Text("Phonebook Only (copy)").tag(1)
							Text("Phonebook Only (link)").tag(2)
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
		} else {
			Text("Error")
		}
	}

}

//#Preview {
//	PhonePartInfoRowView(color: Phone.preview.baseColor, part: "Base")
//}
