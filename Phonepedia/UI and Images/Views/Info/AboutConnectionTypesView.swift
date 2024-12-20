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
                    Text("Analog Phone")
                }
                DisclosureGroup {
                    Text("Digital phones were very rare, connecting to a special digital phone modem or jack. \"Digital\" refers to the phone line connection, and is not to be confused with \"digital cordless phone\", which refers to a digital wireless connection between a cordless phone's handset and base.")
                } label: {
                    Text("Digital Phone")
                }
                DisclosureGroup {
                    Text("VoIP is how most non-cellular telecommunication works today, and is the backbone for video conferencing services. Dedicated VoIP phones can only work with an Ethernet or Wi-Fi connection, and may require paying for extra hardware or subscriptions, which makes them not as good for phone collectors who don't want to pay too much for the necessary hardware and providers or if their setup isn't near their router. These phones offer landline comfort and convenience while integrating natively with VoIP provider features like voicemail and call forwarding. To connect an analog phone to VoIP, you need a cable modem or analog telephone adaptor (ATA).")
                } label: {
                    Text("VoIP (Voice-over-Internet Protocol) Phone")
                }
                DisclosureGroup {
                    Text("A cellular corded or cordless phone (not to be confused with a cell-phone-linking-capable corded or cordless phone) is a corded or cordless phone that has a SIM card and connects to cell towers. These phones offer landline comfort and convenience while integrating natively with cell phone provider features like visual voicemail. To connect an analog phone to cellular, you need a cellular phone jack or cellular phone base with a SIM card installed. Setting up the cellular part is just like setting up cell service on a cell phone.")
                } label: {
                    Text("Cellular Corded or Cordless Phone")
                }
                DisclosureGroup {
                    Text("An ATA (Analog Telephone Adaptor) allows an analog phone (most home phones sold today) to be used on a digital, VoIP, or cellular service. These can connect to any compatible provider of the respective service. A VoIP modem, on the other hand, combines the internet connection and ATA into a single device, and is the most common device used for those who have internet and phone (or TV, internet, and phone) from the same cable company. Some even have built-in DECT, allowing select DECT cordless phone handsets to be directly registered to it, without needing a separate base.")
                } label: {
                    Text("VoIP Modem vs ATA")
                }
                DisclosureGroup {
                    Text("There are 2 ways to connect a landline phone to a cellular service. One is a cell-to-landline Bluetooth adaptor, which combines an ATA with a Bluetooth transceiver. You can pair your cell phone to it and then use your connected phone(s) to make and receive calls through your paired cell phone. A cellular phone jack or cellular phone base combines an ATA with cellular connectivity. Setting up the cellular part is just like setting up cell service on a cell phone. A cell-to-landline Bluetooth adaptor is the simpler and more affordable solution as it pairs with an existing cell phone, which also enables it to work with any calling app.")
                } label: {
                    Text("Cell-To-Landline Solutions")
                }
                DisclosureGroup {
                    Text("A PBX (Private Branch Exchange) is a device that creates multiple internal phone lines (analog, digital, or VoIP) and are usually seen in businesses and hotels. The connection type specifies the type of phones that can be natively connected to it. Each internal phone line is given a unique phone number, called an extension number, which can only be directly dialed from other phones on the same PBX. To access the outside line, a leading digit (e.g. 9) must be dialed to connect the given extension to an outside line (this is why hotel phones say something like \"dial 9 + area code + number\") on their faceplates. There can only be as many extensions on separate outside calls as there are outside lines. The outside line is optional on analog PBXs, so if you just want internal lines, a PBX is a great option.")
                } label: {
                    Text("PBX")
                }
                DisclosureGroup {
                    Text("A phone line simulator is a device that has 2 internal phone lines. Picking up a phone connected to one of the 2 internal lines will ring the other internal line after a few seconds or after a number is dialed. This is an ideal setup for testing or demonstrating phones as you don't have to worry about accidentally calling random numbers since the lines are all internal. A PBX's internal lines can also serve the same purpose, but PBXs often have different dial tones and ring cadences compared to a real line, which a phone line simulator replicates.")
                } label: {
                    Text("Phone Line Simulator")
                }
                DisclosureGroup {
                    Text("You can connect a provider device (VoIP modem/ATA, cellular base, cell-to-landline Bluetooth adaptor, PBX, or phone line simulator) to your house/building wiring by connecting a phone line cord from the device to a jack in the building. Before doing this, you MUST make sure the analog line that may have previously served the jacks has been completely disconnected (not just the number being taken out of service), otherwise the provider device can be damaged from the voltage coming from the analog line. You can plug the provider device into any jack in the building (but NEVER connect more than one to the same building wiring), then you can plug phones/answering systems/other telephone devices into the other jacks. If your house/building is wired for 2 or more lines and you want to use them, you need to plug a provider device into one of the jacks for each line (use a 1-jack-to-2-jack splitter to plug into a 2-line jack).")
                } label: {
                    Text("Using Building Wiring Without Analog Lines")
                }
            }
            .navigationTitle("About Connection Types/Devices")
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
