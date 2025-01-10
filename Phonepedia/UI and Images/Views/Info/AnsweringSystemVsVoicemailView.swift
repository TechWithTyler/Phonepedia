//
//  AnsweringSystemVsVoicemailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/9/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AnsweringSystemVsVoicemailView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Text("Answering systems and voicemail services do the same thing: answer calls and take caller messages when you're not avaiable to answer the phone. However, there are some important differences between the 2, even though some people use \"answering system\" and \"voicemail\" interchangeably. If your phone is indicating new messages but there are none when you go to check them, it's likely because the message was left in the voicemail service and you went to play the answering system messages or vice versa. Expand the following sections to learn more about each one.")
                .padding()
            List {
                DisclosureGroup {
                    Text("A device connected to a phone line or built into a phone.")
                    Text("Often represented by a tape cassette icon (\(Image(systemName: "recordingtape"))). Note that on cell phones")
                    Text("Requires power/phone service to answer calls.")
                    Text("Stores messages in digital memory (modern answering systems) or tape cassettes (early answering systems).")
                    Text("Features or prompts mentioning \"answering system\", \"answering machine\", or \"messages\".")
                    Text("New messages indicated by a light or display message on the phone or answering system.")
                    Text("Allows instant playback by simply pressing a button.")
                    Text("Messages are never lost when switching phone providers.")
                    Text("Messages can only be accessed by the phone/answering system they're recorded on.")
                    Text("Doesn't allow messages to be transcribed.")
                    Text("Messages can be accessed remotely by entering your remote access code during or after the greeting.")
                    Text("Basic set of options during remote access.")
                    Text("Number of rings, recording time, and other settings can be changed directly from the phone/answering system.")
                    Text("Messages can only be transferred between mailboxes on the same answering system.")
                    Text("Messages can be heard while they're being left (call screening).")
                    Text("Can show caller ID during message playback (phones/answering systems with displays only).")
                } label: {
                    Label("Answering Systems", systemImage: "recordingtape")
                        .foregroundStyle(.primary)
                }
                DisclosureGroup {
                    Text("A service provided by a phone company.")
                    Text("Often represented by an envelope icon (\(Image(systemName: "envelope"))). Some phones may use a tape cassette icon (\(Image(systemName: "recordingtape"))) to represent voicemail instead of an envelope icon (\(Image(systemName: "envelope"))).")
                    Text("Can answer calls even if the power is out/phone service is down.")
                    Text("Stores messages on a server hosted by the phone company.")
                    Text("Features or prompts mentioning \"voicemail\", \"voice mail\", or \"VM\".")
                    Text("Your phone company sends signals to the phone to tell it to show a new voicemail alert (if the phone supports it).")
                    Text("Requires dialing an access code/your phone number and a password to access messages.")
                    Text("You can't transfer your messages to another phone company if you switch.")
                    Text("Messages can be accessed by any phone on your line, via the web, mobile apps, voicemail-to-email, or voicemail-to-text.")
                    Text("Messages can be transcribed so you can read your messages.")
                    Text("Messages can be accessed from another phone by entering your password during or after the greeting, or by calling your phone company's main voicemail number and entering your phone number and password.")
                    Text("More extensive set of options when calling from a phone (e.g., \"To play your messages, press 1. To send a message, press 2. To change your settings, press 3.\".")
                    Text("Number of rings, recording time, and other settings need to be configured online, via an app, or by contacting your phone company.")
                    Text("Offers advanced features such as sending/forwarding messages to another mailbox on the same voiemail system, and replying to voicemails.")
                    Text("Messages can't be heard while they're being left, unless using a VoIP phone designed to work with the specific voicemail service.")
                    Text("Caller ID can only be displayed during message playback if using a VoIP phone designed to work with the specific voicemail service.")
                } label: {
                    Label("Voicemail", systemImage: "envelope")
                        .foregroundStyle(.primary)
                }
                DisclosureGroup {
                    Text("If you want to use an answering system and voicemail together (e.g., have a backup voicemail system to take messages when you're on the phone or the power is out), set your answering system to answer before the voicemail service by setting the answering system's number of rings to be less than that of the voicemail service.")
                    Text("If you mainly use the answering system and want to access the voicemail service to check its messages while away from your phone, you'll need to dial your phone company's main voicemail number.")
                } label: {
                    Text("Using An Answering System and Voicemail Together")
                }
            }
            .navigationTitle("Answering System vs Voicemail")
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
    AnsweringSystemVsVoicemailView()
}
