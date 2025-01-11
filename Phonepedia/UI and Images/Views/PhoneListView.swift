//
//  PhoneListView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/21/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData
import SheftAppsStylishUI

struct PhoneListView: View {
    
    // MARK: - Properties - Objects
    
    @Environment(\.modelContext) private var modelContext

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Strings

    @State var phoneFilterType: String = "all"

    @State var phoneFilterBrand: String = "all"

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

    @AppStorage(UserDefaults.KeyNames.defaultAnalogPhoneConnectedToSelection) var defaultAnalogPhoneConnectedToSelection: Int = 2

    @AppStorage(UserDefaults.KeyNames.defaultAcquisitionMethod) var defaultAcquisitionMethod: Int = 2

    @State var phoneFilterActive: Int = 0

    // MARK: - Properties - Booleans

    var phoneFilterEnabled: Bool {
        return phoneFilterType != "all" || phoneFilterActive != 0 || phoneFilterBrand != "all"
    }

    // MARK: - Properties - Phones

    var phones: [Phone]

    var cordlessPhones: [Phone] {
        return phones.filter { $0.isCordless || $0.isCordedCordless }
    }

    var cordedPhones: [Phone] {
        return phones.filter { $0.numberOfIncludedCordlessHandsets == 0 }
    }

    var typeFilteredPhones: [Phone] {
        switch phoneFilterType {
        case Phone.PhoneType.cordless.rawValue.lowercased(): return cordlessPhones
        case Phone.PhoneType.corded.rawValue.lowercased(): return cordedPhones
        default: return phones
        }
    }

    var activeFilteredPhones: [Phone] {
        switch phoneFilterActive {
        case 1: return typeFilteredPhones.filter { $0.storageOrSetup <= 1 }
        case 2: return typeFilteredPhones.filter { $0.storageOrSetup > 1 }
        default: return typeFilteredPhones
        }
    }

    var brandFilteredPhones: [Phone] {
        switch phoneFilterBrand {
        case "all": return activeFilteredPhones
        default: return activeFilteredPhones.filter { $0.brand == phoneFilterBrand }
        }
    }

    var filteredPhones: [Phone] {
        return brandFilteredPhones
    }

    @Binding var selectedPhone: Phone?

    // MARK: - Body
    
    var body: some View {
        ZStack {
            if !filteredPhones.isEmpty {
                List(selection: $selectedPhone) {
                    ForEach(filteredPhones) { phone in
                        NavigationLink(value: phone) {
                            PhoneRowView(phone: phone)
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                dialogManager.phoneToDelete = phone
                                dialogManager.showingDeletePhone = true
                            } label: {
                                Label("Delete…", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
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
        .contextMenu {
            PhoneListDetailOptions(menu: true)
                .toggleStyle(.automatic)
        }
        .onChange(of: filteredPhones, { oldValue, newValue in
            if let phone = selectedPhone, !newValue.contains(phone) {
                    selectedPhone = nil
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
        }  message: {
            Text("Please disable all filters and try again.")
        }
        .toolbar {
            toolbarContent
        }
    }
    
    // MARK: - Toolbar
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem {
            Button(action: addItem) {
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
                PhoneCountButton()
                .badge(phones.count)
                PhoneTypeDefinitionsButton()
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
            Picker("Phone Type (\(phoneFilterType == "all" ? "Off" : "On"))", selection: $phoneFilterType) {
                Text("All").tag("all")
                Divider()
                Text("Cordless or Corded/Cordless Phones").tag(Phone.PhoneType.cordless.rawValue.lowercased())
                Text("Corded Phones").tag(Phone.PhoneType.corded.rawValue.lowercased())
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
            Picker("Brand (\(phoneFilterBrand == "all" ? "Off" : "On"))", selection: $phoneFilterBrand) {
                Text("All").tag("all")
                Divider()
                ForEach(allBrands.sorted(by: <), id: \.self) { brand in
                    Text(brand).tag(brand)
                }
            }
            .pickerStyle(.menu)
            .toggleStyle(.automatic)
            Divider()
            Button("Reset") {
                resetPhoneFilter()
            }
        }
    }

    // MARK: - Reset Phone Filter

    func resetPhoneFilter() {
        phoneFilterType = "all"
        phoneFilterBrand = "all"
        phoneFilterActive = 0
    }

    // MARK: - Data Management
    
    private func addItem() {
        withAnimation {
            // 1. Create a new Phone object with a mock brand and model number.
            let newPhone = Phone(brand: Phone.mockBrand, model: Phone.mockModel)
            // 2. Set the default selections.
            newPhone.landlineConnectedTo = defaultAnalogPhoneConnectedToSelection
            newPhone.whereAcquired = defaultAcquisitionMethod
            // A phone's phoneNumberInCoollection property is the index of the phone in the list, and as with any index, it starts at 0. The number of phones in the list before the new phone is added can be used as the phone's index without adding/subtracting 1.
            newPhone.phoneNumberInCollection = phones.count
            // 3. Insert the new phone into the model context.
            modelContext.insert(newPhone)
            // 4. Disable the phone filter.
            resetPhoneFilter()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                dialogManager.phoneToDelete = phones[index]
                dialogManager.showingDeletePhone = true
            }
        }
    }

    private func moveItems(source: IndexSet, destination: Int) {
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
            // 4. Use the copy's items and their indicies to move the phones in the original array.
            for (index, phone) in phonesCopy.reversed().enumerated() {
                if let originalPhone = phones.filter({ $0.id == phone.id}).first {
                    originalPhone.phoneNumberInCollection = index
                }
            }
        }
    }

    func deletePhone(_ phone: Phone) {
        // 1. Delete the phone.
        dialogManager.phoneToDelete = nil
        modelContext.delete(phone)
        // 2. Clear the phone selection.
        selectedPhone = nil
        // 3. For any phone whose index is higher than the one that was just deleted, decrease phoneNumberInCollection by 1.
        if let phoneIndex = Array(phones.reversed()).firstIndex(of: phone) {
            phones.reversed().forEach {
                if $0.phoneNumberInCollection > phoneIndex {
                    $0.phoneNumberInCollection -= 1
                }
            }
        }
    }

    func deleteAllPhones() {
        // 1. Clear the phone selection.
        selectedPhone = nil
        // 2. Delete each phone.
        for phone in phones {
            modelContext.delete(phone)
        }
    }
    
}

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
