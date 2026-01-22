//
//  CordlessDeviceInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftData
import SwiftUI
import SheftAppsStylishUI

struct CordlessDeviceInfoView: View {

    // MARK: - Properties - Phone

    @Bindable var phone: Phone

    // MARK: - Properties - Cordless Devices

    // All cordless devices, sorted by number.
    var sortedCordlessDevices: [CordlessHandset] {
        return phone.cordlessHandsetsIHave.sorted { $0.handsetNumber < $1.handsetNumber }
    }

    // All cordless devices, filtered by type.
    var filteredCordlessDevices: [CordlessHandset] {
        if cordlessDeviceFilter == allItemsFilterOptionTag {
            return sortedCordlessDevices
        } else {
            return sortedCordlessDevices.filter { $0.cordlessDeviceTypeText.lowercased() == cordlessDeviceFilter }
        }
    }

    // MARK: - Properties - Cordless Device Chargers

    // All chargers, sorted by number.
    var sortedChargers: [CordlessHandsetCharger] {
        return phone.chargersIHave.sorted { $0.chargerNumber < $1.chargerNumber }
    }

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Strings

    // The current setting of the cordless device type filter.
    @State var cordlessDeviceFilter: String = allItemsFilterOptionTag

    // MARK: - Properties - Integers

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 0

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.showPhoneColorsInList) var showPhoneColorsInList: Bool = false

    // The number of cordless devices for this phone.
    var handsetCount: Int {
        return filteredCordlessDevices.count
    }

    // The number of chargers for this phone.
    var chargerCount: Int {
        return phone.chargersIHave.count
    }

    // MARK: - Body

    var body: some View {
        if phone.basePhoneType == 0 {
            Section("Cordless Devices") {
                HStack {
                    Picker("Filter", selection: $cordlessDeviceFilter) {
                        Text("All").tag(allItemsFilterOptionTag)
                        Divider()
                        Text(CordlessHandset.CordlessDeviceType.handset.plural).tag(CordlessHandset.CordlessDeviceType.handset.rawValue.lowercased())
                        Text(CordlessHandset.CordlessDeviceType.deskset.plural).tag(CordlessHandset.CordlessDeviceType.deskset.rawValue.lowercased())
                        Text(CordlessHandset.CordlessDeviceType.headset.plural).tag(CordlessHandset.CordlessDeviceType.headset.rawValue.lowercased())
                    }
                    .labelsHidden()
                    Text("(\(handsetCount))")
                }
                Menu {
                    if !phone.cordlessHandsetsIHave.isEmpty && cordlessDeviceFilter == allItemsFilterOptionTag {
                        Button(action: duplicateLastCordlessDevice) {
                            Text("Duplicate of Last Cordless Device")
                        }
                    }
                    Button(action: addCordlessDevice) {
                        Text("New Cordless Device")
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
                .menuIndicator(.hidden)
                .accessibilityIdentifier("AddHandsetButton")
                .disabled(phone.maxOrTooManyCordlessDevices)
                if phone.maxOrTooManyCordlessDevices {
                    WarningText("You currently have the maximum number of cordless devices (\(phone.maxCordlessHandsets)) for this \(phone.brand) \(phone.model). If you're trying to add another cordless device, make sure you've specified the correct number of maximum cordless devices on the General page.")
                }
                Button(role: .destructive) {
                    dialogManager.showingDeleteAllHandsets = true
                } label: {
                    Label("Delete All…", systemImage: "trash.fill")
#if !os(macOS)
                        .foregroundStyle(.red)
#endif
                }
                if !filteredCordlessDevices.isEmpty {
                    cordlessDeviceList
                }
                FormTextField("Main Cordless Device Model", text: $phone.mainHandsetModel)
                InfoText("Enter the model number of the main cordless device included with the \(phone.brand) \(phone.model) so newly-added cordless devices will default to that model number.\nA cordless phone's main handset/deskset is registered to the base as number 1, and may have some special features, like backing up the time in case of power outage, not available to other devices on the system.\nSome non-expandable cordless phones won't have a handset model number or it will be the same as that of the set it came with--leave this field blank in this case.\nCordless devices with model numbers matching the main cordless device model number will appear bolded.")
            }
            .alert("Delete this cordless device?", isPresented: $dialogManager.showingDeleteHandset, presenting: $dialogManager.handsetToDelete) { handset in
                Button("Delete", role: .destructive) {
                    deleteCordlessDevice(handset.wrappedValue!)
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
        }
        Section(phone.basePhoneType > 0 ? "Chargers" : "Cordless Device Chargers") {
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
                chargerList
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

    // MARK: - Cordless Device List

    @ViewBuilder
    var cordlessDeviceList: some View {
        List {
            ForEach(filteredCordlessDevices) { handset in
                NavigationLink {
                    HandsetDetailView(handset: handset)
                        .navigationTitle("Device \(handset.actualHandsetNumber)")
                } label: {
                    HStack {
                        if showPhoneColorsInList {
                            ColorStack(mainColor: handset.mainColorBinding.wrappedValue, secondaryColor: handset.hasSecondaryColor ? handset.secondaryColorBinding.wrappedValue : nil, accentColor: handset.hasAccentColor ? handset.accentColorBinding.wrappedValue : nil)
                                .padding(.horizontal)
                        }
                        VStack(alignment: .leading) {
                            Text("\(handset.brand) \(handset.model.isEmpty ? "<No Model Number>" : handset.model)")
                                .bold(handset.model == phone.mainHandsetModel)
                            Text(handset.storageOrSetup > 1 ? "In Storage" : "Active")
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Device \(handset.actualHandsetNumber)")
                            if cordlessDeviceFilter == allItemsFilterOptionTag {
                                Text(handset.cordlessDeviceTypeText)
                            }
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                .contextMenu {
                    HandsetPlaceInCollectionPicker(handset: handset)
                        .pickerStyle(.menu)
                        .toggleStyle(.automatic)
                    Divider()
                    Button {
                        dialogManager.handsetToReassign = handset
                        dialogManager.showingReassignHandset = true
                    } label: {
                        Label("Reassign…", systemImage: "phone.arrow.right.fill")
                    }
                    Divider()
                    Button {
                        duplicateCordlessDevice(handset)
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
            .onMove(perform: moveCordlessDevices)
        }
        if phone.tooManyCordlessDevices {
            WarningText("You have more cordless devices than the base can handle!")
        }
    }

    // MARK: - Charger List

    @ViewBuilder
    var chargerList: some View {
        List {
            ForEach(sortedChargers) { charger in
                NavigationLink {
                    ChargerDetailView(charger: charger)
                        .navigationTitle("Charger \(charger.actualChargerNumber)")
                } label: {
                    HStack {
                        if showPhoneColorsInList {
                            ColorStack(mainColor: charger.mainColorBinding.wrappedValue, secondaryColor: charger.hasSecondaryColor ? charger.secondaryColorBinding.wrappedValue : nil, accentColor: charger.hasAccentColor ? charger.accentColorBinding.wrappedValue : nil)
                                .padding(.horizontal)
                        }
                        VStack(alignment: .leading) {
                            Text("Charger \(charger.actualChargerNumber)")
                            if phone.basePhoneType == 0 {
                                Text("Cordless \(charger.type == 0 ? "handset" : "headset/speakerphone") charger")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
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

    // MARK: - Cordless Device Management

    // This method creates a new CordlessHandset object, sets a few defaults, and adds it to the phone's cordlessHandsetsIHave array.
    func addCordlessDevice() {
        // 1. Create a new CordlessHandset object. Newly-added cordless devices default to the phone's brand, the phone's main cordless device model number, and the phone base's colors.
        let newCordlessDevice = CordlessHandset(brand: phone.brand, model: phone.mainHandsetModel, mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue, accentColorRed: phone.baseAccentColorRed, accentColorGreen: phone.baseAccentColorGreen, accentColorBlue: phone.baseAccentColorBlue)
        // 2. If the cordless device count is the same as the number of included cordless devices, set "Where I Got This Cordless Device" to 0 (Included With Base/Set). Otherwise, use the default acquisition method.
        if phone.cordlessHandsetsIHaveAfterAddHandset <= phone.numberOfIncludedCordlessHandsets {
            newCordlessDevice.whereAcquired = 0
        } else {
            // For cordless devices, an additional option is available for the "Where I Got This" selection, "Included With Base/Set", with a tag of 0, so we need to add 1 to the default acquisition method.
            newCordlessDevice.whereAcquired = defaultAcquisitionMethod + 1
        }
        // A cordless device's handsetNumber property is the index of the cordless device in the list, and as with any index, it starts at 0. The number of cordless devices in the list before the new one is added can be used as its index without adding/subtracting 1.
        newCordlessDevice.handsetNumber = phone.cordlessHandsetsIHave.count
        // 3. Set the new cordless device's release year to the phone's release year.
        newCordlessDevice.releaseYear = phone.releaseYear
        // 5. Set the cordless device type based on the cordless device type filter.
        switch cordlessDeviceFilter {
        case CordlessHandset.CordlessDeviceType.deskset.rawValue.lowercased():
            newCordlessDevice.cordlessDeviceType = 1
        case CordlessHandset.CordlessDeviceType.headset.rawValue.lowercased():
            newCordlessDevice.cordlessDeviceType = 2
        default:
            newCordlessDevice.cordlessDeviceType = 0
        }
        // 4. Add the cordless device to the phone's list of cordless devices.
        phone.cordlessHandsetsIHave.append(newCordlessDevice)
    }

    // This method creates a copy of cordlessDevice and adds it to the phone's cordlessHandsetsIHave array.
    func duplicateCordlessDevice(_ cordlessDevice: CordlessHandset) {
        // 1. Create a duplicate of handset and set its number.
        let newCordlessDeviceNumber = sortedCordlessDevices.endIndex
        let newCordlessDevice = cordlessDevice.duplicate()
        newCordlessDevice.handsetNumber = newCordlessDeviceNumber
        // 2. Insert the duplicate handset at the end of the array.
        phone.cordlessHandsetsIHave.append(newCordlessDevice)
        // 3. Move the duplicate handset to after the original.
        moveCordlessDevices(source: IndexSet(integer: newCordlessDeviceNumber), destination: cordlessDevice.actualHandsetNumber)
    }

    // This method duplicates the last cordless device in the list.
    func duplicateLastCordlessDevice() {
        guard let lastCordlessDevice = sortedCordlessDevices.last else { return }
        duplicateCordlessDevice(lastCordlessDevice)
    }

    // This method moves the cordless device being dragged from the current (source) index set to the new (destination) index by creating a copy of the phone's cordlessHandsetsIHave array, performing the move on that copy, then setting the handsetNumber property of the original's cordless devices.
    private func moveCordlessDevices(source: IndexSet, destination: Int) {
        // 1. If the cordless device filter is enabled, show an alert and don't continue.
        guard cordlessDeviceFilter == allItemsFilterOptionTag else {
            dialogManager.showingMoveFailedHandset = true
            return
        }
        withAnimation {
            // 2. Create a copy of the sortedCordlessDevices array pre-move.
            var cordlessDevicesCopy = sortedCordlessDevices
            // 3. Perform the move operation on the copy.
            cordlessDevicesCopy.move(fromOffsets: source, toOffset: destination)
            // 4. Use the copy's items and their indices to move the cordless devices in the original Dearray.
            for (index, cordlessDevice) in cordlessDevicesCopy.enumerated() {
                if let originalCordlessDevice = sortedCordlessDevices.filter({ $0.id == cordlessDevice.id}).first {
                    originalCordlessDevice.handsetNumber = index
                }
            }
        }
    }

    // This method deletes cordlessDevice from the phone's cordlessHandsetsIHave array. A temporary snapshot of the cordless device to be deleted is created to assist with correcting the handsetNumber property of cordless devices placed above the deleted one.
    func deleteCordlessDevice(_ cordlessDevice: CordlessHandset) {
        // 1. Create a temporary snapshot of the index of the cordless device to be deleted so cordless devices after the deleted one can be shifted down after deletion.
        let deletedIndex = cordlessDevice.handsetNumber
        // 2. Delete the cordless device.
        phone.cordlessHandsetsIHave.removeAll { $0.id == cordlessDevice.id }
        // 3. For any cordless device whose index is higher than the one that was just deleted, decrease handsetNumber by 1.
        sortedCordlessDevices.forEach {
            if $0.handsetNumber > deletedIndex {
                $0.handsetNumber -= 1
            }
        }
    }

    // MARK: - Charger Management

    // This method creates a new CordlessHandsetCharger object, sets a few defaults, and adds it to the phone's chargersIHave array.
    func addCharger() {
        // 1. Create a new CordlessHandsetCharger object.
        let newCharger = CordlessHandsetCharger(mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue, accentColorRed: phone.baseAccentColorRed, accentColorGreen: phone.baseAccentColorGreen, accentColorBlue: phone.baseAccentColorBlue)
        // A charger's chargerNumber property is the index of the charger in the list, and as with any index, it starts at 0. The number of chargers in the list before the new one is added can be used as its index without adding/subtracting 1.
        newCharger.chargerNumber = phone.chargersIHave.count
        // 3. Add the new charger to the phone's list of chargers.
        phone.chargersIHave.append(newCharger)
    }

    // This method creates a copy of charger and adds it to the phone's chargersIHave array.
    func duplicateCharger(_ charger: CordlessHandsetCharger) {
        // 1. Create a duplicate of charger.
        let newChargerNumber = sortedChargers.endIndex
        let newCharger = charger.duplicate()
        newCharger.chargerNumber = newChargerNumber
        // 2. Insert the duplicate charger at the end of the array.
        phone.chargersIHave.append(newCharger)
        // 3. Move the duplicate charger to after the original.
        moveChargers(source: IndexSet(integer: newChargerNumber), destination: charger.actualChargerNumber)
    }

    // This method duplicates the last charger in the list.
    func duplicateLastCharger() {
        guard let lastCharger = sortedChargers.last else { return }
        duplicateCharger(lastCharger)
    }

    // This method moves the charger being dragged from the current (source) index set to the new (destination) index by creating a copy of the phone's chargersIHave array, performing the move on that copy, then setting the chargerNumber property of the original's chargers.
    private func moveChargers(source: IndexSet, destination: Int) {
        withAnimation {
            // 1. Create a copy of the sortedChargers array pre-move.
            var chargersCopy = sortedChargers
            // 2. Perform the move operation on the copy.
            chargersCopy.move(fromOffsets: source, toOffset: destination)
            // 3. Use the copy's items and their indices to move the chargers in the original array.
            for (index, charger) in chargersCopy.enumerated() {
                if let originalCharger = sortedChargers.filter({ $0.id == charger.id}).first {
                    originalCharger.chargerNumber = index
                }
            }
        }
    }

    // This method deletes charger from the phone's chargersIHave array. A temporary snapshot of the charger to be deleted is created to assist with correcting the chargerNumber property of chargers placed above the deleted one.
    func deleteCharger(_ charger: CordlessHandsetCharger) {
        // 1. Create a temporary snapshot of the index of the charger to be deleted so chargers after the deleted one can be shifted down after deletion.
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

// MARK: - Preview

#Preview {
    Form {
        CordlessDeviceInfoView(phone: Phone(brand: "Panasonic", model: "KX-TGD892"))
    }
    .formStyle(.grouped)
    .environmentObject(DialogManager())
}
