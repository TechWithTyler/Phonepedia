//
//  AboutCordedPhoneTypesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/31/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct AboutCordedPhoneTypesView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Text("Corded phones come in many styles, from slim, basic wall phones to fully-featured desk phones. Expand the following sections to learn more about each one.")
                .padding()
            List {
                DisclosureGroup {
                    Text("A candlestick phone is a corded phone where the receiver is only used to listen, and the microphone is on the part of the base that sticks up like a candlestick holder, hence the name. The receiver hangs up on a hook to the left of the \"candlestick holder\", hence the terms \"on-hook\", \"off-hook\", and \"switch hook\". This design of phone came before dialing, so picking up the receiver would connect you to an operator (or on today's lines, just give you a dial tone). Unlike most phones, the ringer and most of the circuitry were usually contained in a separate box, called a subset, that was connected to the phone. This was because these components couldn't fit into the candlestick phone itself at the time. As this design of phone is very old and was from the \"phone company owns the phones\" era, most candlestick phones seen today are replicas which have either a rotary dial or keypad, and the ringer and circuitry are in the phone itself.")
                } label: {
                    Text("Candlestick")
                }
                DisclosureGroup {
                    Text("A wooden box phone is similar in concept to a candlestick phone, but the base is shaped like a wooden box instead of a candlestick holder. Visible bells at the top serve as the ringer. These kinds of phones often have a crank on the side, which you turn to ring the operator, and you would stop cranking once the operator answers. These kinds of phones are very old and were from the \"phone company owns the phones\" era, so most wooden box phones seen today are replicas which have either a rotary dial or keypad.")
                } label: {
                    Text("Wooden Box")
                }
                DisclosureGroup {
                    Text("Rotary phones use a dial with numbers on it. You place your finger on the desired number and turn it until it stops, hence the phrase \"dialing a number\". When you release the dial, springs and gears return it to its resting position, causing the phone to go on and off-hook very quickly a certain number of times, corresponding to the number you put your finger on. This quick \"on and off-hook\" is called a pulse. Push-button phones can also send pulses instead of tones. For line-powered push-button phones with button lighting, the light will flash with each pulse.")
                    Text("On most corded phones, you can quickly press the hook switch/switch hook to simulate a pulse dial. This is called \"switch hook dialing\".")
                } label: {
                    Text("Rotary")
                }
                DisclosureGroup {
                    Text("Most push-button phones send tones made up of a low and high frequency, called Dual-Tone Multi-Frequency (DTMF) tones, when numbers are dialed. Most phone services today only support tone dialing, so a pulse-to-tone converter is required if you want to use a rotary phone or pulse-only push-button phone on your line. A pulse-to-tone converter detects the number of pulses and then sends out the corresponding DTMF tone through the line.")
                } label: {
                    Text("Push-Button")
                }
                DisclosureGroup {
                    Text("A desk phone has a base, with or without speakerphone, and a corded receiver. These phones may also have other features like a caller ID display or answering system.")
                } label: {
                    Text("Desk")
                }
                DisclosureGroup {
                    Text("A slim/wall phone typically doesn't have speakerphone or an answering system, but may have a caller ID display. The keypad or rotary dial can be either in the receiver or in the base. The caller ID buttons and display are on the back of the receiver, not the face where the keypad usually is. If wall mounted, this design allows you to view the caller ID list or change settings without picking up the phone.")
                } label: {
                    Text("Slim/Wall")
                }
                DisclosureGroup {
                    Text("A base-less phone is a corded phone that doesn't have a base. The phone is a single device that plugs into the line. Many phones of this style have a hook switch that gets pressed by being placed on a flat surface, while some have an on/off switch or a cover you flip open.")
                } label: {
                    Text("Base-less")
                }
                DisclosureGroup {
                    Text("A novelty phone is a corded phone that's designed to look like something else, like a hamburger you flip open, a piano whose keys are used to dial numbers, a slim phone that's shaped like a pair of lips, an animal, or a cartoon character.")
                } label: {
                    Text("Novelty")
                }
            }
            .navigationTitle("About Dialing Codes")
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
    AboutCordedPhoneTypesView()
}
