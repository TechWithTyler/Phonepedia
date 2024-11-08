//
//  PhoneBasicFeaturesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneBasicFeaturesView: View {

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Stepper("Number of Included Cordless Handsets (0 if corded-only): \(phone.numberOfIncludedCordlessHandsets)", value: $phone.numberOfIncludedCordlessHandsets, in: 0...Int.max-1)
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
                Stepper("Maximum Number of Cordless Handsets (-1 if using \"security codes must match\"): \(phone.maxCordlessHandsets)", value: $phone.maxCordlessHandsets, in: -1...15)
                    .onChange(of: phone.maxCordlessHandsets) { oldValue, newValue in
                        phone.maxCordlessHandsetsChanged(oldValue: oldValue, newValue: newValue)
                    }
#if os(iOS)
                    .sensoryFeedback(.error, trigger: phone.numberOfIncludedCordlessHandsets) { oldValue, newValue in
                        return newValue > phone.maxCordlessHandsets && phone.hasRegistration
                    }
#endif
                    InfoButton(title: "Registration/Security Code Explanation…") {
                        dialogManager.showingRegistrationExplanation = true
                }
                if phone.numberOfIncludedCordlessHandsets > phone.maxCordlessHandsets && phone.hasRegistration {
                    WarningText("The base of the \(phone.brand) \(phone.model) can only register up to \(phone.maxCordlessHandsets) handsets (you specified that it includes \(phone.numberOfIncludedCordlessHandsets)).")
                }
            }
            Picker("Wireless Frequency/Communication Technology", selection: $phone.frequency) {
                Text("Unknown").tag(0)
                Section(header: Text("Older")) {
                    Text("1.7MHz Analog").tag(1)
                    Text("30-37MHz Analog").tag(30)
                    Text("46-49MHz Analog").tag(46)
                }
                Section(header: Text("900MHz")) {
                    Text("900MHz Analog/Unknown").tag(900)
                    Text("900MHz Voice Scramble Analog").tag(900.1)
                    Text("900MHz Digital").tag(900.2)
                    Text("900MHz DSS").tag(900.3)
                }
                Section(header: Text("2.4GHz")) {
                    Text("2.4GHz Analog/Unknown").tag(2400.0)
                    Text("2.4GHz/900MHz Analog").tag(2400.900)
                    Text("2.4GHz Digital").tag(2400.1)
                    Text("2.4GHz/900MHz Digital").tag(2400.901)
                    Text("2.4GHz DSS").tag(2400.2)
                    Text("2.4GHz/900MHz DSS").tag(2400.902)
                    Text("2.4GHz FHSS").tag(2400.3)
                    Text("2.4GHz/900MHz FHSS").tag(2400.903)
                }
                Section(header: Text("5.8GHz")) {
                    Text("5.8GHz Analog/Unknown").tag(5800)
                    Text("5.8GHz/900MHz Analog").tag(5800.900)
                    Text("5.8GHz/2.4GHz Analog").tag(5800.2400)
                    Text("5.8GHz Digital").tag(5800.1)
                    Text("5.8GHz/900MHz Digital").tag(5800.901)
                    Text("5.8GHz/2.4GHz Digital").tag(5800.2401)
                    Text("5.8GHz DSS").tag(5800.2)
                    Text("5.8GHz/900MHz DSS").tag(5800.902)
                    Text("5.8GHz/2.4GHz DSS").tag(5800.2402)
                    Text("5.8GHz Digital FHSS").tag(5800.3)
                    Text("5.8GHz/900MHz FHSS").tag(5800.903)
                    Text("5.8GHz/2.4GHz FHSS").tag(5800.2403)
                }
                Section(header: Text("DECT (Digital Enhanced Cordless Telecommunications)")) {
                    Text("DECT (1.88GHz-1.90GHz)").tag(1880)
                    Text("DECT (1.90GHz-1.92GHz)").tag(1900)
                    Text("DECT 6.0 (1.92GHz-1.93GHz)").tag(1920)
                }
            }
            InfoButton(title: "Frequencies Explanation…") {
                dialogManager.showingFrequenciesExplanation = true
            }
            Picker("Antenna(s)", selection: $phone.antennas) {
                Text("Hidden").tag(0)
                Text("Telescopic").tag(1)
                Text("Standard (left)").tag(2)
                Text("Standard (right)").tag(3)
                Text("One On Each Side").tag(4)
            }
            AntennaInfoView()
            if phone.hasRegistration {
                Toggle("Supports Range Extenders", isOn: $phone.supportsRangeExtenders)
                InfoText("A range extender extends the range of the base it's registered to. Devices communicating with the base choose the base or a range extender based on which has the strongest signal.\nIf you register 2 or more range extenders, they can be \"daisy-chained\" (one can communicate with the base via another) to create a larger useable coverage area.\nWhen a cordless device moves between the base or range extender(s), your call may briefly cut out.\nIf a handset is communicating with a range extender and that range extender loses power or its link to the base, the handset will also lose its link to the base for a few seconds.")
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
                    InfoText("Some cordless phone bases look similar/have a similar size to chargers. In some cases, such as when the base has no answering system controls, they can be easily mistaken for chargers, although a base is always slightly bigger than a charger.\nTip: The main base has at least a phone jack or handset locator button. Chargers just plug into power.\nThese kinds of bases are ideal for those who want a small-footprint base. The differentiating factor between a charger-style base vs a standard base is that the handset charging area is in the same position as that of the charger (usually the center).")
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
                    InfoText("Variations in charging area designs are one of the many ways different cordless phones look different from one another.\nA reversible handset can charge with the keypad facing either up or down.")
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
                    Text(phone.hasBaseKeypad ? "One For All Handsets/Keypad Entry" : "One For All Handsets").tag(0)
                    Text("One For Each Handset").tag(1)
                    Text("Each HS + All").tag(2)
                    Text("Select + Call Buttons").tag(3)
                }
                .onChange(of: phone.locatorButtons) { oldValue, newValue in
                    phone.locatorButtonsChanged(oldValue: oldValue, newValue: newValue)
                }
                if !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.deregistration > 0 {
                    Toggle("Place-On-Base Auto-Register", isOn: $phone.placeOnBaseAutoRegister)
                    InfoText("The base can detect an unregistered handset being placed on it, which will put it into registration mode. Aside from putting the base into registration mode, data isn't exchanged through the contacts like it is on phones using the digital security code method. Manually putting the base in registration mode is still available for re-registering handsets or for registering handsets which don't fit in the base.")
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
                • A desk phone has a base, with or without speakerphone, and a corded receiver. These phones may also have other features like a caller ID display or answering system.
                • A slim/wall phone doesn't have speakerphone or an answering system, but may have a caller ID display. The keypad or rotary dial can be either in the receiver or in the base. Caller ID buttons are on the back of the receiver, not the face where the keypad is.
                • A base-less phone is a corded phone that doesn't have a base. The phone is a single device that plugs into the line.
                • A novelty phone is a corded phone that's designed to look like something else, like a hamburger you flip open, a piano whose keys are used to dial numbers, a slim phone that's shaped like a pair of lips, or an animated character that serves as the phone's base.
                """)
        }
    }
}

#Preview {
    Form {
        PhoneBasicFeaturesView(phone: Phone(brand: "Panasonic", model: "KX-TGE633"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
