//
//  FrequenciesExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/19/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct FrequenciesExplanationView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                // A List doesn't need to rely on a collection like NSTableView or UITableView--you can simply give it a bunch of views if you want!
                Text("Different cordless phones use different wireless frequencies and communication technologies. Expand the sections below to learn more.")
                DisclosureGroup("General") {
                    Text("A lower frequency means a longer wavelength and thus more range.")
                    Text("\"Analog\", \"Digital\", and \"Spread Spectrum\" all refer to cordless telecommunication technologies, not the type of network/device it connects to.")
                }
                DisclosureGroup("Analog") {
                    Text("Analog phones are prone to interference and their signals can be picked up by anyone using a radio scanner set to the same frequency, which isn't ideal for private conversations (e.g., when giving out your credit card number to a bank). When hanging up an analog phone, communication between the handset and base is abruptly terminated, which causes the other end to hear a short burst of noise.")
                    Text("Voice scramble analog phones scramble the audio before it's transmitted between the base and handset, and is then unscrambled when it's sent to the receiving end. For example, when you say \"Hello\" into the handset, it becomes \"Grblm\" (gibberish used as example of scrambled speech) before it's sent to the base, where it then becomes \"Hello\" again before it's sent to the caller. This way, anyone using a radio scanner to pick up the signal will hear the scrambled audio, which they won't be able to understand, while you and the caller hear it as if there wasn't any scrambling at all.")
                }
                DisclosureGroup("Digital") {
                    Text("Digital cordless phones convert signals between audio and digital data when transmitted between the base and handset. The person on the other end won't hear a short burst of noise when hanging up like on an analog phone. Some digital cordless phones operate on only one channel at a time, so they're still prone to interference and their signals can be picked up by a digital radio scanner.")
                    Text("Digital Sequence Spread Spectrum (DSSS), most commonly referred to as simply Digital Spread Spectrum (DSS) phones spread the signal accross multiple channels. Frequency-Hopping Spread Spectrum (FHSS) phones constantly switch between several different channels. Using one of these technologies, if someone were to pick up the signal with a digital radio scanner, they would only hear a very tiny bit of the audio.")
                }
                DisclosureGroup("Dual-Band/Frequency Ranges") {
                    Text("\"Frequency 1/Frequency 2\" (e.g., 5.8GHz/900MHz) means that the base transmits to the handset using frequency 1 and the handset transmits to the base using frequency 2. As a result, the phone may lose connection on the transmit side before losing connection on the receiving side, or vice versa, but the handset will be considered \"out of range\" when either side drops out.")
                    Text("\"Frequency 1-Frequency 2\" (e.g., 1.92GHz-1.93GHz) means that the phone operates in a range of frequencies, not just one specific frequency.")
                }
                DisclosureGroup("DECT (Digital Enhanced Cordless Telecommunications)") {
                    Text("DECT uses encryption, making it the most secure cordless phone frequency. And since it's dedicated to cordless phones, baby monitors, and related devices, other wireless devices won't interfere with the phone.")
                    Text("US and Canada use a slightly different version of DECT, DECT 6.0. 6.0 was chosen as the number instead of 1.9 so people who think \"higher number is better\" will know DECT 6.0 is better than 5.8GHz, 2.4GHz, and 900MHz phones, even though the actual frequency is 1.92-1.93GHz (1920-1930MHz).")
                }
            }
            .navigationTitle("Frequencies/Communication Technologies Explanation")
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
        .frame(minWidth: 600, maxWidth: 600, minHeight: 400, maxHeight: 400)
#endif
    }
    
}

#Preview {
    FrequenciesExplanationView()
}
