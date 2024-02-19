//
//  AboutConnectionTypesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/16/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct AboutConnectionTypesView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Text("The connection type specifies how a phone connects to the telephone network. Expand the following sections to learn about each one.")
                .padding()
            List {
                DisclosureGroup {
                    Text("Analog phones are the most common, connecting to a VoIP modem, cell-to-landline Bluetooth adaptor, cellular phone jack/base, PBX, or a copper line. Despite the phase-out of copper lines, many phones still take analog line connections to make them affordable, easy to set up, and compatible with any of the aforementioned devices. \"Analog\" refers to the phone line connection, and is not to be confused with \"analog cordless phone\", which refers to an analog wireless connection between a cordless phone's handset and base.")
                } label: {
                    Text("Analog")
                }
                DisclosureGroup {
                    Text("Digital phones were very rare, connecting to a special digital phone modem or jack. \"Digital\" refers to the phone line connection, and is not to be confused with \"digital cordless phone\", which refers to a digital wireless connection between a cordless phone's handset and base.")
                } label: {
                    Text("Digital")
                }
                DisclosureGroup {
                    Text("VoIP is how most telecommunication works today, and is the backbone for video conferencing services. Dedicated VoIP phones can only work with an Ethernet or Wi-Fi connection, and may require paying for extra hardware or subscriptions, which makes them not as good for phone collectors who don't want to pay too much for the necessary hardware and providers or if their setup isn't near their router. These phones offer landline comfort and convenience while integrating natively with VoIP provider features like voicemail and call forwarding. To connect an analog phone to VoIP, you need a cable modem or analog telephone adaptor (ATA).")
                } label: {
                    Text("VoIP (Voice-over-Internet Protocol)")
                }
                DisclosureGroup {
                    Text("A cellular corded or cordless phone (not to be confused with a cell-phone-linking-capable corded or cordless phone) is a corded or cordless phone that has a SIM card and connects to cell towers. These phones offer landline comfort and convenience while integrating natively with cell phone provider features like visual voicemail. To connect an analog phone to cellular, you need a cellular phone jack or cellular phone base with a SIM card installed.")
                } label: {
                    Text("Cellular Corded or Cordless")
                }
                DisclosureGroup {
                    Text("A PBX (Private Branch Exchange) is a device that creates multiple internal phone lines (analog, digital, or VoIP) and are usually seen in businesses and hotels. The connection type specifies the type of phones that can be natively connected to it. Each internal phone line is given a unique phone number, called an extension number, which can only be directly dialed from other phones on the same PBX. To access the outside line, a leading digit (e.g. 9) must be dialed to connect the given extension to an outside line (this is why hotel phones say something like \"dial 9 + area code + number\"). There can only be as many extensions on separate outside calls as there are outside lines. The outside line is optional on analog PBXs, so if you just want internal lines, a PBX is a great option.")
                } label: {
                    Text("What is a PBX?")
                }
            }
            .navigationTitle("About Connection Types")
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
    AboutConnectionTypesView()
}
