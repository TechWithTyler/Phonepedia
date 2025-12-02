//
//  PhoneTypeDefinitionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct PhoneTypeDefinitionsView: View {

    // MARK: - Type Aliases

    typealias DictionaryEntry = Phone.PhoneType.DictionaryEntry

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Arrays

    let phoneTypeDictionary: [DictionaryEntry] = [
        DictionaryEntry(Phone.PhoneType.cordless.rawValue, definition: "A phone with a main transmitting base that connects to power, a phone line/network (and/or connects to a cell phone via Bluetooth), and charges a cordless handset/headset/speakerphone. The main base can be one of several types, which are explained in the \"\(cordlessBaseTypeSectionName)\" section. Cordless phones with 2 or more handsets have one or more chargers, which are small bases which only connect to power and charge a cordless handset. Some chargers have additional features like a range extender or clock/radio/alarm. When the phone or its documentation says \"base\", it's referring to the main transmitting base, NOT the additional charging bases. This is very important to keep in mind when you're asked to \"check if the base is plugged in\". When purchasing an \"additional handset\", it MUST be used with a main transmitting base--it won't work by itself!"),
        DictionaryEntry(Phone.PhoneType.corded.rawValue, definition: "A traditional phone with a receiver which connects to the base using a cord (often coiled). These can have either mechanical/bell or electronic ringers and come in a range of styles which are explained in the \"\(cordedPhoneStyleSectionName)\" section."),
        DictionaryEntry(Phone.PhoneType.cordedCordless.rawValue, definition: "A corded phone that acts as a transmitting base for cordless handsets. All cordless handsets charge on chargers. You can tell a corded/cordless phone apart from a standard corded phone by the presence of an external antenna, handset locator buttons/options, or any mentions of \"handsets\" or a wireless frequency."),
        DictionaryEntry(Phone.PhoneType.cordlessWithTransmitOnlyBase.rawValue, definition: "A cordless phone where the base doesn't have a cordless handset charging area or corded receiver. All cordless handsets charge on chargers. Sometimes, these kinds of bases have speakerphone, but usually, they only have a handset locator button and nothing else. A transmit-only base with no features on it is often called a \"hidden base\" as these kinds of bases are often placed out-of-sight. These kinds of bases can easily be mistaken for Wi-Fi routers.\nTip: If you ever see a cordless phone somewhere but can't find the base, it may very well be a transmit-only base that's been placed out-of-sight. This is very common on cordless-only business-grade VoIP phones."),
        DictionaryEntry(Phone.PhoneType.wiFiHandset.rawValue, definition: "A cordless phone handset-style phone that connects directly to a Wi-Fi network and is configured like any VoIP phone. It charges on a charger like a regular cordless phone."),
        DictionaryEntry(Phone.PhoneType.cellularHandset.rawValue, definition: "A cordless phone handset-style phone that connects directly to a cellular network and is configured like any cell phone. It charges on a charger like a regular cordless phone, which is the main difference from a regular cell phone. These phones are intended to be used as a landline alternative that's designed to work in your country, not a regular cell phone that can be used in many countries, especially since some can charge only via the cordless handset charger.")
    ]

    let cordlessBaseTypeDictionary: [DictionaryEntry] = [
        DictionaryEntry("\(Phone.CordlessBaseType.locatorBase.rawValue)/\(Phone.CordlessBaseType.hiddenBase.rawValue)", definition: "A base which has no features on it, aside from a handset locator button and sometimes in use/charge lights. Bluetooth cell phone linking-capable models might also have a Bluetooth button for pairing and/or connecting to a device. Some locator base phones have a handset-accessible answering system, but most don't have answering systems. A base of this type without a handset charging area is often called a \"hidden base\"."),
        DictionaryEntry(Phone.CordlessBaseType.messagingBase.rawValue, definition: "A base with answering system controls. This is the most common base type for cordless phones which use an analog line connection."),
        DictionaryEntry(Phone.CordlessBaseType.speakerphoneBase.rawValue, definition: "A base with a speakerphone but no keypad. These kinds of bases sometimes have one-touch dial buttons."),
        DictionaryEntry(Phone.CordlessBaseType.dialingBase.rawValue, definition: "A base with a speakerphone and keypad. These kinds of bases may or may not have answering systems.")
    ]

    let cordedPhoneStyleDictionary: [DictionaryEntry] = [
        DictionaryEntry(Phone.CordedPhoneStyle.candlestick.rawValue, definition: "A corded phone where the receiver is only used to listen, and the microphone is on the part of the base that sticks up like a candlestick holder, hence the name. The receiver hangs up on a hook to the left of the \"candlestick holder\", hence the terms \"on-hook\", \"off-hook\", \"switch hook\", and \"hanging up\". This design of phone came before dialing, so picking up the receiver would connect you to an operator (or on today's lines, just give you a dial tone). Unlike most phones, the ringer and most of the circuitry were usually contained in a separate box, called a subset, that was connected to the phone. This was because these components couldn't fit into the candlestick phone itself at the time. As this design of phone is very old and was from the \"phone company owns the phones\" era, most candlestick phones seen today are replicas which have either a rotary dial or keypad, and the ringer and circuitry are in the phone itself."),
        DictionaryEntry(Phone.CordedPhoneStyle.woodenBox.rawValue, definition: "Similar in concept to a candlestick phone, but the base is shaped like a wooden box instead of a candlestick holder. Visible bells at the top serve as the ringer. These kinds of phones often have a crank on the side, which you turn to ring the operator, and you would stop cranking once the operator answers. These kinds of phones are very old and were from the \"phone company owns the phones\" era, so most wooden box phones seen today are replicas which have either a rotary dial or keypad."),
        DictionaryEntry(Phone.CordedPhoneStyle.desk.rawValue, definition: "A phone with a base, with or without speakerphone, and a corded receiver. These phones may also have other features like a caller ID display or answering system."),
        DictionaryEntry(Phone.CordedPhoneStyle.slim.rawValue, definition: "A phone that typically doesn't have speakerphone or an answering system, but may have a caller ID display. The keypad or rotary dial can be either in the receiver or in the base. The caller ID buttons and display are on the back of the receiver, not the face where the keypad usually is. If wall mounted, this design allows you to view the caller ID list or change settings without picking up the phone. Some phones of this style use the base only as the receiver's resting place and for cord routing, with all the electronics in the receiver."),
        DictionaryEntry(Phone.CordedPhoneStyle.baseless.rawValue, definition: "A corded phone that doesn't have a base, or where the base is only used as the receiver's resting place. The phone is a single device that plugs into the line. Many phones of this style have a hook switch that gets pressed by being placed on a flat surface, while some have an on/off switch or a cover you flip open. The cord starts out straight, then gets curly as it gets closer to the phone."),
        DictionaryEntry(Phone.CordedPhoneStyle.novelty.rawValue, definition: "A corded phone that's designed to look like something else, like a hamburger you flip open, a piano whose keys are used to dial numbers, a slim phone that's shaped like a pair of lips, an animal, or a cartoon character.")
    ]

    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Section("Phone Types") {
                    ForEach(phoneTypeDictionary) { item in
                        DisclosureGroup {
                            Text(item.definition)
                        } label: {
                            Text(item.term)
                                .fontWeight(.bold)
                        }
                    }
                }
                Section(cordlessBaseTypeSectionName) {
                    ForEach(cordlessBaseTypeDictionary) { item in
                        DisclosureGroup {
                            Text(item.definition)
                        } label: {
                            Text(item.term)
                                .fontWeight(.bold)
                        }
                    }
                }
                Section(cordedPhoneStyleSectionName) {
                    ForEach(cordedPhoneStyleDictionary) { item in
                        DisclosureGroup {
                            Text(item.definition)
                        } label: {
                            Text(item.term)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("Phone Type Definitions")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }
    
}

// MARK: - Preview

#Preview {
    PhoneTypeDefinitionsView()
}
