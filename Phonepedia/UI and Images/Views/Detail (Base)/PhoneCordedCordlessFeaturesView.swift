//
//  PhoneCordedCordlessFeaturesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneCordedCordlessFeaturesView: View {

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Stepper("Number of Included Cordless Devices (0 if corded-only): \(phone.numberOfIncludedCordlessHandsets)", value: $phone.numberOfIncludedCordlessHandsets, in: .zeroToMax(15))
            .disabled(phone.handsetNumberDigit != nil)
            .onChange(of: phone.numberOfIncludedCordlessHandsets) { oldValue, newValue in
                phone.numberOfIncludedCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
            }
            .onChange(of: phone.isCordless) { oldValue, newValue in
                if !newValue && (!phone.cordlessHandsetsIHave.isEmpty || !phone.chargersIHave.isEmpty) {
                    dialogManager.showingMakeCordedOnly = true
                    phone.numberOfIncludedCordlessHandsets = 1
                    return
                }
                phone.isCordlessChanged(oldValue: oldValue, newValue: newValue)
            }
            .alert("Make this phone corded-only?", isPresented: $dialogManager.showingMakeCordedOnly) {
                Button("OK") {
                    phone.cordlessHandsetsIHave.removeAll()
                    phone.chargersIHave.removeAll()
                    phone.numberOfIncludedCordlessHandsets = 0
                    dialogManager.showingMakeCordedOnly = false
                }
                Button("Cancel", role: .cancel) {
                    dialogManager.showingMakeCordedOnly = false
                }
            } message: {
                Text("This will delete all cordless devices and chargers.")
            }
        if phone.isCordless {
            Group {
                HandsetNumberDigitView(phone: phone)
                Stepper("Maximum Number of Cordless Devices (-1 If Using \"Security Codes Must Match\"): \(phone.maxCordlessHandsets)", value: $phone.maxCordlessHandsets, in: -1...15)
                    .onChange(of: phone.maxCordlessHandsets) { oldValue, newValue in
                        phone.maxCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
                    }
                    InfoButton(title: "Registration/Security Code Explanation…") {
                        dialogManager.showingRegistrationExplanation = true
                }
            }
            Picker("Frequency", selection: $phone.frequency) {
                ForEach(Phone.CordlessFrequency.allCases) { frequency in
                    if frequency.rawValue < 0 {
                        Divider()
                    } else {
                        Text(frequency.name).tag(frequency)
                    }
                }
            }
            InfoButton(title: "Frequencies/Communication Technologies Explanation…") {
                dialogManager.showingFrequenciesExplanation = true
            }
            Picker("ECO Mode", selection: $phone.ecoMode) {
                Text("Not Supported").tag(0)
                Text("Reduced Power Only").tag(1)
                Text("Reduced Power or No Transmit").tag(2)
            }
            InfoText("ECO mode allows transmission power to be reduced to save energy, either for cordless devices that are close to or placed on the base, or for the entire system by manual activation.\nSome phones can stop all transmission when in standby mode. The handset distinguishes between \"base not transmitting\" and \"out of range\" by occasionally sending a signal to the base to wake it up. A wake-up signal is also sent when the handset is picked up from charge or when any button is pressed. If the handset fails to receive an acknowledgment from the base, the handset is considered out of range. Since the handset needs to check for the base more frequently in \"no transmit\" mode, the phone will still occasionally transmit in standby mode and the handset battery life may be reduced.")
            Picker("Antenna(s)", selection: $phone.antennas) {
                Text("Hidden").tag(0)
                Text("Telescopic").tag(1)
                Text("Standard (Left)").tag(2)
                Text("Standard (Right)").tag(3)
                Text("One On Each Side").tag(4)
            }
            AntennaInfoView()
            if phone.hasRegistration {
                Toggle("Supports Range Extenders", isOn: $phone.supportsRangeExtenders)
                InfoText("A range extender extends the range of the base it's registered to. Devices communicating with the base choose the base or a range extender based on which has the strongest signal.\nIf you register 2 or more range extenders, they can be \"daisy-chained\" (one can communicate with the base via another) to create a larger useable coverage area.\nWhen a cordless device moves between the base or range extender(s), your call may briefly cut out.\nIf a handset is communicating with a range extender and that range extender loses power or its link to the base, the handset will also lose its link to the base for a few seconds, so the handset may drop the call or switch to communicating with the base or another range extender.")
            }
            if !phone.isCordedCordless {
                Toggle("Base Is Transmit-Only", isOn: $phone.hasTransmitOnlyBase)
                    .onChange(of: phone.hasTransmitOnlyBase) { oldValue, newValue in
                        phone.transmitOnlyBaseChanged(oldValue: oldValue, newValue: newValue)
                    }
                Picker("Wall Mounting", selection: $phone.wallMountability) {
                    Text("Not Supported").tag(0)
                    Text("Holes on Back").tag(1)
                    Text("Optional Bracket").tag(2)
                    Text("Built-In Bracket").tag(3)
                    Text("Desk/Wall Bracket").tag(4)
                }
                if !phone.hasBaseKeypad && !phone.hasTransmitOnlyBase {
                    Toggle("Has Charger-Style Base", isOn: $phone.hasChargerSizeBase)
                    InfoText("Some cordless phone bases look similar/have a similar size to chargers. In some cases, such as when the base has no answering system controls, they can be easily mistaken for chargers, although a base is always slightly bigger than a charger.\nThese kinds of bases are ideal for those who want a small-footprint base. The differentiating factor between a charger-style base vs a standard base is that the handset charging area is in the same position as that of the charger (usually the center).\nTip: The main base has at least a phone jack or handset locator button. Chargers just plug into power.")
                }
            }
            Picker("Charge Light", selection: $phone.chargeLight) {
                Text("None").tag(0)
                if phone.baseChargesHandset {
                    Text("On Base Only").tag(1)
                    Text("On Base/Charger").tag(2)
                } else {
                    Text("On Charger").tag(2)
                }
                Text("On Handset").tag(3)
            }
            if phone.baseChargesHandset {
                Group {
                    Picker("Base Charging Direction", selection: $phone.baseChargingDirection) {
                        ChargingDirectionPickerItems()
                    }
                    InfoText("Variations in charging area designs are one of the many ways cordless phones look different from one another.\nA reversible handset can charge with the keypad facing either up or down.")
                    if !phone.isCordedCordless {
                        Picker("Base Charge Contact Placement", selection: $phone.baseChargeContactPlacement) {
                            ChargeContactPlacementPickerItems()
                        }
                        Picker("Base Charge Contact Type", selection: $phone.baseChargeContactType) {
                            ChargeContactTypePickerItems()
                        }
                        ChargingContactInfoView()
                        Toggle("Base Has Separate Data Contact", isOn: $phone.baseHasSeparateDataContact)
                        InfoText("""
Most modern cordless phones pass data through the 2 charging contacts for various features including the following. However, many older cordless phones, especially 46-49MHz and 900MHz models, used a separate, 3rd contact for data.
• Detecting the handset being placed on the base for registration.
• Detecting the handset being lifted off the base to switch from the base speakerphone to the handset.
In most cases, if the base has a charge light/display message, the completion of the charge circuit turns it on, but sometimes that's handled by the separate data contact if the phone has one.
""")
                    }
                }
            }
            if phone.maxCordlessHandsets > 1 {
                Picker("Handset Locator", selection: $phone.locatorButtons) {
                    Text(phone.hasBaseKeypad && phone.handsetLocatorUsesIntercom ? "One for All HS/Keypad Entry" : "One For All Handsets").tag(0)
                    Text("One for Each Handset").tag(1)
                    Text("Each HS + All").tag(2)
                    Text("Select + Call Buttons").tag(3)
                }
                .onChange(of: phone.locatorButtons) { oldValue, newValue in
                    phone.locatorButtonsChanged(oldValue: oldValue, newValue: newValue)
                }
                InfoText("Handset locator allows you to locate (page) the handset(s) so you can find them.\nOne for All: A single locator button pages or makes an intercom call to all handsets. If the base has a keypad, you can call all handsets or a specific one.\nOne for Each: The base has one locator button for each handset that can be registered. For example, a phone that only expands up to 3 handsets would have 3 handset locator buttons, one for each of the 3 handsets. The paged handset can have an intercom call with the base.\nEach HS + All: The base has one locator button for each handset that can be registered, as well as a button to page all handsets. The paged handset can have an intercom call with the base.\nSelect + Call Buttons: Press the select button to select the handset to page, then press the call button to call it. The paged handset can have an intercom call with the base.")
                if phone.locatorButtons == 0 {
                    Toggle("Handset Locator Uses Intercom", isOn: $phone.handsetLocatorUsesIntercom)
                }
                InfoText("Some phones use intercom as the means of locating handsets, even if the base doesn't have intercom. This means that the handset locator and intercom from the base are the same feature.\nPhones without base intercom always have a single handset locator button to locate all handsets.")
                if !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.deregistration > 0 && phone.locatorButtons == 0 {
                    Toggle("Place-On-Base Auto-Register", isOn: $phone.placeOnBaseAutoRegister)
                    InfoText("The base can detect an unregistered handset being placed on it, which will put it into registration mode. Aside from putting the base into registration mode, data isn't exchanged through the contacts like it is on phones using the digital security code method. Manually putting the base in registration mode is still available for re-registering handsets or for registering handsets which don't fit on the base.")
                }
                Picker("Deregistration", selection: $phone.deregistration) {
                    if phone.locatorButtons > 0 {
                        Text("Not Supported").tag(0)
                    }
                    Text("From This Handset").tag(1)
                    Text("One From Any Handset/Base").tag(2)
                    Text("Multiple From Any Handset/Base").tag(3)
                    Text("All From Base").tag(4)
                }
                .onChange(of: phone.deregistration) { oldValue, newValue in
                    phone.deregistrationChanged(oldValue: oldValue, newValue: newValue)
                }
                Picker("Handset/Base Renaming", selection: $phone.handsetRenaming) {
                    Text("Not Supported").tag(0)
                    Text("Handset").tag(1)
                    if phone.baseDisplayType > 2 {
                        Text("Handset/Base").tag(2)
                    }
                }
                InfoText("Renaming the handset/base makes it easier to find the desired one in a list (e.g., when making intercom calls) and/or so you know where to put it. For example, if you have a handset in your kitchen, living room, and master bedroom, you might give each handset the names \"Kitchen\", \"Living RM\", and \"Bedroom\", respectively.\nIf the handset name shows in handset lists, the name is stored in the base, and the handset either links to the base when showing handset lists or syncs the list from the base.")
            }
        } else {
            Picker("Corded Phone Type", selection: $phone.cordedPhoneType) {
                Section(header: Text("Desk")) {
                    Text("Push-Button Desk").tag(0)
                    Text("Rotary Desk").tag(1)
                }
                Section(header: Text("Slim/Wall")) {
                    Text("Push-Button Slim/Wall").tag(2)
                    Text("Rotary Slim/Wall").tag(3)
                }
                Section(header: Text("Other")) {
                    Text("Base-less").tag(4)
                    Text("Novelty").tag(5)
                }
            }
            .onChange(of: phone.cordedPhoneType) { oldValue, newValue in
                phone.cordedPhoneTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("""
                • Rotary phones use a dial with numbers on it. You place your finger on the desired number and turn it until it stops, hence the phrase "dialing a number". When you release the dial, springs and gears return it to its resting position, causing the phone to go on and off-hook very quickly a certain number of times, corresponding to the number you put your finger on. This quick "on and off-hook" is called a pulse. Push-button phones can also send pulses instead of tones. For line-powered push-button phones with button lighting, the light will flash with each pulse.
                • When the corded receiver is placed on the base, the earpiece pushes down on a piece on the base, or the base pushes down on a piece below the earpiece. This piece is called the hook switch or switch hook, and is how the phone knows if the receiver is on or off the base. You can quickly press the hook switch/switch hook to simulate a pulse dial. This is called "switch hook dialing".
                • Most push-button phones send tones made up of a low and high frequency, called Dual-Tone Multi-Frequency (DTMF) tones, when numbers are dialed. Most phone services today only support tone dialing, so a pulse-to-tone converter is required if you want to use a rotary phone or pulse-only push-button phone on your line. A pulse-to-tone converter detects the number of pulses and then sends out the corresponding DTMF tone through the line.
                • A desk phone has a base, with or without speakerphone, and a corded receiver. These phones may also have other features like a caller ID display or answering system.
                • A slim/wall phone doesn't have speakerphone and typically doesn't have an answering system, but may have a caller ID display. The keypad or rotary dial can be either in the receiver or in the base. The caller ID buttons and display are on the back of the receiver, not the face where the keypad is.
                • A base-less phone is a corded phone that doesn't have a base. The phone is a single device that plugs into the line.
                • A novelty phone is a corded phone that's designed to look like something else, like a hamburger you flip open, a piano whose keys are used to dial numbers, a slim phone that's shaped like a pair of lips, an animal, or a cartoon character.
                """)
        }
        if !phone.isCordless {
            if phone.cordedPhoneType == 0 {
                Toggle("Has Dual Receivers", isOn: $phone.hasDualReceivers)
                InfoText("A corded phone with dual receivers allows 2 people to use the phone at the same time without having to connect 2 separate phones to the same line. These kinds of phones are often used by those requiring a language interpreter.")
            }
            if phone.cordedPhoneType == 2 || phone.cordedPhoneType == 3 {
                Picker("\(phone.cordedPhoneType == 2 ? "Keypad" : "Rotary Dial") Location", selection: $phone.dialLocation) {
                    Text("Base").tag(0)
                    Text("Receiver").tag(1)
                }
            }
            Picker("Corded Receiver Volume Adjustment", selection: $phone.cordedReceiverVolumeAdjustmentType) {
                Text("None").tag(0)
                Text("Volume Switch/Dial").tag(1)
                Text("Volume Button(s)").tag(2)
            }
            if phone.cordedReceiverVolumeAdjustmentType == 0 {
                WarningText("If the corded receiver volume isn't adjustable and you find it too loud, you'll need to adjust your line's incoming volume. If you can't adjust it, adding a series of resistors between the phone and jack is recommended (consult a professional to build this for you if necessary). If the corded receiver's cord is removable, you can replace it with one that has a volume control.")
            }
            Toggle("Has Hard-Wired Corded Receiver", isOn: $phone.hasHardWiredCordedReceiver)
            InfoText("Some old phones have hard-wired corded receivers, which means you'll need to have the phone repaired if the cord breaks.")
            if phone.cordedPhoneType == 2 {
                Picker("Switch Hook", selection: $phone.switchHookType) {
                    Text("On Base").tag(0)
                    Text("On Receiver").tag(1)
                    Text("Magnetic").tag(2)
                }
            }
        }
    }
}

#Preview {
    Form {
        PhoneCordedCordlessFeaturesView(phone: Phone(brand: "Panasonic", model: "KX-TGE633"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
