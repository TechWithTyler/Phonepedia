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

    // MARK: - Properties - Strings

    // The current setting for the type phone filter.
    @State var phoneFilterType: String = allItemsFilterOptionTag

    // The title of the option which filters the phone list to show only cordless phones.
    var cordlessPhoneTypeString: String = "Cordless (Incl. Corded/Cordless) Phones"

    // The title of the option which filters the phone list to show only Wi-Fi handsets.
    var wiFiHandsetTypeString: String = Phone.PhoneType.wiFiHandset.rawValue.lowercased()

    // The title of the option which filters the phone list to show only cellular handsets.
    var cellularHandsetTypeString: String = Phone.PhoneType.cellularHandset.rawValue.lowercased()

    // The current setting of the brand phone filter.
    @State var phoneFilterBrand: String = allItemsFilterOptionTag

    // Brands of phones.
    var allBrands: [String] {
        // 1. Create a set to hold the brands. A Set is similar to an Array but can only hold one instance of an item. For example, the word "cat" can only appear once in a String Set.
        var brands: Set<String> = []
        // 2. Loop through each phone in the phones array and insert its brand into the set.
        for phone in phones {
            brands.insert(phone.brand)
        }
        // 3. Return the brands set as a sorted array.
        return brands.sorted(by: <)
    }

    // MARK: - Properties - Integers

    // The default selection to use for a new phone's "Analog Line Connected To" option.
    @AppStorage(UserDefaults.KeyNames.defaultAnalogPhoneConnectedToSelection) var defaultAnalogPhoneConnectedToSelection: Int = 2

    // The default selection to use for a new phone's "How I Got This" option.
    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 2

    // The current setting for the active status phone filter.
    @State var phoneFilterActive: Int = 0

    // The current setting for the answering system phone filter.
    @State var phoneFilterAnsweringSystem: Int = 0

    // The current setting for the cordless device number phone filter.
    @State var phoneFilterNumberCordlessDevices: Int = 0

    // MARK: - Properties - Booleans

    // Whether one or more phone filters are enabled.
    var phoneFilterEnabled: Bool {
        return phoneFilterType != allItemsFilterOptionTag || phoneFilterActive != 0 || phoneFilterBrand != allItemsFilterOptionTag || phoneFilterNumberCordlessDevices != 0 || phoneFilterAnsweringSystem != 0
    }

    // Whether the selected type phone filter isn't a cordless phone.
    var phoneFilterTypeNotCordless: Bool {
        return phoneFilterType != cordlessPhoneTypeString && phoneFilterType != allItemsFilterOptionTag
    }

    // Whether the selected type phone filter isn't a Wi-Fi or cellular handset.
    var phoneFilterTypeNotStandaloneWirelessHandsets: Bool {
        return phoneFilterType != wiFiHandsetTypeString && phoneFilterType != cellularHandsetTypeString
    }

    // MARK: - Properties - Phones

    var phones: [Phone]

    // All cordless and corded/cordless phones.
    var cordlessPhones: [Phone] {
        return phones.filter { $0.isCordless || $0.isCordedCordless }
    }

    // All corded phones.
    var cordedPhones: [Phone] {
        return phones.filter { $0.numberOfIncludedCordlessHandsets == 0 && $0.basePhoneType == 0 }
    }

    // All Wi-Fi handsets.
    var wiFiHandsets: [Phone] {
        return phones.filter { $0.basePhoneType == 1 }
    }

    // All cellular handsets.
    var cellularHandsets: [Phone] {
        return phones.filter { $0.basePhoneType == 2 }
    }

    // All phones filtered by type.
    var typeFilteredPhones: [Phone] {
        switch phoneFilterType {
        case Phone.PhoneType.cordless.rawValue.lowercased(): return cordlessPhones
        case Phone.PhoneType.corded.rawValue.lowercased(): return cordedPhones
        case wiFiHandsetTypeString: return wiFiHandsets
        case cellularHandsetTypeString: return cellularHandsets
        default: return phones
        }
    }

    // All phones filtered by type, then active status.
    var activeFilteredPhones: [Phone] {
        switch phoneFilterActive {
        case 1: return typeFilteredPhones.filter { $0.storageOrSetup <= 1 }
        case 2: return typeFilteredPhones.filter { $0.storageOrSetup > 1 }
        default: return typeFilteredPhones
        }
    }

    // All phones filtered by type, active status, then brand.
    var brandFilteredPhones: [Phone] {
        switch phoneFilterBrand {
        case allItemsFilterOptionTag: return activeFilteredPhones
        default: return activeFilteredPhones.filter { $0.brand == phoneFilterBrand }
        }
    }

    // All phones filtered by type, active status, brand, then number of included cordless devices.
    var cordlessDeviceNumberFilteredPhones: [Phone] {
        if phoneFilterNumberCordlessDevices == 0 || phoneFilterTypeNotCordless {
            return brandFilteredPhones
        } else {
            return brandFilteredPhones.filter({$0.numberOfIncludedCordlessHandsets == phoneFilterNumberCordlessDevices})
        }
    }

    // All phones filtered by type, active status, brand, number of included cordless devices, then whether they have answering systems.
    var answeringSystemFilteredPhones: [Phone] {
        guard phoneFilterTypeNotStandaloneWirelessHandsets else {
            return cordlessDeviceNumberFilteredPhones
        }
        switch phoneFilterAnsweringSystem {
        case 1: return cordlessDeviceNumberFilteredPhones.filter { $0.hasAnsweringSystem > 0 }
        case 2: return cordlessDeviceNumberFilteredPhones.filter { $0.hasAnsweringSystem == 0 }
        default: return cordlessDeviceNumberFilteredPhones
        }
    }

    // All phones matching the selected filters.
    var filteredPhones: [Phone] {
        return answeringSystemFilteredPhones
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
                .onChange(of: phones) { oldValue, newValue in
                    achievementTrackerViewModel.evaluate(phones: newValue, initialLoad: oldValue.isEmpty)
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
            if !newValue.contains(phoneFilterBrand) && phoneFilterBrand != allItemsFilterOptionTag {
                phoneFilterBrand = allItemsFilterOptionTag
            }
        })
        .alert("Delete this phone?", isPresented: $dialogManager.showingDeletePhone, presenting: dialogManager.phoneToDelete) { phoneToDelete in
            Button(role: .destructive) {
                dialogManager.showingDeletePhone = false
                deletePhone(phoneToDelete)
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                dialogManager.showingDeletePhone = false
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
                dialogManager.showingDeleteAllPhones = false
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
                dialogManager.showingUpdateCordlessDevicePlaceInCollection = false
                phone.updateAllCordlessDevicePlaceInCollection()
                dialogManager.phoneToUpdateCordlessDevicePlaceInCollection = nil
            } label: {
                Text("Update")
            }
            Button(role: .cancel) {
                dialogManager.showingUpdateCordlessDevicePlaceInCollection = false
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
                achievementTrackerViewModel.showingAlert = false
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
            Picker("Phone Type (\(phoneFilterType == allItemsFilterOptionTag ? "Off" : "On"))", selection: $phoneFilterType) {
                Text("All").tag(allItemsFilterOptionTag)
                Divider()
                Text(cordlessPhoneTypeString).tag(Phone.PhoneType.cordless.rawValue.lowercased())
                Text("Corded Phones").tag(Phone.PhoneType.corded.rawValue.lowercased())
                Text("Wi-Fi Handsets").tag(Phone.PhoneType.wiFiHandset.rawValue.lowercased())
                Text("Cellular Handsets").tag(Phone.PhoneType.cellularHandset.rawValue.lowercased())
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            Picker("Active Status (\(phoneFilterActive == 0 ? "Off" : "On"))", selection: $phoneFilterActive) {
                Text("Off").tag(0)
                Divider()
                Text("Active").tag(1)
                Text("Inactive").tag(2)
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            Picker("Brand (\(phoneFilterBrand == allItemsFilterOptionTag ? "Off" : "On"))", selection: $phoneFilterBrand) {
                Text("All").tag(allItemsFilterOptionTag)
                Divider()
                ForEach(allBrands.sorted(by: <), id: \.self) { brand in
                    Text(brand).tag(brand)
                }
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            if phoneFilterType == allItemsFilterOptionTag || phoneFilterType == Phone.PhoneType.cordless.rawValue.lowercased() {
                Picker("No. of Incl. Cordless Devices (\(phoneFilterNumberCordlessDevices == 0 ? "Off" : "On"))", selection: $phoneFilterNumberCordlessDevices) {
                    Text("Any").tag(0)
                    Divider()
                    ForEach(1..<31) { number in
                        Text("\(number) \(number == 1 ? "Cordless Device" : "Cordless Devices")").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .toggleStyle(.automatic)
            }
            if phoneFilterTypeNotStandaloneWirelessHandsets {
                Picker("Answering Systems (\(phoneFilterAnsweringSystem == 0 ? "Off" : "On"))", selection: $phoneFilterAnsweringSystem) {
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
        phoneFilterType = allItemsFilterOptionTag
        phoneFilterBrand = allItemsFilterOptionTag
        phoneFilterActive = 0
        phoneFilterNumberCordlessDevices = 0
        phoneFilterAnsweringSystem = 0
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
            if phoneFilterActive == 2 {
                newPhone.storageOrSetup = 2
            }
            switch phoneFilterType {
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
                switch phoneFilterNumberCordlessDevices {
                case 0: newPhone.numberOfIncludedCordlessHandsets = 2
                default: newPhone.numberOfIncludedCordlessHandsets = phoneFilterNumberCordlessDevices
                    newPhone.handsetNumberDigitIndex = nil
                    newPhone.handsetNumberDigit = nil
                    if newPhone.numberOfIncludedCordlessHandsets > defaultMaxCordlessDevices {
                        newPhone.maxCordlessHandsets = phoneFilterNumberCordlessDevices
                    }
                }
            }
            if phoneFilterBrand != allItemsFilterOptionTag {
                newPhone.brand = phoneFilterBrand
            }
            if phoneFilterAnsweringSystem == 1 && phoneFilterTypeNotStandaloneWirelessHandsets {
                newPhone.hasAnsweringSystem = newPhone.isCordless ? 3 : 1
            } else if phoneFilterAnsweringSystem == 2 {
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

