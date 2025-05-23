//
//  LandlineDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct LandlineDetailView: View {

    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        Picker("Connection Type", selection: $phone.landlineConnectionType) {
            Text("Analog").tag(0)
            Divider()
            Text("Digital").tag(1)
            Divider()
            Text("VoIP (Ethernet)").tag(2)
            Text("VoIP (Wi-Fi)").tag(3)
            Divider()
            Text("Built-In Cellular").tag(4)
            Divider()
            Text("Analog and VoIP").tag(5)
        }
        .onChange(of: phone.landlineConnectionType) { oldValue, newValue in
            phone.landlineConnectionTypeChanged(oldValue: oldValue, newValue: newValue)
        }
        if (phone.landlineConnectionType == 0 || phone.landlineConnectionType == 5) && phone.storageOrSetup <= 1 {
            Picker("Analog Line Connected To", selection: $phone.landlineConnectedTo) {
                AnalogPhoneConnectedToPickerItems()
            }
        }
        InfoText("Select \"Multiple\" if you alternate between connection types (e.g. a phone line simulator for internal test calls and a VoIP modem for real calls) or each analog line on a multi-line phone is connected to a different one. You can use a phone line switcher for this.")
        InfoButton(title: "About Connection Types/Devices…") {
            dialogManager.showingAboutConnectionTypes = true
        }
        if phone.landlineConnectionType < 2 {
            Toggle("Has Hard-Wired Line Cord", isOn: $phone.hasHardWiredLineCord)
            InfoText("Some old phones have hard-wired line cords, which means you'll need to have the phone repaired if the cord breaks.")
        }
        if phone.landlineConnectionType < 2 {
            Picker("Number Of Lines", selection: $phone.numberOfLandlines) {
                Text("Single-Line").tag(1)
                Text("2-Line").tag(2)
                Text("4-Line").tag(4)
            }
            .onChange(of: phone.numberOfLandlines) { oldValue, newValue in
                phone.numberOfLandlinesChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("On a 2- or 4-line phone, you can either plug each line into a separate jack, or use a single jack for 2 lines. For example, to plug a 2-line phone into a single 2-line jack, you would plug into the line 1/2 jack, or to plug into 2 single-line jacks, you would plug into both the line 1 and line 2 jacks. To use the one-jack-for-both-lines method, you need to make sure the phone cord has 4 copper contacts instead of just 2. With some phones, the included line cords are color-coded so you can easily tell which line they're for (e.g. black for line 1 and green for line 2). At least one of the included line cords will have 4 copper contacts--use this one for the one-jack-for-both-lines method.\nMulti-line phones have buttons/soft keys to choose the desired line. Some phones have the ability to select the primary line, which will be used when picking up the phone/going off-hook. This option usually defaults to auto, which means the first line that's not in use (free line) will be selected.")
        } else {
            FormNumericTextField("Number Of Lines", value: $phone.numberOfLandlines, valueRange: .oneToMax(100), singularSuffix: "line", pluralSuffix: "lines")
            InfoText("Business-grade VoIP phones often have support for more than 4 lines. Lines can be registered as extensions on the same VoIP system, or as separate lines on different VoIP systems.\nOn Ethernet VoIP phones, the number of lines DOES NOT determine how many line jacks the phone has. A single Ethernet cable connects the phone to the network, and the phone's software determines how many lines it can support.")
        }
        if phone.landlineConnectionType == 0 || phone.landlineConnectionType == 5 {
            Picker(phone.landlineConnectionType == 5 ? "Analog Line Dial Mode" : "Dial Mode", selection: $phone.dialMode) {
                if phone.landlineConnectionType == 0 {
                    Text("Pulse Only").tag(0)
                }
                Text("Tone Only").tag(1)
                if phone.landlineConnectionType == 0 {
                    Text("Tone or Pulse (Setting)").tag(2)
                    Text("Tone or Pulse (Switch)").tag(3)
                } else {
                    Text("Tone or Pulse").tag(2)
                }
            }
            InfoText("Cordless, push-button corded, and some rotary phones, can use either tone dialing or pulse dialing, or offer the ability to choose based on what your phone service requires. Most phone services today only support tone dialing.\nFor phones which have the option to select tone or pulse dialing, the star key, a dedicated tone button, or setting the dial mode switch to tone, is used to temporarily switch to tone dialing during a call in pulse dial mode. This allows you to use automated systems requiring keypad entry when your phone service only supports pulse dialing for the initial dialing of the call. You can play DTMF tones into the phone's microphone if you're using a pulse-only phone.\nTip: An easy way to check which dial mode(s) your phone service supports is to pick up the phone, dial a number, and see if the dial tone cuts off. If the dial tone continues, your phone service doesn't support the phone's dial mode, or is configured to not support both. Change any available settings on the phone and provider device and try again.")
            ExampleAudioView(audioFile: .dtmfTones)
            ExampleAudioView(audioFile: .pulseDialing)
        }
        if phone.isCordless || phone.cordedPhoneType == 0 {
            Picker("Landline In Use Status On Base", selection: $phone.landlineInUseStatusOnBase) {
                Text("None").tag(0)
                Text("Light").tag(1)
                if phone.baseDisplayType > 1 {
                    Text("Display").tag(2)
                    Text("Display and Light").tag(3)
                }
            }
            if phone.landlineInUseStatusOnBase == 1 || phone.landlineInUseStatusOnBase == 3 {
                Toggle("Landline In Use Light Follows Ring Signal", isOn: $phone.landlineInUseVisualRingerFollowsRingSignal)
                InfoText("An in use light that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. An in use light that ignores the ring signal flashes for as long as the \(phone.isCordless ? "base" : "phone") is indicating an incoming call.")
            }
        }
        Toggle("Has \"No Line\" Alert", isOn: $phone.hasNoLineAlert)
        InfoText("When another phone on the same line is in use, the phone will indicate that the line is in use if it has line in use indication, by detecting a drop in line power. If it drops too much (the line isn't connected or too many phones are in use), the no line alert, if available, will be displayed.\nDetecting drops in line power is also what causes automated systems, phones on hold, and some speakerphones to hang up when another phone on the line is picked up.\nThe phone will first detect \"line in use\" before detecting \"no line\", so you may briefly see it indicating \"line in use\" after disconnecting the line (or powering up the phone without a line connected). The status won't change the moment the line power drops, as the phone needs to wait for the line power to stabilize before indicating the proper status.")
    }
}

#Preview {
    Form {
        LandlineDetailView(phone: Phone(brand: "Motorola", model: "L402C"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
