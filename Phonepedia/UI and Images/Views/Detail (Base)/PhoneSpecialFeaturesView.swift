//
//  PhoneSpecialFeaturesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneSpecialFeaturesView: View {

    @Bindable var phone: Phone

    var body: some View {
        Toggle("Plays Out-Of-Service Tone Upon Answering", isOn: $phone.outOfServiceToneOnAnswer)
        InfoText("\"Not in service\" tones, also known as Special Information Tones or SIT tones, are the 3 rising tones you often hear when you call a number that's out of service or that can't be dialed. Some autodialers will remove any numbers that play SIT tones from their lists so they won't call them again. Because of this, some phones/devices were designed to play SIT tones when a phone on the line was answered, making autodialers remove your number from their list. However, most autodialers today no longer use SIT tone detection as they have other means of knowing what numbers are or aren't in service, and today's phones don't include this feature for many reasons including confused callers and desired automated calls having working numbers removed from their lists. SIT tones may also play when calling working numbers if the call can't be completed for another reason, which can also cause autodialers to remove working numbers from their lists. You may still hear these tones if you call an out-of-service number or when calls can't be completed, depending on the provider that serves the area or that formerly served the number, or depending on how your provider handles out-of-service numbers/when calls can't be completed.")
        if phone.baseCallerIDCapacity > 0 || !phone.cordlessHandsetsIHave.filter({$0.callerIDCapacity > 0}).isEmpty {
            Toggle("One-Ring Scam Call Detection", isOn: $phone.scamCallDetection)
            InfoText("If a caller hangs up within 1 or 2 rings and caller ID is received, the phone can mark the call as a one-ring scam call when viewed in the caller ID list, and warn the user when trying to call that caller. One-ring scams often come from international numbers, which cost money to call.")
        }
        if phone.hasIntercom {
            Picker("Room/Baby Monitor", selection: $phone.roomMonitor) {
                Text("Not Supported").tag(0)
                Text("Call From Handset/Base").tag(1)
                Text("Call To Handset/Base").tag(2)
                Text("Sound-Activated Call").tag(3)
            }
            InfoText("Room/baby monitor allows you to listen to the sounds in a room where a handset/base is located.\nCall From: You call the room monitor handset/base.\nCall To: The room monitor handset/base calls you at another handset/base.\nSound-Activated Call: The room monitor handset/base calls you at another handset/base or an outside phone number when sound is detected (e.g., a crying baby or barking dog).")
            if phone.roomMonitor == 3 {
                Picker("External Room Monitor Keypad Entry Handled By", selection: $phone.externalRoomMonitorAutomatedSystem) {
                    Text("Base").tag(0)
                    Text("Handset").tag(1)
                }
                InfoText("When a handset/base detects sound and calls an outside phone number, the person on the outside phone can talk back to the handset/base by dialing a code, or deactivate the feature by dialing another code.")
            }
        }
        Stepper("Smart Home Devices Supported: \(phone.smartHomeDevicesSupported)", value: $phone.smartHomeDevicesSupported, in: 0...50, step: 5)
        InfoText("Smart home devices registered to a cordless phone can notify the handset/base or outside phone when things happen and the handset/base can control these devices. For example, when someone rings a doorbell, the phone can sound a chime and color display handsets can show a live feed of the doorbell's video.")
        Toggle("Answer By Voice", isOn: $phone.answerByVoice)
        InfoText("The base and compatible handsets can detect sound when landline/cell calls come in, allowing calls to be answered by voice. The phone either listens for any sound or is programmed to listen for a specific phrase.")
    }
}

#Preview {
    Form {
        PhoneSpecialFeaturesView(phone: Phone(brand: "Panasonic", model: "KX-TGL432"))
    }
    .formStyle(.grouped)
}
