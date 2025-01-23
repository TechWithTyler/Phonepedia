//
//  CordlessDeviceInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftData
import SwiftUI
import SheftAppsStylishUI

struct CordlessDeviceInfoView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Cordless Devices

    var sortedCordlessDevices: [CordlessHandset] {
        return phone.cordlessHandsetsIHave.sorted { $0.handsetNumber < $1.handsetNumber }
    }

    var filteredCordlessDevices: [CordlessHandset] {
        if cordlessDeviceFilter == "all" {
            return sortedCordlessDevices
        } else {
            return sortedCordlessDevices.filter { $0.cordlessDeviceTypeText == cordlessDeviceFilter }
        }
    }

    // MARK: - Properties - Cordless Device Chargers

    var sortedChargers: [CordlessHandsetCharger] {
        return phone.chargersIHave.sorted { $0.chargerNumber < $1.chargerNumber }
    }

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Strings

    @State var cordlessDeviceFilter: String = "all"

    // MARK: - Properties - Integers

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 0

    var handsetCount: Int {
        return filteredCordlessDevices.count
    }

    var chargerCount: Int {
        return phone.chargersIHave.count
    }

    // MARK: - Body

    var body: some View {
        Section("Cordless Devices") {
            HStack {
                Picker("Filter", selection: $cordlessDeviceFilter) {
                    Text("All Cordless Devices").tag("all")
                    Divider()
                    Text(CordlessHandset.CordlessDeviceType.handset.rawValue + "s").tag(CordlessHandset.CordlessDeviceType.handset.rawValue)
                    Text(CordlessHandset.CordlessDeviceType.deskset.rawValue + "s").tag(CordlessHandset.CordlessDeviceType.deskset.rawValue)
                    Text(CordlessHandset.CordlessDeviceType.headset.rawValue + "s").tag(CordlessHandset.CordlessDeviceType.headset.rawValue)
                }
                .labelsHidden()
                Text("(\(handsetCount))")
            }
                Menu {
                    if !phone.cordlessHandsetsIHave.isEmpty {
                        Button(action: duplicateLastHandset) {
                            Text("Duplicate of Last Cordless Device")
                        }
                    }
                    Button(action: addHandset) {
                        Text("New Cordless Device")
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
                .frame(width: 80, alignment: .leading)
                .menuIndicator(.hidden)
                .accessibilityIdentifier("AddHandsetButton")
                .disabled(phone.cordlessHandsetsIHave.count >= phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1)
                Button(role: .destructive) {
                    dialogManager.showingDeleteAllHandsets = true
                } label: {
                    Label("Delete All…", systemImage: "trash.fill")
    #if !os(macOS)
                        .foregroundStyle(.red)
    #endif
                }
            if !filteredCordlessDevices.isEmpty {
                List {
                    ForEach(filteredCordlessDevices) { handset in
                        NavigationLink {
                            HandsetDetailView(handset: handset)
                                .navigationTitle("Device \(handset.handsetNumber + 1)")
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(handset.brand) \(handset.model.isEmpty ? "<No Model Number>" : handset.model)")
                                    Text(handset.storageOrSetup > 1 ? "In Storage" : "Active")
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Device \(handset.handsetNumber + 1)")
                                    if cordlessDeviceFilter == "all" {
                                        Text(handset.cordlessDeviceTypeText)
                                    }
                                }
                                .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 5)
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
                    .onMove(perform: moveHandsets)
                }
                if phone.cordlessHandsetsIHave.count > phone.maxCordlessHandsets {
                    WarningText("You have more cordless devices than the base can handle!")
                }
            }
            FormTextField("Main Cordless Device Model", text: $phone.mainHandsetModel)
            InfoText("Enter the model number of the main cordless handset or deskset included with the \(phone.brand) \(phone.model) so newly-added cordless devices will default to that model number.\nA cordless phone's main handset/deskset is registered to the base as number 1, and may have some special features, like backing up the time in case of power outage, not available to other devices on the system.\nSome non-expandable cordless phones won't have a handset model number or it will be the same as that of the set it came with--leave this field blank in this case.")
        }
        .alert("Delete this cordless device?", isPresented: $dialogManager.showingDeleteHandset, presenting: $dialogManager.handsetToDelete) { handset in
            Button("Delete", role: .destructive) {
                deleteHandset(handset.wrappedValue!)
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
                Text("\(chargerCount) \(chargerCount == 1 ? "Charger" : "Chargers")")
                Menu {
                    if !phone.chargersIHave.isEmpty {
                        Button(action: duplicateLastCharger) {
                            Text("Duplicate of Last Charger")
                        }
                    }
                    Button(action: addCharger) {
                        Text("New Charger")
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
                .frame(width: 80, alignment: .leading)
                .menuIndicator(.hidden)
                .accessibilityIdentifier("AddChargerButton")
                Button(role: .destructive) {
                    dialogManager.showingDeleteAllChargers = true
                } label: {
                    Label("Delete All…", systemImage: "trash.fill")
    #if !os(macOS)
                        .foregroundStyle(.red)
    #endif
                }
            if !phone.chargersIHave.isEmpty {
                List {
                    ForEach(sortedChargers) { charger in
                        NavigationLink {
                            ChargerDetailView(charger: charger, chargerNumber: charger.chargerNumber)
                                .navigationTitle("Charger \(charger.chargerNumber + 1)")
                        } label: {
                            Text("Charger \(charger.chargerNumber + 1)")
                                .padding(.vertical, 5)
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
                    .onMove(perform: moveChargers)
                }
            }
        }
        .alert("Rearranging the cordless device list isn't possible while the cordless device filter is enabled.", isPresented: $dialogManager.showingMoveFailedHandset) {
            Button("OK") {
                dialogManager.showingMoveFailedHandset = false
            }
        }  message: {
            Text("Please disable the cordless device filter and try again.")
        }
        .alert("Delete this charger?", isPresented: $dialogManager.showingDeleteCharger, presenting: $dialogManager.chargerToDelete) { charger in
            Button("Delete", role: .destructive) {
                deleteCharger(charger.wrappedValue!)
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
        let newHandset = CordlessHandset(brand: phone.brand, model: phone.mainHandsetModel, mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue, accentColorRed: phone.baseAccentColorRed, accentColorGreen: phone.baseAccentColorGreen, accentColorBlue: phone.baseAccentColorBlue)
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
        // 1. Create a duplicate of handset and set its number.
        let newHandsetNumber = sortedCordlessDevices.endIndex
        let newHandset = handset.duplicate()
        newHandset.handsetNumber = newHandsetNumber
        // 2. Insert the duplicate handset at the end of the array.
        phone.cordlessHandsetsIHave.append(newHandset)
        // 3. Move the duplicate handset to after the original.
        moveHandsets(source: IndexSet(integer: newHandsetNumber), destination: handset.handsetNumber + 1)
    }

    func duplicateLastHandset() {
        duplicateHandset(sortedCordlessDevices.last!)
    }

    private func moveHandsets(source: IndexSet, destination: Int) {
        // 1. If the cordless device filter is enabled, show an alert and don't continue.
        guard cordlessDeviceFilter == "all" else {
                dialogManager.showingMoveFailedHandset = true
                return
            }
        withAnimation {
            // 2. Create a copy of the sortedCordlessDevices array pre-move.
            var handsetsCopy = sortedCordlessDevices
            // 3. Perform the move operation on the copy.
            handsetsCopy.move(fromOffsets: source, toOffset: destination)
            // 4. Use the copy's items and their indicies to move the cordless devices in the original array.
            for (index, handset) in handsetsCopy.enumerated() {
                if let originalHandset = sortedCordlessDevices.filter({ $0.id == handset.id}).first {
                    originalHandset.handsetNumber = index
                }
            }
        }
    }

    func deleteHandset(_ handset: CordlessHandset) {
        // 1. Create a snapshot of the index of the handset to be deleted so handsets after the deleted one can be shifted down after deletion.
        let deletedIndex = handset.handsetNumber
        // 2. Delete the handset.
        phone.cordlessHandsetsIHave.removeAll { $0.id == handset.id }
        // 3. For any handset whose index is higher than the one that was just deleted, decrease handsetNumber by 1.
        sortedCordlessDevices.forEach {
            if $0.handsetNumber > deletedIndex {
                $0.handsetNumber -= 1
            }
        }
    }

    // MARK: - Charger Management

    func addCharger() {
        phone.chargersIHave.append(CordlessHandsetCharger(mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue, accentColorRed: phone.baseAccentColorRed, accentColorGreen: phone.baseAccentColorGreen, accentColorBlue: phone.baseAccentColorBlue))
    }

    func duplicateCharger(_ charger: CordlessHandsetCharger) {
        // 1. Create a duplicate of charger.
        let newChargerNumber = sortedChargers.endIndex
        let newCharger = charger.duplicate()
        newCharger.chargerNumber = newChargerNumber
        // 2. Insert the duplicate charger at the end of the array.
        phone.chargersIHave.append(newCharger)
        // 3. Move the duplicate charger to after the original.
        moveChargers(source: IndexSet(integer: newChargerNumber), destination: charger.chargerNumber + 1)
    }

    func duplicateLastCharger() {
        duplicateCharger(sortedChargers.last!)
    }

    private func moveChargers(source: IndexSet, destination: Int) {
        withAnimation {
            // 1. Create a copy of the sortedChargers array pre-move.
            var chargersCopy = sortedChargers
            // 2. Perform the move operation on the copy.
            chargersCopy.move(fromOffsets: source, toOffset: destination)
            // 3. Use the copy's items and their indicies to move the cordless devices in the original array.
            for (index, charger) in chargersCopy.enumerated() {
                if let originalCharger = sortedChargers.filter({ $0.id == charger.id}).first {
                    originalCharger.chargerNumber = index
                }
            }
        }
    }

    func deleteCharger(_ charger: CordlessHandsetCharger) {
        // 1. Create a snapshot of the index of the charger to be deleted so chargers after the deleted one can be shifted down after deletion.
        let deletedIndex = charger.chargerNumber
        // 2. Delete the charger.
        phone.chargersIHave.removeAll { $0.id == charger.id }
        // 3. For any charger whose index is higher than the one that was just deleted, decrease chargerNumber by 1.
        sortedChargers.forEach {
            if $0.chargerNumber > deletedIndex {
                $0.chargerNumber -= 1
            }
        }
    }

}

#Preview {
    Form {
        CordlessDeviceInfoView(phone: Phone(brand: "Panasonic", model: "KX-TGD892"))
    }
    .formStyle(.grouped)
    .environmentObject(DialogManager())
}
