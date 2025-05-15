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
            Picker("Has Answering System", selection: $phone.hasAnsweringSystem) {
                Text("No").tag(0)
                if phone.isCordless {
                    Text("Yes (Base Only)").tag(1)
                    Text("Yes (Handset Only)").tag(2)
                    Text("Yes (Base or Handset)").tag(3)
                } else {
                    Text("Yes").tag(1)
                }
            }
            .onChange(of: phone.hasAnsweringSystem) { oldValue, newValue in
                phone.hasAnsweringSystemChanged(oldValue: oldValue, newValue: newValue)
            }
            if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
                Picker("Answering System Type", selection: $phone.answeringSystemType) {
                    Text("Digital").tag(1)
                    Text("Tape Cassette(s)").tag(0)
                }
                InfoText("Early answering systems stored messages on a tape cassette. The greeting is stored either on the same cassette as the messages (single-cassette systems), on a separate cassette (dual-cassette systems), or digitally. Storing the greeting on the same cassette as the messages results in a delay between the greeting and the beep, as the system needs to move the tape forward to the end where the message is to be recorded. Some models can count the number of messages on the tape by detecting the beeps on the tape.\nModern answering systems are fully digital, meaning messages are stored on a memory chip. This allows for quicker operation.")
                if phone.numberOfLandlines > 1 {
                    Picker("Multi-Line Button Layout", selection: $phone.answeringSystemMultilineButtonLayout) {
                        Text("Separate Buttons").tag(0)
                        Text("Line Selection Button").tag(1)
                    }
                InfoText("Multi-line phones either have separate play and answer on/off buttons for each line, or one play and answer on/off button as well as a button which selects the line(s) those buttons will use.")
                }
            }
            if phone.hasAnsweringSystem > 0 && phone.baseBluetoothCellPhonesSupported > 0 && phone.answeringSystemType == 1 {
                Toggle("Answering System For Cell Lines", isOn: $phone.answeringSystemForCellLines)
                InfoText("On some Bluetooth cell phone-linking phones with answering system, the answering system can answer calls on the cell line.")
            }
            if phone.hasAnsweringSystem == 1 {
                Picker("Answering System Menu", selection: $phone.answeringSystemMenuOnBase) {
                    Text("Voice Prompts").tag(0)
                    if phone.baseDisplayType > 0 {
                        Text("Display Menu").tag(1)
                    }
                }
                AnsweringSystemMenuInfoView()
            } else if phone.isCordless && phone.hasAnsweringSystem == 3 {
                Picker("Answering System Menu (Base)", selection: $phone.answeringSystemMenuOnBase) {
                    Text("None").tag(0)
                    Text("Voice Prompts").tag(1)
                    if phone.baseDisplayType > 2 {
                        Text("Display Menu").tag(2)
                    }
                }
                AnsweringSystemMenuInfoView()
            }
            if phone.hasAnsweringSystem == 1 || phone.hasAnsweringSystem == 3 {
                Toggle("Switches For Basic Answering System Settings", isOn: $phone.answeringSystemSwitches)
            }
            if phone.hasAnsweringSystem == 3 {
                Picker("Greeting Management From", selection: $phone.greetingRecordingOnBaseOrHandset) {
                    Text("Base Only").tag(0)
                    Text("Handset Only").tag(1)
                    Text("Base or Handset").tag(2)
                }
            }
            if phone.hasAnsweringSystem > 0 {
            let exampleName = NameNumberExamples.names.randomElement()!
            InfoText("The greeting, sometimes called the announcement or outgoing message (OGM), is the message the answering system plays to callers when it answers, before optionally allowing the caller to leave a message.\nExample: \"Hello. You have reached \(exampleName). I'm not available to take your call, so please \(AnsweringSystemGreetingComponents.leaveOrRecord()) \(AnsweringSystemGreetingComponents.aOrYour()) message after the \(AnsweringSystemGreetingComponents.beepOrTone()).\"")
            ExampleAudioView(audioFile: .answeringSystemGreetingRecordMessage)
                Toggle("Has Greeting Slots/Scheduled Greetings", isOn: $phone.greetingSlotsAndSchedules)
                InfoText("Greeting slots allow you to record multiple greetings and switch between them manually or on a schedule. For example, in a business setting, you can record a \"we're open\" greeting to play when the business is open, and a \"we're closed\" greeting to play when the business is closed.")
                Toggle("Has Greeting Only Mode", isOn: $phone.hasGreetingOnlyMode)
                InfoText("Greeting Only, sometimes called Announce Only or Answer Only, answers calls but doesn't accept incoming messages. Some phones allow you to record a separate greeting for both modes, allowing you to easily switch between modes without having to re-record your greeting each time. If the phone has greeting slots, greeting only is one of those slots rather than a dedicated mode.\nExample: \"Hello. You have reached \(exampleName). I'm not available to take your call, so please call again later.\"")
                ExampleAudioView(audioFile: .answeringSystemGreetingAnswerOnly)
                if phone.baseDisplayType > 3 {
                    Toggle("Has Message List", isOn: $phone.hasMessageList)
                    MessageListInfoView()
                }
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
                        Text("5").tag(5)
                    }
                }
                InfoText("On single-line phones, mailboxes allow you to organize messages for different people or purposes. In your greeting, instruct callers to choose the desired mailbox. Example: \"For Jack, press 1, or just stay on the line. For Jill, press 2. For Jim, press 3.\"\nSome phones/answering systems designate one mailbox as the primary/general mailbox. When determining how many mailboxes your phone has, count the primary mailbox as one of those mailboxes in addition to mailbox 1, 2, etc.\nOn multi-line phones, each line has its own answering system, which can be independently turned on/off. Incoming messages will be stored in the answering system corresponding to the line receiving the call. On some phones, you can only remotely access the answering system of the line you're calling, while on others, you can access any line remotely no matter which line you're calling.")
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
                InfoText("Call recording allows you to record both sides of a phone call as an answering system message. In some areas, it's illegal to record calls without the other party's consent.\n• Without Notification: The caller isn't notified when call recording starts. It is your responsibility to tell the caller that you're recording the call.\n• Intermittent beeps: Both you and the caller hear a beep every 15 seconds or so, indicating call recording is in progress. It is your responsibility to tell the caller that you're recording the call.\n• Spoken Notification: A spoken notification is played to you and the caller (e.g., \"This call is being recorded.\") before recording starts. This takes care of the legal requirement to tell the caller that you're recording the call.")
            }
        }
        Section("Voicemail") {
            if phone.landlineConnectionType == 0 {
                Picker("\"New Voicemail\" Detection Method", selection: $phone.voicemailIndication) {
                    Text("None").tag(0)
                    Divider()
                    Text("1 - Frequency-Shift-Keying (FSK) Tones").tag(1)
                    Text("2 - Listen For Stutter Dial Tones").tag(2)
                    Text("3 - High Voltage (NEON)").tag(4)
                    Text("4 - Polarity Reversal").tag(5)
                    Divider()
                    Text("1 and 2").tag(3)
                    if phone.baseDisplayType > 0 {
                        Text("1 and 3").tag(6)
                    }
                    Text("Selectable").tag(7)
                }
                InfoText("""
A phone's voicemail indicator works in one of the following ways:
• 1: Your phone provider may send FSK tones to the phone whenever a new voicemail is left and when all new voicemails are played, to tell the phone to turn on or off its voicemail indicator.
• 2: The phone may go off-hook for a few seconds periodically, or when you hang up or it stops ringing, to listen for a stutter dial tone ("bee-bee-bee-beeeeeeeep") which your phone provider may use as an audible indication of new voicemails.
• 3: A high voltage signal on the line turns on and off repeatedly, or stays on, as long as you have new voicemails. This voltage causes the phone's message waiting light (usually the same as the visual ringer) to turn on or flash. If you use a device to listen in on the phone line without going off-hook, this signal sounds like purring or hissing. This is often used in conjunction with a constantly-pulsing dial tone.
• 4: The phone can use line polarity reversal to indicate new voicemails. This method is the least reliable as the provider and phone aren't guaranteed to be in sync (e.g. if the phone wasn't connected to the line when the expected indicator state changed).
• 1 and 2: The phone can go off-hook to listen for a stutter dial tone, or respond to FSK tones. This allows the voicemail indicator to work when one of the 2 methods is unreliable (e.g. stutter dial tone detection only happens after going on-hook or the phone stops ringing, or the FSK tone isn't sent for some reason). The phone may have an option to disable stutter dial tone detection, which is useful if your provider only sends FSK tones.
• 1 and 3: The phone can use FSK tones for a display indicator and NEON for a light.
• Selectable: The phone can be set to use any of the above methods. This selectability is often present on hotel phones, since they're designed to be compatible with a wide range of hotel PBX systems which may not offer the same selectability.
""")
                if phone.voicemailIndication >= 2 {
                    ExampleAudioView(audioFile: .stutterDialTone)
                }
            }
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
