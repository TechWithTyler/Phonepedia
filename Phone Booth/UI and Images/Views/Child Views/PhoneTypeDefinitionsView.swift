//
//  PhoneTypeDefinitionsView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//

import SwiftUI
import SheftAppsStylishUI
import Collections

struct PhoneTypeDefinitionsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    typealias Term = Phone.PhoneType.Term
    
    let dictionary: [Term] = [
        Term("\(Phone.PhoneType.cordless.rawValue)", definition: "A phone with a main transmitting base that connects to the phone line and charges a cordless handset. Cordless phones with 2 or more handsets have one or more chargers, which are small bases which only connect to power and charge a cordless handset."),
        Term("\(Phone.PhoneType.corded.rawValue)", definition: "A traditional phone with a corded receiver. These can have either mechanical/bell or electronic ringers and come in a range of styles from slim, basic wall phones to fully-featured desk phones."),
        Term("\(Phone.PhoneType.cordedCordless.rawValue)", definition: "A corded phone that acts as a transmitting base for cordless handsets. All cordless handsets charge on chargers."),
        Term("\(Phone.PhoneType.cordlessWithTransmitOnlyBase.rawValue)", definition: "A cordless phone where the base doesn't have a cordless handset charging area or corded receiver. All cordless handsets charge on chargers.")
    ]
    
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
            #if os(macOS)
            .frame(minWidth: 400, maxWidth: 400, minHeight: 200, maxHeight: 200)
            #endif
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
    }
}


#Preview {
    PhoneTypeDefinitionsView()
}
