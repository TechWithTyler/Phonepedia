//
//  AboutConnectionTypesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/16/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AboutConnectionTypesView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Text("The connection type specifies how a phone connects to the telephone network or to an internal line. Expand the following sections to learn about each one.")
                .padding()
            List {
                DisclosureGroup {
                    Text("Analog phones are the most common, connecting to a VoIP modem, cell-to-landline Bluetooth adaptor, cellular phone jack/base, PBX, or a copper line. Despite the phase-out of copper lines, many phones still take analog line connections to make them affordable, easy to set up, and compatible with any of the aforementioned devices. \"Analog\" refers to the phone line connection, and is not to be confused with \"analog cordless phone\", which refers to an analog wireless connection between a cordless phone's handset and base.")
                    Text("Today's analog phones use an RJ11 connector for single-line connections or RJ14 for 2-line connections. Some phones use RJ25 for 3-line connections or RJ61 for 4-line connections, but most phones today use 2 RJ14 jacks for 3 or 4-line connections. Some very old phones used different types of connectors, so an adaptor will be necessary to connect such phones to an RJ jack.")
                } label: {
                    Text("Analog Phone")
                }
                DisclosureGroup {
                    Text("Digital phones were very rare, connecting to a special digital phone modem or RJ45 jack. \"Digital\" refers to the phone line connection, and is not to be confused with \"digital cordless phone\", which refers to a digital wireless connection between a cordless phone's handset and base.")
                } label: {
                    Text("Digital Phone")
                }
                DisclosureGroup {
                    Text("VoIP is how most telecommunication works today, and is the backbone for video conferencing services. Modern cell towers use VoIP for their network connection, allowing for features like Wi-Fi calling.")
                    Text("The latency in VoIP audio varies depending on the network connection and the infrastructure the call is travelling through. For example, if both ends of a call are extensions on the same VoIP PBX system on your local network, the latency is lower than if you were talking to someone over the internet.")
                    Text("Dedicated VoIP phones can only work with an Ethernet (RJ45 jack) or Wi-Fi connection, and may require paying for extra hardware or subscriptions, which makes them not as good for phone collectors who don't want to pay too much for the necessary hardware and providers. These phones offer landline comfort and convenience while integrating natively with VoIP provider features like voicemail and call forwarding.")
                    Text("To connect an analog phone to VoIP, you need a cable modem or analog telephone adaptor (ATA).")
                    Text("Some phones can connect to an analog line and Ethernet, allowing you to use both an analog and VoIP line on the same phone. This allows you to fall back to an analog line if your VoIP service isn't available, or to use an analog line now and VoIP in the future. You can also use this to connect a cell-to-landline Bluetooth adaptor and VoIP to the same phone.")
                    Text("To place an Ethernet VoIP phone or ATA in locations where Ethernet jacks aren't available, such as in a bedroom away from your modem, you need a Wi-Fi-to-Ethernet bridge (most Wi-Fi range extenders can be used this way if they're set to extender or client mode). This is not to be confused with a Wi-Fi router, which takes in an Ethernet connection and transmits it as Wi-Fi.")
                } label: {
                    Text("VoIP (Voice-over-Internet Protocol)")
                }
                DisclosureGroup {
                    Text("A cellular corded or cordless phone (not to be confused with a cell-phone-linking-capable corded or cordless phone) is a corded or cordless phone that has a SIM card and connects to cell towers. These phones offer landline comfort and convenience while integrating natively with cell phone provider features like visual voicemail. To connect an analog phone to cellular, you need a cellular phone jack or cellular gateway with a SIM card installed. Setting up the cellular part is just like setting up cell service on a cell phone.")
                } label: {
                    Text("Cellular Corded or Cordless Phone")
                }
                DisclosureGroup {
                    Text("An ATA (Analog Telephone Adaptor/Analog Terminal Adaptor) allows an analog phone (most home phones sold today) to be used on a digital, VoIP, or cellular service. These can connect to any compatible provider of the respective service. A VoIP modem, on the other hand, combines the internet connection and ATA (and sometimes Wi-Fi router) into a single device, and is the most common device used for those who have internet and phone (or TV, internet, and phone) from the same cable company. Some even have built-in DECT, allowing select DECT cordless phone handsets to be directly registered to it, without needing a separate base.")
                } label: {
                    Text("VoIP Modem/ATA")
                }
                DisclosureGroup {
                    Text("There are 2 ways to connect a landline phone to a cellular service. One is a cell-to-landline Bluetooth adaptor, which combines an ATA with a Bluetooth transceiver. You can pair your cell phone to it and then use your connected phone(s) to make and receive calls through your paired cell phone. Quality may vary depending on the version of Bluetooth your cell phone and adaptor uses. A cellular phone jack or cellular phone base combines an ATA with cellular connectivity. Setting up the cellular part is just like setting up cell service on a cell phone. A cell-to-landline Bluetooth adaptor is the simpler and more affordable solution as it pairs with an existing cell phone, which also enables it to work with any calling app.")
                } label: {
                    Text("Cell-To-Landline Solutions")
                }
                DisclosureGroup(isExpanded: $dialogManager.aboutPBXExpanded) {
                    Text("A PBX is a device that creates multiple internal phone lines (analog, digital, or VoIP). PBXs are usually seen in businesses and hotels. Analog or digital phone jacks on a PBX directly correspond to an internal phone line called an extension. Ethernet jacks on a VoIP PBX are only used to connect phones/devices to the network--the device itself needs to be configured to use the desired extension. Each extension is assigned an internal number called an extension number, which can only be dialed from phones/devices on the same PBX. To access the outside line, a leading digit (e.g. 9) must be dialed to connect the given extension to an outside line (this is why hotel phones say something like \"dial 9 + area code + number\") on their faceplates. There can only be as many extensions on separate outside calls as there are outside lines. The outside line is optional on many PBXs, so if you just want internal lines, a PBX is a great option.")
                    Text("Many PBXs allow dialing of the emergency number (e.g. 911 in the US) without a leading digit. When the emergency number is dialed, the PBX \"repeats\" the number to an analog outside line or sends the corresponding VoIP signal to a VoIP outside line.")
                    Text("On a PBX, an outside line is often called a trunk. The outside line(s) can be thought of like the trunks of a tree, with the internal lines being the branches.")
                    Text("Early PBXs worked like switchboards but for a business' internal phone system. With switchboards and early PBX systems, an operator would connect the caller to the desired extension by plugging a cord into the correct jack, which would connect the caller to the extension. Modern PBXs automate the process and are sometimes called Private Automatic Branch Exchanges (PABX).")
                    Text("Voicemail on a PBX is stored on the PBX itself or a module connected to it, and can be accessed by dialing a specific extension number.")
                } label: {
                    Text("PBX (Private Branch Exchange)")
                }
                DisclosureGroup {
                    Text("A phone line simulator is a device that has 2 internal analog phone lines and is designed to simulate a central office (CO). Picking up a phone connected to one of the 2 internal lines will ring the other internal line after a few seconds or after a number is dialed. This is an ideal setup for testing or demonstrating phones as you don't have to worry about accidentally calling random numbers since the lines are all internal. A PBX's internal lines can also serve the same purpose, but PBXs often have different dial tones and ring cadences compared to a real line, which a phone line simulator replicates.")
                } label: {
                    Text("Phone Line Simulator")
                }
                DisclosureGroup {
                    let exampleDTMFCallerIDNumber = "2079460018"
                    Text("To make an analog phone ring, a high-voltage AC signal is sent to the phone line and rapidly pulses on and off at a specific frequency (e.g. 20-25Hz in the US). With mechanical ringers, the \"on\" causes the striker to hit the bell, and the \"off\" causes the striker to reset. In a phone with a dual-bell ringer, the striker is always against a bell. With electronic ringers, the \"on\" causes the ringer to make a sound, and the \"off\" causes the sound to stop. The actual tone/pattern of the ringer is determined by the programming of the ringer. For example, most piezo ringers play a tone consisting of 2 alternate frequencies for as long as the ring signal is applied. The fade-out or slight continuation of the sound when the ring stops is due to the delay circuitry/programming in the ringer, which prevents the tone from restarting from the beginning with every \"on\".")
                    Text("To let an analog phone know when a call has ended, the line power is cut off for about a second or 2. This is called loop current disconnect and allows answering systems/other automated systems and some speakerphones to automatically hang up. If the phone is still off-hook, soon after the line power comes back on, a dial tone or busy tone may be heard to let you know the call has ended. Many provider devices (see above sections) allow you to configure the call end behavior.")
                    Text("Analog phones in many countries usually receive caller ID and voicemail indicator on/off data in the form of special tones, called Frequency-Shift-Keying (FSK) tones. In many countries, caller ID FSK tones are sent after the first ring, which is why caller ID usually won't display on an analog phone right as it starts ringing or if you connect it to the line after the first ring. If caller ID FSK tones were to be sent after each ring, the phone may end up logging the caller ID data as a missed call each time.")
                    ExampleAudioView(audioFile: .ringAndCallerIDFSK)
                    Text("Some phones also support DTMF (Dual-Tone Multi-Frequency) caller ID, which is a different way of sending the caller ID data. DTMF caller ID is sent as a series of DTMF tones, which are the same tones used for dialing numbers on a touch-tone phone. The first and last DTMF tones are different from the tones that make up the digits of the number, and are used to tell the phone when the caller ID data starts and ends. The start tone (e.g. D) tells the phone to listen for the tones that follow, and the end tone (e.g. C) tells the phone that caller ID transmission is done and the number can now be presented as caller ID (i.e., displayed, logged in the caller ID list, and/or announced depending on the phone). For example, if the DTMF tone D is transmitted to indicate the beginning of the caller ID data, the DTMF tone C is transmitted to indicate the end of the caller ID data, and the caller ID number is the UK domestic number \(exampleDTMFCallerIDNumber), the DTMF tones that make up the caller ID data would be D\(exampleDTMFCallerIDNumber)C. As there are only 16 possible DTMF digits (0-9, star, pound, and A-D), DTMF caller ID can't transmit names. DTMF caller ID is slower to be displayed on a phone than FSK caller ID, as it takes longer to transmit each tone of a long DTMF caller ID string than a short FSK tone, just like how the tones that make up dial-up internet take longer to be sent/received than the quick pulses of light over fiber internet.")
                    ExampleAudioView(audioFile: .dtmfCallerID)
                    Text("In some countries, the polarity of the phone line is briefly reversed to let the phone know that caller ID is about to be received.")
                    Text("You can't hear most under-the-hood line activity, such as the ring signal or caller ID tones, unless you use a device that allows you to listen in on the phone line without going off-hook (e.g., a lineman's handset, a special phone with wires that clip onto a phone line for testing purposes, in monitor mode).")
                    Text("Constant/repeating tones (e.g. a dial tone, busy tone, or reorder/fast busy tone) are used as a \"call ended\" signal when the provider device doesn't use loop current disconnect or if it's not long enough to trigger a hangup.")
                    Text("If your provider device allows you to customize call end behavior, you can play with different combinations of settings to see how each of your phones react.")
                } label: {
                    Text("Analog Phone Signaling")
                }
                DisclosureGroup {
                    let exampleLine1Number = NameNumberExamples.formatPhoneNumber(areaCode: "201", centralExchange: "678", localNumber: "3845", withFormat: .parentheses)
                    let exampleLine2Number = NameNumberExamples.formatPhoneNumber(areaCode: "201", centralExchange: "678", localNumber: "3904", withFormat: .parentheses)
                    Text("You can connect a provider device (VoIP modem/ATA, cellular gateway, cell-to-landline Bluetooth adaptor, PBX extension, or phone line simulator) to your house/building wiring by connecting a phone line cord from the device to a jack in the building. Before doing this, you MUST make sure the analog line that may have previously served the jacks has been completely disconnected (not just the number being taken out of service), otherwise the provider device can be damaged from the voltage coming from the analog line or vice versa. You can plug the provider device into any jack in the building (but NEVER connect more than one to the same building wiring), then you can plug phones/answering systems/other telephone devices into the other jacks. If your house/building is wired for 2 or more lines and you want to use them, you need to plug a provider device into one of the jacks for each line (use a 1-jack-to-2-jack splitter to plug into a 2-line jack).")
                    Text("If your building has (or used to have) analog lines running from a central office, there may be a small box outside, called a network interface device (NID). Inside that box are wires which connect one point (the building wiring) to another point (the central office). If you want to use the building wiring, you need to disconnect the wires inside that box. If you don't know how to do this, consult a professional.")
                    // The suffix(_:) method is used to get only the last n characters of a String, where n represents the number of characters from the end of the string. Here, we pass 4 to get the last 4 digits of example phone numbers. Think of this method as placing your text cursor at the end of the string and moving it back n times.
                    Text("A group of multiple jacks will usually have a spot for a phone number label. You can write your phone number (or its last set of digits) to help you know which jack goes to which line. For example, if your numbers are US numbers, one of them is \(exampleLine1Number), and the other is \(exampleLine2Number), you might write \"\(exampleLine1Number.suffix(4))\" on one jack and \"\(exampleLine2Number.suffix(4))\" on the other, if the rest of the number is the same for both.")
                } label: {
                    Text("Using Building Wiring Without Analog Lines")
                }
            }
            .navigationTitle("About Connection Types/Devices")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dialogManager.aboutPBXExpanded = false
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
