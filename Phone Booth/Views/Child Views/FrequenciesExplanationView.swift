//
//  FrequenciesExplanationView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 10/19/23.
//

import SwiftUI

struct FrequenciesExplanationView: View {

	@Environment(\.dismiss) var dismiss

    var body: some View {
			Text("""
   • A lower frequency means more range.
   • Analog phones are prone to interference and their signals can be picked up by anyone using a radio scanner set to the same frequency, which isn't ideal for private conversations.
   • Voice scramble phones scramble the audio before it's transmitted between the base and handset, and is then unscrambled when it's sent to the receiving end. Example: When you say "Hello" into the handset, it becomes "Grblm" before it is sent to the base, and then becomes "Hello" again before it's sent to the caller. This way, anyone using a radio scanner to pick up the signal will hear the scrambled audio, which they won't be able to understand.
   • Digital Spread Spectrum phones constantly switch between several different wireless channels, so if someone were to pick up the signal with a digital radio scanner, they would only hear a very tiny bit of the audio.
   • "Frequency 1/Frequency 2" (e.g. 5.8GHz/900MHz) means that the base transmits to the handset using frequency 1 and the handset transmits to the base using frequency 2. As a result, the phone may lose connection on the transmit side before losing connection on the receiving side, or vice versa.
   • "Frequency 1-Frequency 2" (e.g. 1.92GHz-1.93GHz) means that the phone operates in a range of frequencies, not just one specific frequency.
   • DECT uses encryption, making it the most secure cordless phone frequency. And since it's dedicated to cordless phones, baby monitors, and related devices, other wireless devices won't interfere with the phone.
   """)
		.padding()
		.frame(width: 500, height: 400)
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button {
					dismiss()
				} label: {
					Text("Done")
				}
				.keyboardShortcut(.return)
			}
		}
    }
}

#Preview {
    FrequenciesExplanationView()
}
