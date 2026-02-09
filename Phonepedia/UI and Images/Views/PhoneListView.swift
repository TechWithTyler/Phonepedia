//
//  PhoneListView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/21/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SwiftData
import SheftAppsStylishUI

struct PhoneListView: View {

    // MARK: - Properties - Objects

    // The model context.
    @Environment(\.modelContext) private var modelContext

    @EnvironmentObject var dialogManager: DialogManager

    @EnvironmentObject var achievementTrackerViewModel: PhoneCollectionAchievementTrackerViewModel

    // MARK: - Properties - Integers

    // The default selection to use for a new phone's "Analog Line Connected To" option.
    @AppStorage(UserDefaults.KeyNames.defaultAnalogPhoneConnectedToSelection) var defaultAnalogPhoneConnectedToSelection: Int = 2

    // The default selection to use for a new phone's "How I Got This" option.
    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 2

    // MARK: - Properties - Filter

    // The current filter settings for the phone list.
    @State var filterCriteria = PhoneFilterEngine.Criteria()

    // Whether one or more phone filters are enabled.
    var phoneFilterEnabled: Bool {
        filterCriteria.isEnabled
    }

    // MARK: - Properties - Phones

    var phones: [Phone]

    // All phones matching the selected filters.
    var filteredPhones: [Phone] {
        PhoneFilterEngine.filter(phones, with: filterCriteria)
    }

    // Brands of phones.
    var allBrands: [String] {
        PhoneFilterEngine.allBrands(from: phones)
    }

    @Binding var selectedPhone: Phone?

    // MARK: - Body

