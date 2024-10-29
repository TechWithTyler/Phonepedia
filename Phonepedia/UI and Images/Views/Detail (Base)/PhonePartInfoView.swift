//
//  PhonePartInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftData
import SwiftUI
import SheftAppsStylishUI

struct PhonePartInfoView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Integers

    var handsetCount: Int {
        return phone.cordlessHandsetsIHave.count
    }

    var chargerCount: Int {
        return phone.chargersIHave.count
    }

    // MARK: - Body

    var body: some View {
        Section("Cordless Handsets/Headsets/Speakerphones/Desksets (\(handsetCount))") {
            if !phone.cordlessHandsetsIHave.isEmpty {
                ForEach(phone.cordlessHandsetsIHave) { handset in
                    let handsetNumber = (phone.cordlessHandsetsIHave.firstIndex(of: handset) ?? 0) + 1
                    NavigationLink {
                        HandsetInfoDetailView(handset: handset, handsetNumber: handsetNumber)
                            .navigationTitle("Handset \(handsetNumber) Details")
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(handset.brand) \(handset.model)")
                                Text(handset.storageOrSetup > 1 ? "In Storage" : "Active")
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("Handset \(handsetNumber)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .contextMenu {
                        Button {
                            duplicateHandset(handset)
                        } label: {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        }
                        Divider()
                        Button(role: .destructive) {
                            dialogManager.showingDeleteHandset = true
                            dialogManager.handsetToDelete = handset
                        } label: {
                            Label("Delete…", systemImage: "trash")
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            dialogManager.showingDeleteHandset = true
                            dialogManager.handsetToDelete = handset
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            } else {
                Text("No cordless devices")
                    .foregroundStyle(.secondary)
            }
            FormTextField("Main Cordless Device Model", text: $phone.mainHandsetModel)
            InfoText("Enter the model number of the main cordless handset or deskset included with the \(phone.brand) \(phone.model) so newly-added cordless devices will default to that model number.\nA cordless phone's main handset/deskset is registered to the base as number 1, and may have some special features, like backing up the time in case of power outage, not available to other devices on the system.")
            Button(action: addHandset) {
                Label("Add", systemImage: "plus")
            }
            .buttonStyle(.borderless)
            .accessibilityIdentifier("AddHandsetButton")
            .disabled(phone.cordlessHandsetsIHave.count >= phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1)
            if phone.cordlessHandsetsIHave.count > phone.maxCordlessHandsets {
                WarningText("You have more cordless devices than the base can handle!")
            }
            Button(role: .destructive) {
                dialogManager.showingDeleteAllHandsets = true
            } label: {
                Label("Delete All…", systemImage: "trash.fill")
#if !os(macOS)
                    .foregroundStyle(.red)
#endif
            }
            .buttonStyle(.borderless)
        }
        .alert("Delete this handset?", isPresented: $dialogManager.showingDeleteHandset, presenting: $dialogManager.handsetToDelete) { handset in
            Button("Delete", role: .destructive) {
                deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue!)!)
                dialogManager.handsetToDelete = nil
                dialogManager.showingDeleteHandset = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.handsetToDelete = nil
                dialogManager.showingDeleteHandset = false
            }
        }
        .alert("Delete all handsets?", isPresented: $dialogManager.showingDeleteAllHandsets) {
            Button("Delete", role: .destructive) {
                phone.cordlessHandsetsIHave.removeAll()
                dialogManager.showingDeleteAllHandsets = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.showingDeleteAllHandsets = false
            }
        }
        Section("Cordless Handset/Headset/Speakerphone Chargers (\(chargerCount))") {
            if !phone.chargersIHave.isEmpty {
                ForEach(phone.chargersIHave) { charger in
                    let chargerNumber = (phone.chargersIHave.firstIndex(of: charger) ?? 0) + 1
                    NavigationLink {
                        ChargerInfoDetailView(charger: charger, chargerNumber: chargerNumber)
                            .navigationTitle("Charger \(chargerNumber) Details")
                    } label: {
                        Text("Charger \(chargerNumber)")
                    }
                    .contextMenu {
                        Button {
                            duplicateCharger(charger)
                        } label: {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        }
                        Divider()
                        Button(role: .destructive) {
                            dialogManager.showingDeleteCharger = true
                            dialogManager.chargerToDelete = charger
                        } label: {
                            Label("Delete…", systemImage: "trash")
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            dialogManager.showingDeleteCharger = true
                            dialogManager.chargerToDelete = charger
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            } else {
                Text("No chargers")
                    .foregroundStyle(.secondary)
            }
            Button(action: addCharger) {
                Label("Add", systemImage: "plus")
            }
            .buttonStyle(.borderless)
            .accessibilityIdentifier("AddChargerButton")
            Button(role: .destructive) {
                dialogManager.showingDeleteAllChargers = true
            } label: {
                Label("Delete All…", systemImage: "trash.fill")
#if !os(macOS)
                    .foregroundStyle(.red)
#endif
            }
            .buttonStyle(.borderless)
        }
        .alert("Delete this charger?", isPresented: $dialogManager.showingDeleteCharger, presenting: $dialogManager.chargerToDelete) { charger in
            Button("Delete", role: .destructive) {
                deleteCharger(at: phone.chargersIHave.firstIndex(of: charger.wrappedValue!)!)
                dialogManager.chargerToDelete = nil
                dialogManager.showingDeleteCharger = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.chargerToDelete = nil
                dialogManager.showingDeleteCharger = false
            }
        }
        .alert("Delete all chargers?", isPresented: $dialogManager.showingDeleteAllChargers) {
            Button("Delete", role: .destructive) {
                phone.chargersIHave.removeAll()
                dialogManager.showingDeleteAllChargers = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.showingDeleteAllChargers = false
            }
        }
    }

    // MARK: - Data Management

    func addHandset() {
        // 1. Create a new CordlessHandset object. Newly-added handsets default to the phone's brand, the phone's main handset model number, and the phone base's colors.
        let newHandset = CordlessHandset(brand: phone.brand, model: phone.mainHandsetModel, mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue)
        // 2. Add the handset to the phone's list of handsets.
        phone.cordlessHandsetsIHave.append(newHandset)
    }

    func duplicateHandset(_ handset: CordlessHandset) {
        // 1. Create a duplicate of handset.
        let newHandset = handset.duplicate()
        // 2. Insert the duplicate handset after the original. Handsets that come after handset in the array will be shifted up by 1 to allow the duplicate handset to slot in.
        if let index = phone.cordlessHandsetsIHave.firstIndex(of: handset) {
            let newHandsetIndex = index + 1
            phone.cordlessHandsetsIHave.insert(newHandset, at: newHandsetIndex)
        }
    }

    func addCharger() {
        phone.chargersIHave.append(CordlessHandsetCharger())
    }

    func deleteHandset(at index: Int) {
        phone.cordlessHandsetsIHave.remove(at: index)
    }

    func deleteCharger(at index: Int) {
        phone.chargersIHave.remove(at: index)
    }

    func duplicateCharger(_ charger: CordlessHandsetCharger) {
        // 1. Create a duplicate of charger.
        let newCharger = charger.duplicate()
        // 2. Insert the duplicate charger after the original. Chargers that come after charger in the array will be shifted up by 1 to allow the duplicate charger to slot in.
        if let index = phone.chargersIHave.firstIndex(of: charger) {
            phone.chargersIHave.insert(newCharger, at: index + 1)
        }
    }

}

#Preview {
    Form {
        PhonePartInfoView(phone: Phone(brand: "Panasonic", model: "KX-TGD892"))
    }
    .formStyle(.grouped)
    .environmentObject(DialogManager())
}
