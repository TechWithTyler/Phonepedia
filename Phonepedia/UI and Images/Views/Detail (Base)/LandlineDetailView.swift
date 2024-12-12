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
            Text("Digital").tag(1)
            Text("VoIP (Ethernet)").tag(2)
            Text("VoIP (Wi-Fi)").tag(3)
            Text("Built-In Cellular").tag(4)
        }
        if phone.landlineConnectionType == 0 && phone.storageOrSetup <= 1 {
            Picker("Connected To", selection: $phone.landlineConnectedTo) {
                AnalogPhoneConnectedToPickerItems()
            }
        }
        InfoButton(title: "About Connection Types/Devices…") {
            dialogManager.showingAboutConnectionTypes = true
        }
        Picker("Number Of Lines", selection: $phone.numberOfLandlines) {
            Text("Single-Line").tag(1)
            Text("2-Line").tag(2)
            Text("4-Line").tag(4)
        }
        .onChange(of: phone.numberOfLandlines) { oldValue, newValue in
            phone.numberOfLandlinesChanged(oldValue: oldValue, newValue: newValue)
        }
        InfoText("On a 2- or 4-line phone, you can either plug each line into a separate jack, or use a single jack for 2 lines. For example, to plug a 2-line phone into a single 2-line jack, you would plug into the line 1/2 jack, or to plug into 2 single-line jacks, you would plug into both the line 1 and line 2 jacks. To use the one-jack-for-both-lines method, you need to make sure the phone cord has 4 copper contacts instead of just 2. With some phones, the included line cords are color-coded so you can easily tell which line they're for (e.g. black for line 1 and green for line 2). At least one of the included line cords will have 4 copper contacts.\nMulti-line phones have buttons/soft keys to choose the desired line. Some phones have the ability to select the primary line, which will be used when picking up the receiver on a corded phone, pressing the talk button on a cordless phone, or pressing the speakerphone button. This option usually defaults to auto, which means the first line that's not in use will be selected.")
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
                InfoText("An in use light that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. An in use light that ignores the ring signal starts flashing when the ring signal starts and continues flashing for as long as the \(phone.isCordless ? "base" : "phone") is indicating an incoming call.")
            }
        }
        Toggle("Has \"No Line\" Alert", isOn: $phone.hasNoLineAlert)
        InfoText("When another phone on the same line is in use, the phone will indicate that the line is in use if it has line in use indication, by detecting a drop in line power. If it drops too much (the line isn't connected or too many phones are in use), the no line alert, if available, will be displayed.\nDetecting drops in line power is also what causes automated systems, phones on hold, and some speakerphones to hang up when another phone on the line is picked up.\nThe phone will first detect \"line in use\" before detecting \"no line\", so you may briefly see it indicating \"line in use\" after disconnecting the line. The status won't change the moment the line power drops, as the phone needs to wait for the line power to stabilize before indicating the proper status.")
    }
}

#Preview {
    Form {
        LandlineDetailView(phone: Phone(brand: "Motorola", model: "L402C"))
            .environmentObject(DialogManager())
    }
    .formStyle(.grouped)
}
