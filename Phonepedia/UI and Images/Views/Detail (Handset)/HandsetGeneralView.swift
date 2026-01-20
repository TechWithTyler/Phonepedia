//
//  HandsetGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI
import SheftAppsInternals

struct HandsetGeneralView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
            Section("Basic Info") {
                basicsGroup
            }
            if handset.cordlessDeviceType < 2 {
                Section(handset.cordlessDeviceTypeText) {
                    if handset.cordlessDeviceType == 0 {
                        handsetGroup
                    } else if handset.cordlessDeviceType == 1 {
                        desksetGroup
                    }
                    if handset.isHandsetOrCordedDeskset {
                        Picker(handset.hasCordedReceiver ? "Corded Receiver Earpiece Type" : "Earpiece Type", selection: $handset.earpieceType) {
                            Text("Standard").tag(0)
                            Text("Bone Conduction").tag(1)
                        }
                        BoneConductionEarpieceInfoView()
                    }
                }
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }

    @ViewBuilder
    var basicsGroup: some View {
        if let phone = handset.phone {
            Stepper("Release Year (-1 If Unknown): \(String(handset.releaseYear))", value: $handset.releaseYear, in: -1...currentYear)
                .onChange(of: handset.releaseYear) { oldValue, newValue in
                    handset.releaseYearChanged(oldValue: oldValue, newValue: newValue)
                }
            Stepper("Acquisition/Purchase Year (-1 If Unknown): \(String(handset.acquisitionYear))", value: $handset.acquisitionYear, in: -1...currentYear)
                .onChange(of: handset.acquisitionYear) { oldValue, newValue in
                    handset.acquisitionYearChanged(oldValue: oldValue, newValue: newValue)
                }
            Button("Set to Release Year") {
                phone.setAcquisitionYearToReleaseYear()
            }
            if handset.acquiredInYearOfRelease {
                HStack {
                    Image(systemName: "sparkle")
                    Text("You got the \(String(handset.releaseYear)) \(handset.brand) \(handset.model) the year it was released!")
                        .font(.callout)
                }
            }
            Picker("How I Got This Cordless Device", selection: $handset.whereAcquired) {
                AcquisitionMethodPickerItems(handset: true)
            }
            HandsetPlaceInCollectionPicker(handset: handset)
            if phone.isDigitalCordless {
                Stepper("Maximum Number of Bases: \(handset.maxBases)", value: $handset.maxBases, in: .oneToMax(4))
                InfoText("Registering a cordless device to more than one base allows you to extend the coverage area and access the answering system, shared lists, etc. of multiple bases without having to register the device to one of those bases at a time. You can select a specific base for the handset to always connect to, or have it automatically choose the base with the strongest signal. In \(SAAppName), the base of the phone this cordless device is assigned to is considered its primary base.\nIf you want extended range but the same lines/shared lists/base features, and/or you don't want calls to disconnect when the device decides to communicate with a different base, use range extenders instead of multiple bases.\nTo use intercom, room monitor, and other multi-handset features, you must select the same base on both handsets or make sure they're connecting to the same base in auto mode.\nFor multi-cell systems, \"base\" here refers to all the bases in a system.")
            }
            Picker("Cordless Device Type", selection: $handset.cordlessDeviceType) {
                Text(CordlessHandset.CordlessDeviceType.handset.rawValue).tag(0)
                Text(CordlessHandset.CordlessDeviceType.deskset.rawValue).tag(1)
                Text(CordlessHandset.CordlessDeviceType.headset.rawValue).tag(2)
            }
            .onChange(of: handset.cordlessDeviceType) { oldValue, newValue in
                handset.cordlessDeviceTypeChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("A deskset is a phone that connects wirelessly to a main base and is treated like a handset. Desksets can have a corded receiver or a charging area for a cordless handset.\nA cordless headset/speakerphone can pick up the line and answer/join calls, but can't dial or use other features. If a cordless phone comes only with cordless headsets, it's often called a headset phone.")
            if handset.cordlessDeviceType < 2 && handset.handsetStyle < 3 {
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
            Picker("Visual Ringer", selection: $handset.visualRinger) {
                Text("None").tag(0)
                Text("Ignore Ring Signal").tag(1)
                Text("Follow Ring Signal").tag(2)
            }
            VisualRingerInfoView()
            if phone.baseBluetoothCellPhonesSupported > 0 {
                Picker("Standby Cell Call Dialing", selection: $handset.standbyCellCallDialing) {
                    Text("Dial Number").tag(0)
                    Text("Redial List").tag(1)
                }
                InfoText("When pressing the cell button in standby (and selecting the cell phone if necessary):\n• Dial Number: You can dial the number just as if you picked up the landline.\n• Redial List: The handset's redial list is displayed, matching the behavior on many traditional cell phones.")
                Picker("Cell Line Selection", selection: $handset.cellLineSelection) {
                    CellLineSelectionPickerItems()
                }
                CellLineSelectionInfoView()
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }

    @ViewBuilder
    var handsetGroup: some View {
        if let phone = handset.phone {
            Picker("Handset Style", selection: $handset.handsetStyle) {
                Text("Traditional").tag(0)
                Text("Futuristic").tag(1)
                Text("Cell Phone").tag(2)
                Text("Smartphone").tag(3)
            }
            .onChange(of: handset.handsetStyle) { oldValue, newValue in
                handset.handsetStyleChanged(oldValue: oldValue, newValue: newValue)
            }
            InfoText("Futuristic handsets include design elements like curves and a seamless look when placed on the base or charger. For example, a base might resemble part of a ring, with a curved handset completing the ring when placed on the base.\nCell phone-style handsets flip or slide open like traditional cell phones.\nSmartphone-style handsets run a smartphone operating system and can run smartphone apps. Software and hardware is mostly identical to a smartphone, plus a cordless handset antenna and a specialized app for cordless phone features like base settings and answering system access. Some smartphone-style handsets can function as both a cordless handset and a smartphone.")
            if phone.baseChargesHandset && phone.isDigitalCordless {
                Toggle("Fits On Base", isOn: $handset.fitsOnBase)
                if !handset.fitsOnBase {
                    InfoText("For a handset to \"fit on the base\", the charging contacts of the handset and base must be able to touch each other without having to force the handset into the base.\nA handset which doesn't fit on the base misses out on many features including place-on-base power backup and place-on-base auto-register.")
                }
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }

    @ViewBuilder
    var desksetGroup: some View {
        if let phone = handset.phone {
            HStack {
                Text("Deskset Type")
                Spacer()
                Text(handset.hasCordedReceiver ? "Corded Phone" : "Speakerphone")
            }
            if handset.hasCordedReceiver {
                Toggle("Is Slim Corded Deskset", isOn: $handset.isSlimCordedDeskset)
                Picker("Switch Hook", selection: $handset.switchHookType) {
                    Text(handset.isSlimCordedDeskset ? "Press (On Base)" : "Press").tag(0)
                    Text("Press (On Receiver)").tag(1)
                }
                Text("Magnetic").tag(2)
                Text("Contacts").tag(3)
            }
            Picker("Corded Receiver Hook Type", selection: $handset.cordedReceiverHookType) {
                Text("Fixed").tag(0)
                Text("Flip/Rotate").tag(1)
                Text("Removable").tag(2)
            }
        } else {
            Text(cordlessDeviceMissingPhoneText)
        }
    }

}

// MARK: - Preview

#Preview {
    Form {
        HandsetGeneralView(handset: CordlessHandset(brand: "Panasonic", model: "KX-TGUA40", mainColorRed: 0, mainColorGreen: 0, mainColorBlue: 0, secondaryColorRed: 200, secondaryColorGreen: 200, secondaryColorBlue: 200, accentColorRed: 200, accentColorGreen: 200, accentColorBlue: 200))
    }
    .formStyle(.grouped)
}
