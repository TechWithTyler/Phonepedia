//
//  AnsweringSystemMenuInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/22/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct AnsweringSystemMenuInfoView: View {
    var body: some View {
        InfoText("""
The answering system menu allows you to change settings such as:
• Number of rings: How many times the phone rings before the answering system answers a call. Selecting "Toll Saver" means the system answers after a certain number of rings if there are new messages (often 2 rings), or a few more rings if there are no new messages (often 4 rings). This allows you to know if you have new messages based on how many rings you hear, so you can hang up before the system answers without being charged for the call.
• Recording time: How long each caller message can be.
• Remote access code: The code to be entered from a phone while the greeting is playing/a message is being recorded, to play messages and access the system remotely.
• Greeting only mode: Whether to play the greeting and not accept incoming messages. This may be an option in the recording time setting.
• Call screening: Whether the greeting and/or incoming messages are heard on the speaker.
• Message alert: Whether to sound a tone every so often when there are new messages. Handsets may have an option for the indicator light (if it has one) to flash when there are new messages in either the answering system or phone company voicemail.
""")
    }
}

#Preview {
    AnsweringSystemMenuInfoView()
}
