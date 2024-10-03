//
//  HandsetMessagingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetMessagingView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            if phone.hasAnsweringSystem > 1 {
                Picker("Answering System Menu", selection: $handset.answeringSystemMenu) {
                    Text("Settings Only (doesn't require link to base").tag(0)
                    Text("Settings Only (requires link to base)").tag(1)
                    Text("Full (doesn't require link to base").tag(2)
                    Text("Full (requires link to base)").tag(3)
                }
                InfoText("Settings Only: Only settings are available in the answering system menu. Message playback is a separate menu item or button.\nFull: Message playback and settings are available in the answering system menu.")
            }
            Picker("Voicemail Quick Dial", selection: $handset.voicemailQuickDial) {
                Text("None").tag(0)
                Text("Button").tag(1)
                Text("Speed Dial 1").tag(2)
                if handset.displayType > 0 {
                    Text("Message Menu Item").tag(3)
                    Text("Main Menu Item").tag(4)
                    Text("Main Menu Item and Button").tag(5)
                }
            }
            .onChange(of: handset.voicemailQuickDial) { oldValue, newValue in
                handset.voicemailQuickDialChanged(oldValue: oldValue, newValue: newValue)
            }
            VoicemailQuickDialInfoView()
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetMessagingView(handset: CordlessHandset(brand: "AT&T", model: "CL80107", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0))
    }
    .formStyle(.grouped)
}
