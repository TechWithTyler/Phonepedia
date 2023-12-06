//
//  PhoneTypeDefinitionsView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/6/23.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneTypeDefinitionsView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollableText("""
   • \(Phone.PhoneType.cordless.rawValue): A phone with a main transmitting base that connects to the phone line and charges a cordless handset. Cordless phones with 2 or more handsets have one or more chargers, which are small bases which only connect to power and charge a cordless handset.
   • \(Phone.PhoneType.corded.rawValue): A traditional phone with a corded receiver. These can have either mechanical/bell or electronic ringers and come in a range of styles from slim, basic wall phones to fully-featured desk phones.
   • \(Phone.PhoneType.cordedCordless.rawValue): A corded phone that acts as a transmitting base for cordless handsets. All cordless handsets charge on chargers.
   • \(Phone.PhoneType.cordlessWithTransmitOnlyBase.rawValue): A cordless phone where the base doesn't have a cordless handset charging area or corded receiver. All cordless handsets charge on chargers.
   """)
        .navigationTitle("Phone Type Definitions")
        .frame(minWidth: 400, maxWidth: 400, minHeight: 400, maxHeight: 400)
        }
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


#Preview {
    PhoneTypeDefinitionsView()
}
