//
//  HandsetGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetGeneralView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Properties - Strings

    var mainColorLocation: String {
        switch handset.cordlessDeviceType {
        case 1: return "Top"
        default: return "Front"
        }
    }

    var secondaryColorLocation: String {
        switch handset.cordlessDeviceType {
        case 1: return "Bottom"
        default: return "Back"
        }
    }

    var body: some View {
        if let phone = handset.phone {
            Stepper("Release Year (-1 If Unknown): \(String(handset.releaseYear))", value: $handset.releaseYear, in: -1...currentYear)
                .onChange(of: handset.releaseYear) { oldValue, newValue in
                    handset.releaseYearChanged(oldValue: oldValue, newValue: newValue)
                }
            Stepper("Acquisition/Purchase Year (-1 If Unknown): \(String(handset.acquisitionYear))", value: $handset.acquisitionYear, in: -1...currentYear)
                .onChange(of: handset.acquisitionYear) { oldValue, newValue in
                    handset.acquisitionYearChanged(oldValue: oldValue, newValue: newValue)
                }
            if handset.acquisitionYear == handset.releaseYear && handset.acquisitionYear != -1 && handset.releaseYear != -1 {
                HStack {
                    Image(systemName: "sparkle")
                    Text("You got the \(String(handset.releaseYear)) \(handset.brand) \(handset.model) the year it was released!")
                        .font(.callout)
                }
            }
            Picker("How I Got This Cordless Device", selection: $handset.whereAcquired) {
                AcquisitionMethodPickerItems(handset: true)
            }
            Picker("Place In My Collection", selection: $handset.storageOrSetup) {
                PhoneInCollectionStatusPickerItems()
            }
            ColorPicker("\(mainColorLocation) Color", selection: handset.mainColorBinding, supportsOpacity: false)
            ColorPicker("\(secondaryColorLocation) Color", selection: handset.secondaryColorBinding, supportsOpacity: false)
            Button("Use \(mainColorLocation) Color") {
                handset.setSecondaryColorToMain()
            }
            ColorPicker("Accent Color", selection: handset.accentColorBinding, supportsOpacity: false)
            Button("Use \(mainColorLocation) Color") {
                handset.setAccentColorToMain()
            }
            Button("Use \(secondaryColorLocation) Color") {
                handset.setAccentColorToSecondary()
            }
            Stepper("Maximum Number Of Bases: \(handset.maxBases)", value: $handset.maxBases, in: .oneToMax(4))
            InfoText("Registering a cordless device to more than one base allows you to extend the coverage area and access the answering system, shared lists, etc. of multiple bases without having to register the device to one of those bases at a time.\nIf you want extended range but the same lines/shared lists/base features, and/or you don't want calls to disconnect when the device decides to communicate with a different base, use range extenders instead of multiple bases.")
            Picker("Cordless Device Type", selection: $handset.cordlessDeviceType) {
                Text(CordlessHandset.CordlessDeviceType.handset.rawValue).tag(0)
                Text(CordlessHandset.CordlessDeviceType.deskset.rawValue).tag(1)
                Text(CordlessHandset.CordlessDeviceType.headset.rawValue).tag(2)
            }
            .onChange(of: handset.cordlessDeviceType) { oldValue, newValue in
                handset.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("A deskset is a phone that connects wirelessly to a main base and is treated like a handset. Desksets can have a corded receiver or a charging area for a cordless handset.\nA cordless headset/speakerphone can pick up the line and answer/join calls, but can't dial or use other features.")
            if handset.cordlessDeviceType == 0 {
                Picker("Handset Style", selection: $handset.handsetStyle) {
                    Text("Traditional").tag(0)
                    Text("Futuristic").tag(1)
                    Text("Cell Phone").tag(2)
                    Text("Smartphone").tag(3)
                }
                .onChange(of: handset.handsetStyle) { oldValue, newValue in
                    handset.handsetStyleChanged(oldValue: oldValue, newValue: newValue)
                }
                InfoText("Futuristic handset designs include design elements like curves and a seamless look when placed on the base or charger. For example, a base might resemble part of a ring, with a curved handset completing the ring when placed on the base.\nCell phone-style handsets flip or slide open like traditional cell phones.\nSmartphone-style handsets run a smartphone operating system and can run smartphone apps. Software and hardware is mostly identical to a smartphone, plus a cordless handset antenna and a specialized app for cordless phone features like base settings and answering system access. Some smartphone-style handsets can function as both a cordless handset and a smartphone.")
            }
            if handset.cordlessDeviceType < 2 {
                Picker("Antenna", selection: $handset.antenna) {
                    Text("Hidden").tag(0)
                    if handset.cordlessDeviceType == 0 {
                        Text("Style (Short)").tag(1)
                    }
                    Text("Transmission (Long)").tag(2)
                    Text("Transmission (Telescopic)").tag(3)
                }
                AntennaInfoView()
            }
            if handset.cordlessDeviceType == 0 && !phone.isCordedCordless && !phone.hasTransmitOnlyBase && phone.hasRegistration {
                Toggle("Fits On Base", isOn: $handset.fitsOnBase)
                if !handset.fitsOnBase {
                    InfoText("For a handset to \"fit on the base\", the charging contacts of the handset and base must be able to touch each other without having to force the handset into the base.\nA handset which doesn't fit on the base misses out on many features including place-on-base power backup and place-on-base auto-register.")
                }
            }
            if handset.cordlessDeviceType == 1 {
                ClearSupportedColorPicker("Corded Receiver Outer Color", selection: handset.cordedReceiverMainColorBinding) {
                    Text("No Corded Receiver")
                }
                if handset.hasCordedReceiver {
                    ColorPicker("Corded Receiver Inner Color", selection: handset.cordedReceiverSecondaryColorBinding, supportsOpacity: false)
                    Button("Use Outer Color") {
                        handset.setCordedReceiverSecondaryColorToMain()
                    }
                    ColorPicker("Corded Receiver Accent Color", selection: handset.cordedReceiverAccentColorBinding, supportsOpacity: false)
                    Button("Use Outer Color") {
                        handset.setCordedReceiverAccentColorToMain()
                    }
                    Button("Use Inner Color") {
                        handset.setCordedReceiverAccentColorToSecondary()
                    }

                }
                HStack {
                    Text("Deskset Type")
                    Spacer()
                    Text(handset.hasCordedReceiver ? "Corded Phone" : "Speakerphone")
                }
            }
            Picker("Visual Ringer", selection: $handset.visualRinger) {
                Text("None").tag(0)
                Text("Ignore Ring Signal").tag(1)
                Text("Follow Ring Signal").tag(2)
            }
            InfoText("A visual ringer that follows the ring signal starts flashing when the ring signal starts and stops flashing when the ring signal stops. A visual ringer that ignores the ring signal flashes for as long as the cordless device is indicating an incoming call.")
        } else {
            Text("Error")
        }
    }
}

#Preview {
    Form {
        HandsetGeneralView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGUA40", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 200, secondaryColorGreen: 200, secondaryColorBlue: 200, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
    }
    .formStyle(.grouped)
}
