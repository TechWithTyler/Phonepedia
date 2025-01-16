//
//  HandsetMessagingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetMessagingView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            if phone.hasAnsweringSystem > 1 && handset.displayType > 0 {
                Picker("Answering System Menu", selection: $handset.answeringSystemMenu) {
                    Text("Settings Only (Doesn't Require Link to Base)").tag(0)
                    Text("Settings Only (Requires Link to Base)").tag(1)
                    Text("Full (Doesn't Require Link to Base)").tag(2)
                    Text("Full (Requires Link to Base)").tag(3)
                }
                InfoText("Settings Only: Only settings are available in the answering system menu. This may or may not include greeting recording/playback/deletion. Message playback is a separate menu item or button.\nFull: Most, if not all, features and settings are available in the answering system menu.")
                AnsweringSystemMenuInfoView()
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
        HandsetMessagingView(handset: CordlessHandset(brand: "AT&T", model: "CL80107", mainColorRed: 200, mainColorGreen: 200, mainColorBlue: 200, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0))
    }
    .formStyle(.grouped)
}
