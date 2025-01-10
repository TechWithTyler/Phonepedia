//
//  PhoneMessagingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneMessagingView: View {

    @EnvironmentObject var dialogManager: DialogManager

    @Bindable var phone: Phone

    var body: some View {
        InfoButton(title: "Answering System vs Voicemail…") {
            dialogManager.showingAnsweringSystemVsVoicemail = true
        }
        Section("Answering System") {
            Picker("Answering System", selection: $phone.hasAnsweringSystem) {
                if phone.isCordless {
                    Text("None").tag(0)
                    Text("Base Only").tag(1)
                    Text("Handset Only").tag(2)
                    Text("Base or Handset").tag(3)
                } else {
                    Text("No").tag(0)
                    Text("Yes").tag(1)
                }
            }
            if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
                Picker("Answering System Type", selection: $phone.answeringSystemType) {
                    Text("Tape Cassette(s)").tag(0)
                    Text("Digital").tag(1)
                }
                InfoText("Early answering systems stored messages on a tape cassette. The greeting is stored either on the same cassette as the messages (single-cassette systems), on a separate cassette (dual-cassette systems), or digitally. Storing the greeting on the same cassette as the messages results in a delay between the greeting and the beep, as the system needs to move the tape forward to the end where the message is to be recorded. Some models can count the number of messages on the tape by detecting the beeps on the tape.\nModern answering systems are fully digital, meaning messages are stored on a memory chip. This allows for quicker operation.")
                Picker("Multi-Line Button Layout", selection: $phone.answeringSystemMultilineButtonLayout) {
                    Text("Separate Buttons").tag(0)
                    Text("Line Selection Button").tag(1)
                }
                InfoText("Multi-line phones either have separate play and answer on/off buttons for each line, or one play and answer on/off button as well as a button which selects the line(s) those buttons will use.")
            }
            if phone.hasAnsweringSystem > 0 && phone.baseBluetoothCellPhonesSupported > 0 && phone.answeringSystemType == 1 {
                Toggle("Answering System For Cell Lines", isOn: $phone.answeringSystemForCellLines)
                InfoText("On some Bluetooth cell phone-linking phones with answering system, the answering system can answer calls on the cell line.")
            }
            if !phone.isCordless && phone.hasAnsweringSystem == 1 {
                Picker("Answering System Menu", selection: $phone.answeringSystemMenuOnBase) {
                    Text("Voice Prompts").tag(0)
                    if phone.baseDisplayType > 0 {
                        Text("Display Menu").tag(1)
                    }
                }
                AnsweringSystemMenuInfoView()
            } else if phone.isCordless && (phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3) {
                Picker("Answering System Menu (Base)", selection: $phone.answeringSystemMenuOnBase) {
                    Text("None").tag(0)
                    Text("Voice Prompts").tag(1)
                    if phone.baseDisplayType > 2 {
                        Text("Display Menu").tag(2)
                    }
                }
                AnsweringSystemMenuInfoView()
            }
            if phone.hasAnsweringSystem == 3 {
                Picker("Greeting Management From", selection: $phone.greetingRecordingOnBaseOrHandset) {
                    Text("Base Only").tag(0)
                    Text("Handset Only").tag(1)
                    Text("Base or Handset").tag(2)
                }
            }
            InfoText("The greeting, sometimes called the announcement or outgoing message, is the message the answering system plays to callers when it answers, before optionally allowing the caller to leave a message. Example: \"Hello. You have reached \(names.randomElement()!). I'm not available to take your call, so please \(AnsweringSystemGreetingComponents.leaveOrRecord()) \(AnsweringSystemGreetingComponents.aOrYour()) message after the \(AnsweringSystemGreetingComponents.beepOrTone()).\"")
            if phone.hasAnsweringSystem > 0 {
                Toggle("Has Greeting Only Mode", isOn: $phone.hasGreetingOnlyMode)
                InfoText("Greeting Only, sometimes called Announce Only or Answer Only, answers calls but doesn't accept incoming messages. Some phones allow you to record a separate greeting for both modes, allowing you to easily switch between modes without having to re-record your greeting each time. Example: \"Hello. You have reached \(names.randomElement()!). I'm not available to take your call, so please call again later.\"")
                Toggle("Has Message Alert by Call", isOn: $phone.hasMessageAlertByCall)
                InfoText("This feature allows the answering system to call out to a stored phone number each time a new message is left, so you don't have to constantly be calling to check for new messages while you're away.")
                Toggle("Can Record Voice Memos", isOn: $phone.canRecordVoiceMemos)
                InfoText("Some answering systems allow you to record voice memos, which are saved like incoming messages but don't involve the phone line.")
                Picker("Number of Mailboxes", selection: $phone.numberOfMailboxes) {
                    Text(phone.numberOfLandlines == 1 ? "1" : "One For Each Line").tag(1)
                    if phone.numberOfLandlines == 1 {
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                    }
                }
                InfoText("On single-line phones, mailboxes allow you to organize messages for different people or purposes. In your greeting, instruct callers to choose the desired mailbox. Example: \"For Jack, press 1, or just stay on the line. For Jill, press 2. For Jim, press 3.\"\nOn multi-line phones, each line has its own answering system, which can be independently turned on/off. Incoming messages will be stored in the answering system corresponding to the line receiving the call. On some phones, you can only remotely access the answering system of the line you're calling, while on others, you can access any line remotely no matter which line you're calling.")
                if phone.isCordedCordless && phone.maxCordlessHandsets >= 8 && phone.numberOfLandlines == 4 {
                    Toggle("Auto Attendant/Personal Mailboxes", isOn: $phone.hasAutoAttendantAndPersonalMailboxes)
                    InfoText("On a business phone with multiple cordless handsets/desksets, each handset/deskset can have its own mailbox, which can only be accessed by that handset/deskset or the base. There's also a main mailbox, often called the general delivery mailbox, for any messages not directed to a specific personal mailbox, that the base and all handsets/desksets can access.\nAn automated attendant system can route callers to a specific handset/deskset by asking callers to enter the handset's/deskset's extension number, which is the number assigned when the handset/deskset is registered to the base. If the call isn't answered, the caller can leave a message in the personal mailbox.\nMessages are stored in the base in the slot corresponding to the registered handset/deskset--you can't access the personal mailbox of a handset/deskset if it's out of range of the base.")
                }
                Picker("Call Recording", selection: $phone.hasCallRecording) {
                    Text("Not Supported").tag(0)
                    Text("Without Notification").tag(1)
                    Text("Intermittent Beeps").tag(2)
                    Text("Spoken Notification").tag(3)
                }
                InfoText("Call recording allows you to record both sides of a phone call as an answering system message. In some areas, it's illegal to record calls without the other party's consent.\n• Without Notification: The caller isn't notified when call recording starts. It is your responsibility to tell the caller that you're recording the call.\n• Intermittent beeps: Both you and the caller hear a beep every 15 seconds or so, indicating call recording is in progress. It is your responsibility to tell the caller that you're recording the call.\n• Spoken Notification: A spoken notification is played to you and the caller (e.g., \"This call is being recorded.\" before recording starts. This takes care of the legal requirement to tell the caller that you're recording the call.")
            }
        }
        Section("Voicemail") {
            Picker("\"New Voicemail\" Detection Method", selection: $phone.voicemailIndication) {
                Text("None").tag(0)
                Text("Frequency-Shift-Keying (FSK) Tones").tag(1)
                Text("Listen For Stutter Dial Tones").tag(2)
                Text("FSK and Stutter Dial Tone").tag(3)
            }
            InfoText("""
A phone's voicemail indicator usually works in one or both of the following ways:
• Your phone company may send special tones, called Frequency-Shift-Keying (FSK) tones to the phone whenever a new voicemail is left, and another when all new voicemails are played, to tell the phone to turn on or off its voicemail indicator. You can't hear these tones unless you use a device to listen in on the phone line without picking it up (e.g. a butt-set phone in monitor mode).
• The phone may go off-hook for a few seconds periodically, or when you hang up or it stops ringing, to listen for a stutter dial tone ("bee-bee-bee-beeeeeeeep") which your phone company may use as an audible indication of new voicemails.
""")
            if !phone.isCordless || phone.hasBaseSpeakerphone {
                Picker("Voicemail Quick Dial", selection: $phone.voicemailQuickDial) {
                    Text("None").tag(0)
                    Text("Button").tag(1)
                    Text("Speed Dial 1").tag(2)
                    if phone.baseDisplayType > 0 {
                        Text("Message Menu Item").tag(3)
                        Text("Main Menu Item").tag(4)
                        Text("Main Menu Item and Button").tag(5)
                    }
                }
                .onChange(of: phone.voicemailQuickDial) { oldValue, newValue in
                    phone.voicemailQuickDialChanged(oldValue: oldValue, newValue: newValue)
                }
                VoicemailQuickDialInfoView()
            }
            if phone.voicemailQuickDial > 0 {
                Toggle("Can Store Voicemail Feature Codes", isOn: $phone.voicemailFeatureCodes)
                InfoText("Storing voicemail feature codes allows you to, for example, play and delete messages using a button or menu item once you've dialed into voicemail, just like with built-in answering systems. Example: If your voicemail system's main menu asks you to press 1 to play messages, you can store \"1\" to the Play code and then quickly dial it using a button/menu item.")
            }
        }
    }
}

#Preview {
    Form {
        PhoneMessagingView(phone: Phone(brand: "Panasonic", model: "KX-TCM422"))
    }
    .formStyle(.grouped)
}
