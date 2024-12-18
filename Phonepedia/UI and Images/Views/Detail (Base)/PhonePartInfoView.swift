//
//  PhonePartInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
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

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 0

    var handsetCount: Int {
        return phone.cordlessHandsetsIHave.count
    }

    var chargerCount: Int {
        return phone.chargersIHave.count
    }

    // MARK: - Body

    var body: some View {
        Section("Cordless Devices") {
            if !phone.cordlessHandsetsIHave.isEmpty {
                Text("\(handsetCount) Cordless \(handsetCount == 1 ? "Device" : "Devices")")
                ForEach(phone.cordlessHandsetsIHave) { handset in
                    let handsetNumber = (phone.cordlessHandsetsIHave.firstIndex(of: handset) ?? 0) + 1
                    NavigationLink {
                        HandsetInfoDetailView(handset: handset, handsetNumber: handsetNumber)
                            .navigationTitle("\(handset.brand) \(handset.model) (HS\(handsetNumber))")
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(handset.brand) \(handset.model.isEmpty ? "<No Model Number>" : handset.model)")
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
            InfoText("Enter the model number of the main cordless handset or deskset included with the \(phone.brand) \(phone.model) so newly-added cordless devices will default to that model number.\nA cordless phone's main handset/deskset is registered to the base as number 1, and may have some special features, like backing up the time in case of power outage, not available to other devices on the system.\nSome non-expandable cordless phones won't have a handset model number or it will be the same as that of the set it came with--leave this field blank in this case.")
            Button(action: addHandset) {
                Label("Add", systemImage: "plus")
            }
#if os(macOS)
            .buttonStyle(.borderless)
#endif
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
#if os(macOS)
            .buttonStyle(.borderless)
#endif
        }
        .alert("Delete this cordless device?", isPresented: $dialogManager.showingDeleteHandset, presenting: $dialogManager.handsetToDelete) { handset in
            Button("Delete", role: .destructive) {
                deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue!)!)
                dialogManager.handsetToDelete = nil
                dialogManager.showingDeleteHandset = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.handsetToDelete = nil
                dialogManager.showingDeleteHandset = false
            }
        } message: { handset in
            let wrappedHandset = handset.wrappedValue!
            Text("This \(wrappedHandset.brand) \(wrappedHandset.model.isEmpty ? "cordless device" : wrappedHandset.model) will be deleted from this \(phone.brand) \(phone.model).")
        }
        .alert("Delete all cordless devices?", isPresented: $dialogManager.showingDeleteAllHandsets) {
            Button("Delete", role: .destructive) {
                phone.cordlessHandsetsIHave.removeAll()
                dialogManager.showingDeleteAllHandsets = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.showingDeleteAllHandsets = false
            }
        } message: {
            Text("All cordless devices will be deleted from this \(phone.brand) \(phone.model).")
        }
        Section("Cordless Device Chargers") {
            if !phone.chargersIHave.isEmpty {
                Text("\(chargerCount) \(chargerCount == 1 ? "Charger" : "Chargers")")
                ForEach(phone.chargersIHave) { charger in
                    let chargerNumber = (phone.chargersIHave.firstIndex(of: charger) ?? 0) + 1
                    NavigationLink {
                        ChargerInfoDetailView(charger: charger, chargerNumber: chargerNumber)
                            .navigationTitle("Charger \(chargerNumber)")
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
#if os(macOS)
            .buttonStyle(.borderless)
#endif
            .accessibilityIdentifier("AddChargerButton")
            Button(role: .destructive) {
                dialogManager.showingDeleteAllChargers = true
            } label: {
                Label("Delete All…", systemImage: "trash.fill")
#if !os(macOS)
                    .foregroundStyle(.red)
#endif
            }
#if os(macOS)
            .buttonStyle(.borderless)
#endif
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
        } message: { charger in
            Text("This charger will be deleted from this \(phone.brand) \(phone.model).")
        }
        .alert("Delete all chargers?", isPresented: $dialogManager.showingDeleteAllChargers) {
            Button("Delete", role: .destructive) {
                phone.chargersIHave.removeAll()
                dialogManager.showingDeleteAllChargers = false
            }
            Button("Cancel", role: .cancel) {
                dialogManager.showingDeleteAllChargers = false
            }
        } message: {
            Text("All chargers will be deleted from this \(phone.brand) \(phone.model).")
        }
    }

    // MARK: - Handset Management

    func addHandset() {
        // 1. Create a new CordlessHandset object. Newly-added handsets default to the phone's brand, the phone's main handset model number, and the phone base's colors.
        let newHandset = CordlessHandset(brand: phone.brand, model: phone.mainHandsetModel, mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue)
        // 2. If the handset count is the same as the number of included handsets, set "Where I Got This Cordless Device" to 0 (Included With Base/Set). Otherwise, use the default acquisition method.
        if phone.cordlessHandsetsIHave.count + 1 <= phone.numberOfIncludedCordlessHandsets {
            newHandset.whereAcquired = 0
        } else {
            // For cordless devices, an additional option is available for the "Where I Got This" selection, "Included With Base/Set", with a tag of 0, so we need to add 1 to the default acquisition method.
            newHandset.whereAcquired = defaultAcquisitionMethod + 1
        }
        // 3. Add the handset to the phone's list of handsets.
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

    func deleteHandset(at index: Int) {
        phone.cordlessHandsetsIHave.remove(at: index)
    }

    // MARK: - Charger Management

    func addCharger() {
        phone.chargersIHave.append(CordlessHandsetCharger())
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
