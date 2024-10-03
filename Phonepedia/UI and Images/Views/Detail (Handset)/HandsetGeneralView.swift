//
//  HandsetGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetGeneralView: View {

    @Bindable var handset: CordlessHandset

    var body: some View {
        if let phone = handset.phone {
            FormTextField("Brand", text: $handset.brand)
            FormTextField("Model", text: $handset.model)
            Stepper("Release Year (-1 if unknown): \(String(handset.releaseYear))", value: $handset.releaseYear, in: -1...currentYear)
                .onChange(of: handset.releaseYear) { oldValue, newValue in
                    handset.releaseYearChanged(oldValue: oldValue, newValue: newValue)
                }
            Stepper("Acquisition/Purchase Year (-1 if unknown): \(String(handset.acquisitionYear))", value: $handset.acquisitionYear, in: -1...currentYear)
                .onChange(of: handset.acquisitionYear) { oldValue, newValue in
                    handset.acquisitionYearChanged(oldValue: oldValue, newValue: newValue)
                }
            if handset.acquisitionYear == handset.releaseYear {
                HStack {
                    Image(systemName: "sparkle")
                    Text("You got the \(String(handset.releaseYear)) \(handset.brand) \(handset.model) the year it was released!")
                        .font(.callout)
                }
            }
            Picker("How I Got This Handset", selection: $handset.whereAcquired) {
                Text("Included With Base/Set").tag(0)
                Divider()
                Text("Thrift Store/Sale").tag(1)
                Text("Electronics Store (new)").tag(2)
                Text("Online (used)").tag(3)
                Text("Online (new)").tag(4)
                Text("Gift").tag(5)
            }
            ColorPicker("Main Color", selection: handset.mainColorBinding)
            ColorPicker("Secondary/Accent Color", selection: handset.secondaryColorBinding)
            Button("Use Main Color") {
                handset.setSecondaryColorToMain()
            }
            Stepper("Maximum Number Of Bases: \(handset.maxBases)", value: $handset.maxBases, in: 1...4)
            InfoText("Registering a cordless device to more than one base allows you to extend the coverage area and access the answering system, shared lists, etc. of multiple bases without having to register the device to one of those bases at a time.\nIf you want extended range but the same lines/shared lists/base features, and/or you don't want calls to disconnect when the device decides to communicate with a different base, use range extenders instead of multiple bases.")
            Picker("Cordless Device Type", selection: $handset.cordlessDeviceType) {
                Text("Handset").tag(0)
                Text("Deskset").tag(1)
                Text("Headset/Speakerphone").tag(2)
            }
            .onChange(of: handset.cordlessDeviceType) { oldValue, newValue in
                handset.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("A deskset is a phone that connects wirelessly to a main base and is treated like a handset. Desksets can have a corded receiver or a charging area for a cordless handset.\nA cordless headset/speakerphone can pick up the line and answer/join calls, but can't dial or use other features.")
            if handset.cordlessDeviceType < 2 {
                Picker("Antenna", selection: $handset.antenna) {
                    Text("Hidden").tag(0)
                    if handset.cordlessDeviceType == 0 {
                        Text("Style (short)").tag(1)
                    }
                    Text("Transmission (long)").tag(2)
                    Text("Transmission (telescopic)").tag(3)
                }
                AntennaInfoView()
            }
            if handset.cordlessDeviceType == 0 && !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.hasRegistration {
                Toggle("Fits On Base", isOn: $handset.fitsOnBase)
                if !handset.fitsOnBase {
                    InfoText("A handset which doesn't fit on the base misses out on many features including place-on-base power backup and place-on-base auto-register.")
                }
            }
            if handset.cordlessDeviceType == 1 {
                ColorPicker("Corded Receiver Main Color", selection: handset.cordedReceiverMainColorBinding)
                ColorPicker("Corded Receiver Secondary/Accent Color", selection: handset.cordedReceiverSecondaryColorBinding)
                Button("Use Main Color") {
                    handset.setCordedReceiverSecondaryColorToMain()
                }
            }
            Picker("Visual Ringer", selection: $handset.visualRinger) {
                Text("None").tag(0)
                Text("Ignore Ring Signal").tag(1)
                Text("Follow Ring Signal").tag(2)
            }
            InfoText("A visual ringer that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. A visual ringer that ignores the ring signal starts flashing when the ring signal starts and continues flashing for as long as the cordless device is indicating an incoming call.")
            if handset.cordlessDeviceType == 1 {
                Toggle("Supports Backup Batteries", isOn: $handset.desksetSupportsBackupBatteries)
            }
            if handset.cordlessDeviceType == 0 || (handset.cordlessDeviceType == 1 && handset.desksetSupportsBackupBatteries) {
                Picker(handset.cordlessDeviceType == 0 ? "Battery Type" : "Backup Battery Type", selection: $handset.batteryType) {
                    Text("Pack with Plug").tag(0)
                    Text("Pack with Contacts").tag(1)
                    Text("Standard Rechargeable").tag(2)
                }
                BatteryInfoView()
            }
            if handset.cordlessDeviceType == 0 {
                Picker("Audible Low Battery Alert", selection: $handset.audibleLowBatteryAlert) {
                    Text("In-Call Beep").tag(0)
                    Text("Hangup Beep").tag(1)
                    Text("Standby Beep").tag(2)
                    Text("Hangup Beep/Voice").tag(3)
                    Text("Standby/Hangup Voice").tag(4)
                }
                InfoText("The handset can audibly alert you when the battery is low or needs to be charged.")
            }
            Picker("Place In My Collection", selection: $handset.storageOrSetup) {
                PhoneInCollectionStatusPickerItems()
            }
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetGeneralView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGUA40", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 200, secondaryColorGreen: 200, secondaryColorBlue: 200))
    }
    .formStyle(.grouped)
}
