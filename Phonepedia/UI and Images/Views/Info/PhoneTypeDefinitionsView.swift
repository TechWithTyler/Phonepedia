//
//  PhoneTypeDefinitionsView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/6/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI
import Collections

struct PhoneTypeDefinitionsView: View {
    
    // MARK: - Type Aliases
    
    typealias DictionaryEntry = Phone.PhoneType.DictionaryEntry
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties - Arrays
    
    let dictionary: [DictionaryEntry] = [
        DictionaryEntry("\(Phone.PhoneType.cordless.rawValue)", definition: "A phone with a main transmitting base that connects to the phone line (and/or connects to a cell phone via Bluetooth) and charges a cordless handset. Cordless phones with 2 or more handsets have one or more chargers, which are small bases which only connect to power and charge a cordless handset. When the phone or its documentation says \"base\", it's referring to the main transmitting base, NOT the additional charging bases. This is very important to keep in mind when you're asked to \"check if the base is plugged in\". When purchasing an \"additional handset\", it MUST be used with a main transmitting base--it won't work by itself!"),
        DictionaryEntry("\(Phone.PhoneType.corded.rawValue)", definition: "A traditional phone with a corded receiver. These can have either mechanical/bell or electronic ringers and come in a range of styles from slim, basic wall phones to fully-featured desk phones."),
        DictionaryEntry("\(Phone.PhoneType.cordedCordless.rawValue)", definition: "A corded phone that acts as a transmitting base for cordless handsets. All cordless handsets charge on chargers. You can tell a corded/cordless phone from a standard corded phone by the presence of an external antenna, handset locator buttons/options, any mentions of \"handsets\", or a wireless frequency."),
        DictionaryEntry("\(Phone.PhoneType.cordlessWithTransmitOnlyBase.rawValue)", definition: "A cordless phone where the base doesn't have a cordless handset charging area or corded receiver. All cordless handsets charge on chargers. Sometimes these kinds of bases have speakerphone, but usually they only have a handset locator button and nothing else. A transmit-only base with no features on it is often called a \"hidden base\" as these kinds of bases are often placed out-of-sight. Tip: If you ever see a cordless phone somewhere but can't find the base, it may very well be a transmit-only base that's been placed out-of-sight. This is very common on cordless-only business-grade VoIP phones.")
    ]
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dictionary) { item in
                    DisclosureGroup {
                        Text(item.definition)
                    } label: {
                        Text(item.term)
                            .fontWeight(.bold)
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


#Preview {
    PhoneTypeDefinitionsView()
}
