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
        DictionaryEntry("\(Phone.PhoneType.cordless.rawValue)", definition: "A phone with a main transmitting base that connects to the phone line and charges a cordless handset. Cordless phones with 2 or more handsets have one or more chargers, which are small bases which only connect to power and charge a cordless handset."),
        DictionaryEntry("\(Phone.PhoneType.corded.rawValue)", definition: "A traditional phone with a corded receiver. These can have either mechanical/bell or electronic ringers and come in a range of styles from slim, basic wall phones to fully-featured desk phones."),
        DictionaryEntry("\(Phone.PhoneType.cordedCordless.rawValue)", definition: "A corded phone that acts as a transmitting base for cordless handsets. All cordless handsets charge on chargers."),
        DictionaryEntry("\(Phone.PhoneType.cordlessWithTransmitOnlyBase.rawValue)", definition: "A cordless phone where the base doesn't have a cordless handset charging area or corded receiver. All cordless handsets charge on chargers.")
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
