//
//  FrequenciesExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
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
                Text("Different cordless phones use different wireless frequencies and communication technologies. Expand the following sections to learn more.")
                DisclosureGroup("General") {
                    Text("Cordless phones, like any wireless device, use radio waves, and with all radio waves, a lower frequency means a longer wavelength and thus more range.")
                    Text("Frequencies are named for how often a wave oscillates per second. Waves with shorter wavelengths oscillate more frequently. To oscillate means to move back and forth repeatedly.")
                    Text("In cordless phones, radio waves oscillate by changing their electromagnetic fields. A shorter wavelength means more frequent oscillations, resulting in a higher frequency.")
                    Text("\"Analog\", \"Digital\", and \"Spread Spectrum\" all refer to cordless telecommunication technologies, not the type of network/device the base connects to.")
                    Text("If a speaker is close to a cordless phone (or any wireless device), a buzzing sound may be heard, and the frequency of the buzzing depends on, but is not equal to, the wireless frequency. For example, a speaker may buzz at 50Hz when near a DECT 6.0 (1.92-1.93GHz or 1920-1930MHz) cordless phone.")
                }
                DisclosureGroup("MHz and GHz") {
                    Text("MHz = Megahertz")
                    Text("GHz = Gigahertz")
                    Text("Divide MHz by 1000 to get GHz. For example, 1920MHz divided by 1000 = 1.92GHz. For frequencies above 1000MHz (1GHz), GHz is often used instead of MHz.")
                }
                DisclosureGroup("Visual Representation of Radio Waves") {
                    CordlessPhoneRadioWaveView()
                }
                DisclosureGroup("Analog") {
                    Text("Analog phones transmit and receive analog audio signals. These phones are prone to interference and their signals can be picked up by anyone using a radio scanner set to the same frequency, which isn't ideal for private conversations (e.g., when giving out your credit card number to a bank or entering the password for your voicemail). When hanging up an analog phone, when dialing numbers, or pressing other buttons that send a command to the base, communication between the handset and base is briefly interrupted, which causes the other end to hear a short burst of noise. On some phones, placing the handset on the base will cause the phone to hang up immediately by terminating the handset and base connections at the same time, in which case this burst of noise won't be heard. Another way you can tell you're using an analog phone is if you or the other end hear static when going out of range, vs the audio clipping in and out on a digital cordless phone.")
                    Text("Some 46-49MHz and 900MHz analog phones include a technology known as voice scrambling, which scrambles the audio before it's transmitted between the base and handset, and is then unscrambled when it's sent to the receiving end. For example, when you say \"Hello\" into the handset, it becomes \"Grblm\" (gibberish used as example of scrambled speech) before it's sent to the base, where it then becomes \"Hello\" again before it's sent to the caller. This way, anyone using a radio scanner to pick up the signal will hear the scrambled audio, which they likely won't be able to understand, while you and the caller hear it as if there wasn't any scrambling at all.")
                    Text("There are many voice scrambling methods. Frequency inversion scrambling, the most common and least complex, flips the audio spectrum, so low frequencies become high frequencies, and vice versa. Split-band scrambling divides and inverts parts of the audio spectrum. Time-division scrambling chops the signal into segments and rearranges them. Rolling code scrambling uses dynamic codes to continuously alter the signal. Noise injection adds artificial noise to obscure the voice.")
                    ExampleAudioView(audioFile: .analogCordlessPhoneAudioSampleNormal)
                    ExampleAudioView(audioFile: .analogCordlessPhoneAudioSampleScrambled)
                }
                DisclosureGroup("Digital") {
                    Text("Digital cordless phones convert signals between analog audio signals and digital data when transmitted between the base and handset. The person on the other end won't hear a short burst of noise when you hang up or press buttons like on an analog phone. Some digital cordless phones operate on only one channel at a time, so they're still prone to interference and their signals can be picked up by a digital radio scanner, which may reveal information about the communication or decode the audio data.")
                    Text("Digital Sequence Spread Spectrum (DSSS) phones spread the signal across multiple channels. This is  most commonly referred to as simply Digital Spread Spectrum (DSS). Frequency-Hopping Spread Spectrum (FHSS) phones constantly switch between several different channels. Using one of these technologies, if someone were to pick up the signal with a digital radio scanner, they would only hear a very tiny bit of the audio if it were to be decoded.")
                }
                DisclosureGroup("Dual-Band/Frequency Ranges") {
                    Text("\"Frequency 1/Frequency 2\" (e.g., 5.8GHz/900MHz) means that the base transmits to the handset using frequency 1 and the handset transmits to the base using frequency 2. As a result, the phone may lose connection on the transmit side before losing connection on the receiving side, or vice versa, but the handset will be considered \"out of range\" when either side drops out.")
                    Text("\"Frequency 1-Frequency 2\" (e.g., 1.92GHz-1.93GHz) means that the phone operates in a range of frequencies, not just one specific frequency. A specific frequency within a range is called a channel. The frequencies are within a few MHz (often 10-20MHz) of each other.")
                }
                DisclosureGroup("DECT (Digital Enhanced Cordless Telecommunications)") {
                    Text("DECT uses encryption, making it the most secure cordless phone frequency. Since it's dedicated to cordless phones, baby monitors, and related devices, interference from other wireless technologies is minimal, and DECT devices rarely interfere with each other. Different countries use different frequencies for DECT.")
                    Text("1.786–1.792GHz (1786–1792MHz) is used in South Korea.")
                    Text("1.88–1.895GHz (1880–1895MHz) is used in Taiwan.")
                    Text("1.88–1.90GHz (1880–190MHz) is used for DECT in Europe, the UK, Ireland, Australia, New Zealand, and the Middle East. Throughout \(appName!), it's referred to as ETSI DECT (ETSI standing for European Telecommunications Standards Institute).")
                    Text("J-DECT (1.893–1.906GHz or 1893–1906MHz) is used in Japan.")
                    Text("1.91–1.92GHz (1910–1920MHz) is used in Brazil.")
                    Text("1.91–1.93GHz (1910–1930MHz) is used in parts of Latin America.")
                    Text("DECT 6.0 (1.92–1.93GHz or 1920–1930MHz) is used in the US, Canada, and Mexico.")
                }
                DisclosureGroup("Marketing vs Actual Frequency Range") {
                    Text("46-49MHz cordless phones are often referred to as 46-49MHz because that's the frequency range they typically operate in, and is shown as such throughout \(appName!), although the actual frequency range is 43-46MHz for the base and 48-49MHz for the handset.")
                    Text("The actual frequency range for 900MHz cordless phones is 902-928MHz. Rounding down for marketing/documentation makes it simpler to understand.")
                    Text("The actual frequency range for 2.4GHz cordless phones is 2.400–2.4835GHz (2400-2483.5MHz). Rounding down for marketing/documentation makes it simpler to understand.")
                    Text("The actual frequency range for 5.8GHz cordless phones is 5.725-5.850GHz (5725-5850MHz). Rounding up for marketing/documentation makes it simpler to understand.")
                    Text("DECT in the US uses the 1.92-1.93GHz (1920-1930MHz) frequency range, often referred to as simply 1.9GHz. DECT in other countries uses different frequency ranges as explained in the above section, and may be referred to as simply 1.7GHz, 1.8GHz, or 1.9GHz. DECT in North America is more commonly referred to as DECT 6.0 so people who think \"higher number is better\" will know DECT 6.0 is better than 5.8GHz, 2.4GHz, and 900MHz phones. DECT in other countries may be refered to as DECT 6.0 depending on the manufacturer.")
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