    var body: some View {
        ZStack {
            if !filteredPhones.isEmpty {
                List(selection: $selectedPhone) {
                    ForEach(filteredPhones) { phone in
                        phoneRow(for: phone)
                    }
                    .onDelete(perform: deletePhones)
                    .onMove(perform: movePhones)
                }
                .onAppear {
                    achievementTrackerViewModel.evaluate(phones: phones, initialLoad: true)
                }
                .onChange(of: phones) { oldValue, newValue in
                    achievementTrackerViewModel.evaluate(phones: newValue)
                }
                .accessibilityIdentifier("PhonesList")
            } else if phoneFilterEnabled {
                VStack {
                    Text("No phones matching the selected filters")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    Text("Adjust your filters or add a new phone.")
                        .font(.callout)
                        .foregroundStyle(.tertiary)
                }
            } else {
                Text("No phones")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            installDefaultsForNewData()
        }
        .contextMenu {
            PhoneListDetailOptions(menu: true)
                .toggleStyle(.automatic)
        }
        .onChange(of: filteredPhones, { oldValue, newValue in
            if let phone = selectedPhone, !newValue.contains(phone) {
                selectedPhone = nil
            }
        })
        .onChange(of: allBrands, { oldValue, newValue in
            if !newValue.contains(filterCriteria.brand) && filterCriteria.brand != allItemsFilterOptionTag {
                filterCriteria.brand = allItemsFilterOptionTag
            }
        })
        .alert("Delete this phone?", isPresented: $dialogManager.showingDeletePhone, presenting: dialogManager.phoneToDelete) { phoneToDelete in
            Button(role: .destructive) {
                deletePhone(phoneToDelete)
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                dialogManager.phoneToDelete = nil
            } label: {
                Text("Cancel")
            }
        } message: { phone in
            Text("This \(phone.brand) \(phone.model) will be deleted from this catalog.")
        }
        .sheet(isPresented: $dialogManager.showingPhoneCount) {
            PhoneCountView(phones: phones)
        }
        .sheet(isPresented: $dialogManager.showingPhoneCollectionAchievements) {
            PhoneCollectionAchievementsView(phones: phones)
        }
        .alert("Delete all phones from this catalog?", isPresented: $dialogManager.showingDeleteAllPhones) {
            Button(role: .destructive) {
                deleteAllPhones()
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                dialogManager.showingDeleteAllPhones = false
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("All phones will be deleted from this catalog.")
        }
        .alert("Rearranging the phone list isn't possible while one or more filters are enabled.", isPresented: $dialogManager.showingMoveFailed) {
            Button("OK") {
                dialogManager.showingMoveFailed = false
            }
        } message: {
            Text("Please disable all filters and try again.")
        }
        .alert("Update the place in the collection for all cordless devices as well?", isPresented: $dialogManager.showingUpdateCordlessDevicePlaceInCollection, presenting: dialogManager.phoneToUpdateCordlessDevicePlaceInCollection) { phone in
            Button {
                updateAllCordlessDevicePlaceInCollection(phone: phone)
            } label: {
                Text("Update")
            }
            Button(role: .cancel) {
                dialogManager.phoneToUpdateCordlessDevicePlaceInCollection = nil
            } label: {
                Text("Cancel")
            }
        }
        .alert(achievementTrackerViewModel.alertTitle, isPresented: $achievementTrackerViewModel.showingAlert) {
            Button("OK") {
                achievementTrackerViewModel.showingAlert = false
            }
            Button("Show All…") {
                dialogManager.showingPhoneCollectionAchievements = true
            }
        }
        .toolbar {
            toolbarContent
        }
    }

    @ViewBuilder
    func phoneRow(for phone: Phone) -> some View {
        NavigationLink(value: phone) {
            PhoneRowView(phone: phone)
        }
        .contextMenu {
            PhonePlaceInCollectionPicker(phone: phone)
                .pickerStyle(.menu)
                .toggleStyle(.automatic)
            Divider()
            Button(role: .destructive) {
                dialogManager.phoneToDelete = phone
                dialogManager.showingDeletePhone = true
            } label: {
                Label("Delete…", systemImage: "trash")
            }
        }
        // Track changes to the phone to determine whether to show an achievement alert.
        .onChange(of: phone.acquisitionYear, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.releaseYear, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.isCordless, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.callBlockPreScreening, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.cordlessPowerBackupMode, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.baseBluetoothCellPhonesSupported, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.cordlessHandsetsIHave, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.whereAcquired, { oldValue, newValue in
            achievementTrackerViewModel.evaluate(phones: phones)
        })
        .onChange(of: phone.storageOrSetup, { oldValue, newValue in
            dialogManager.showingUpdateCordlessDevicePlaceInCollection = true
            dialogManager.phoneToUpdateCordlessDevicePlaceInCollection = phone
        })
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem {
            Button(action: addPhone) {
                Label("Add Phone", systemImage: "plus")
            }
            .accessibilityIdentifier("AddPhoneButton")
        }
#if os(macOS)
        ToolbarItem {
            filterToolbarItem
        }
#else
        ToolbarItem(placement: .bottomBar) {
            filterToolbarItem
        }
#endif
        ToolbarItem {
            OptionsMenu(title: .menu) {
                PhoneTypeDefinitionsButton()
                Divider()
                PhoneCollectionAchievementsButton()
                PhoneCountButton()
                    .badge(phones.count)
                Menu("Phone List Detail") {
                    PhoneListDetailOptions(menu: true)
                }
                .pickerStyle(.menu)
                .toggleStyle(.automatic)
                Divider()
                Button(role: .destructive) {
                    dialogManager.showingDeleteAllPhones = true
                } label: {
                    Label("Delete All…", systemImage: "trash.fill")
                }
#if !os(macOS)
                Divider()
                Button("Settings…", systemImage: "gear") {
                    dialogManager.showingSettings = true
                }
#endif
            }
        }
    }

    @ViewBuilder
    var filterToolbarItem: some View {
        Menu("Filter", systemImage: phoneFilterEnabled ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle") {
            Picker("Phone Type (\(filterCriteria.type == allItemsFilterOptionTag ? "Off" : "On"))", selection: $filterCriteria.type) {
                Text("All").tag(allItemsFilterOptionTag)
                Divider()
                Text("Cordless (Incl. Corded/Cordless) Phones").tag(Phone.PhoneType.cordless.rawValue.lowercased())
                Text("Corded Phones").tag(Phone.PhoneType.corded.rawValue.lowercased())
                Text("Wi-Fi Handsets").tag(Phone.PhoneType.wiFiHandset.rawValue.lowercased())
                Text("Cellular Handsets").tag(Phone.PhoneType.cellularHandset.rawValue.lowercased())
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            Picker("Active Status (\(filterCriteria.activeStatus == 0 ? "Off" : "On"))", selection: $filterCriteria.activeStatus) {
                Text("Off").tag(0)
                Divider()
                Text("Active").tag(1)
                Text("Inactive").tag(2)
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            Picker("Brand (\(filterCriteria.brand == allItemsFilterOptionTag ? "Off" : "On"))", selection: $filterCriteria.brand) {
                Text("All").tag(allItemsFilterOptionTag)
                Divider()
                ForEach(allBrands, id: \.self) { brand in
                    Text(brand).tag(brand)
                }
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            if filterCriteria.type == allItemsFilterOptionTag || filterCriteria.type == Phone.PhoneType.cordless.rawValue.lowercased() {
                Picker("No. of Incl. Cordless Devices (\(filterCriteria.numberOfCordlessDevices == 0 ? "Off" : "On"))", selection: $filterCriteria.numberOfCordlessDevices) {
                    Text("Any").tag(0)
                    Divider()
                    ForEach(1..<31) { number in
                        Text("\(number) \(number == 1 ? "Cordless Device" : "Cordless Devices")").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .toggleStyle(.automatic)
            }
            if filterCriteria.typeIsNotStandaloneWireless {
                Picker("Answering Systems (\(filterCriteria.answeringSystem == 0 ? "Off" : "On"))", selection: $filterCriteria.answeringSystem) {
                    Text("Off").tag(0)
                    Divider()
                    Text("With Answering System").tag(1)
                    Text("Without Answering System").tag(2)
                }
                .pickerStyle(.menu)
                .toggleStyle(.automatic)
            }
            Divider()
            Button("Reset", systemImage: "arrow.clockwise") {
                resetPhoneFilter()
            }
        }
    }

    // MARK: - Reset Phone Filter

    // This method resets the phone filter.
    func resetPhoneFilter() {
        filterCriteria = PhoneFilterEngine.Criteria()
    }

    // MARK: - Data Management

    // This method creates a new Phone object, sets a few defaults, and inserts it into the model context.
    private func addPhone() {
        withAnimation {
            // 1. Create a new Phone object with a mock brand and model number.
            let newPhone = Phone.mockPhone
            // 2. Set the default selections.
            newPhone.landlineConnectedTo = defaultAnalogPhoneConnectedToSelection
            newPhone.whereAcquired = defaultAcquisitionMethod
            newPhone.frequency = Phone.CordlessFrequency.defaultForCurrentRegion.rawValue
            // A phone's phoneNumberInCollection property is the index of the phone in the list, and as with any index, it starts at 0. The number of phones in the list before the new phone is added can be used as the phone's index without adding/subtracting 1.
            newPhone.phoneNumberInCollection = phones.count
            // 3. Set defaults based on filters.
            if filterCriteria.activeStatus == 2 {
                newPhone.storageOrSetup = 2
            }
            switch filterCriteria.type {
            case Phone.PhoneType.corded.rawValue.lowercased():
                newPhone.handsetNumberDigitIndex = nil
                newPhone.handsetNumberDigit = nil
                newPhone.numberOfIncludedCordlessHandsets = 0
                newPhone.cordedReceiverMainColorBinding.wrappedValue = .black
            case Phone.PhoneType.wiFiHandset.rawValue.lowercased():
                newPhone.handsetNumberDigitIndex = nil
                newPhone.handsetNumberDigit = nil
                newPhone.numberOfIncludedCordlessHandsets = 0
                newPhone.basePhoneType = 1
            case Phone.PhoneType.cellularHandset.rawValue.lowercased():
                newPhone.handsetNumberDigitIndex = nil
                newPhone.handsetNumberDigit = nil
                newPhone.numberOfIncludedCordlessHandsets = 0
                newPhone.basePhoneType = 2
            default:
                switch filterCriteria.numberOfCordlessDevices {
                case 0: newPhone.numberOfIncludedCordlessHandsets = 2
                default: newPhone.numberOfIncludedCordlessHandsets = filterCriteria.numberOfCordlessDevices
                    newPhone.handsetNumberDigitIndex = nil
                    newPhone.handsetNumberDigit = nil
                    if newPhone.numberOfIncludedCordlessHandsets > defaultMaxCordlessDevices {
                        newPhone.maxCordlessHandsets = filterCriteria.numberOfCordlessDevices
                    }
                }
            }
            if filterCriteria.brand != allItemsFilterOptionTag {
                newPhone.brand = filterCriteria.brand
            }
            if filterCriteria.answeringSystem == 1 && filterCriteria.typeIsNotStandaloneWireless {
                newPhone.hasAnsweringSystem = newPhone.isCordless ? 3 : 1
            } else if filterCriteria.answeringSystem == 2 {
                newPhone.hasAnsweringSystem = 0
            }
            // 4. Insert the new phone into the model context.
            modelContext.insert(newPhone)
            // 5. Select the new phone.
            selectedPhone = newPhone
        }
    }

    // This method moves the phone being dragged from the current (source) index set to the new (destination) index by creating a copy of the phones array, performing the move on that copy, then setting the phoneNumberInCollection property of the original's phones.
    private func movePhones(source: IndexSet, destination: Int) {
        // 1. If the phone filter is enabled, show an alert and don't continue.
        guard !phoneFilterEnabled else {
            dialogManager.showingMoveFailed = true
            return
        }
        withAnimation {
            // 2. Create a copy of the phones array pre-move.
            var phonesCopy = phones
            // 3. Perform the move operation on the copy.
            phonesCopy.move(fromOffsets: source, toOffset: destination)
            // 4. Use the copy's items and their indices to move the phones in the original array.
            for (index, phone) in phonesCopy.reversed().enumerated() {
                if let originalPhone = phones.filter({ $0.id == phone.id}).first {
                    originalPhone.phoneNumberInCollection = index
                }
            }
        }
    }

    // This method updates the storageOrSetup property of all of phone's cordless devices.
    func updateAllCordlessDevicePlaceInCollection(phone: Phone) {
        phone.updateAllCordlessDevicePlaceInCollection()
        dialogManager.phoneToUpdateCordlessDevicePlaceInCollection = nil
    }

    // This method deletes the phone at the given index set.
    private func deletePhones(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        withAnimation {
            dialogManager.phoneToDelete = phones[index]
            dialogManager.showingDeletePhone = true
        }
    }

    // This method deletes phone from the model context. A temporary snapshot of the phone to be deleted is created to assist with correcting the phoneNumberInCollection property of phones placed above the deleted one.
    func deletePhone(_ phone: Phone) {
        // 1. Create a temporary snapshot of the index of the phone to be deleted so phones after the deleted one can be shifted down after deletion.
        let deletedIndex = phone.phoneNumberInCollection
        // 2. Delete the phone.
        dialogManager.phoneToDelete = nil
        phone.cordlessHandsetsIHave.removeAll()
        phone.chargersIHave.removeAll()
        modelContext.delete(phone)
        // 3. Clear the phone selection.
        selectedPhone = nil
        // 4. For any phone whose index is higher than the one that was just deleted, decrease phoneNumberInCollection by 1.
        phones.forEach {
            if $0.phoneNumberInCollection > deletedIndex {
                $0.phoneNumberInCollection -= 1
            }
        }
    }

    // This method deletes all phones from the model context.
    func deleteAllPhones() {
        // 1. Clear the phone selection.
        selectedPhone = nil
        resetPhoneFilter()
        // 2. Delete each phone.
        for phone in phones {
            phone.cordlessHandsetsIHave.removeAll()
            phone.chargersIHave.removeAll()
            modelContext.delete(phone)
        }
    }

    // This method installs the default values for any new data added in app updates. For example, phone numbering was introduced in version 2025.5.
    func installDefaultsForNewData() {
        // For updates from version 2024.11, set the numbers of each phone/cordless device/charger to the corresponding index. This is done by checking to see if the phoneNumberInCollection property of all phones is 0 (auto-set default for updates from version 2024.11).
        let allPhonesFirstInCollection = phones.allSatisfy({ $0.phoneNumberInCollection == 0 })
        if allPhonesFirstInCollection {
            for phone in phones {
                phone.phoneNumberInCollection = phones.firstIndex(of: phone)!
                for handset in phone.cordlessHandsetsIHave {
                    handset.handsetNumber = phone.cordlessHandsetsIHave.firstIndex(of: handset)!
                }
                for charger in phone.chargersIHave {
                    charger.chargerNumber = phone.chargersIHave.firstIndex(of: charger)!
                }
            }
        }
    }

}

// MARK: - Preview

#Preview {
    @State @Previewable var selectedPhone: Phone?
    @Previewable @Query var phones: [Phone] = []
    NavigationStack {
        PhoneListView(phones: phones, selectedPhone: $selectedPhone)
    }
    .environmentObject(DialogManager())
    .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
    .padding()
    .frame(minWidth: 400, minHeight: 400)
}

