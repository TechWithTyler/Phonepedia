//
//  PhoneListView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/21/23.
//

import SwiftUI
import SwiftData
import SheftAppsStylishUI

struct PhoneListView: View {
    
    // MARK: - Properties - Objects
    
    @Environment(\.modelContext) private var modelContext

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    var phones: [Phone]
    
    @Binding var selectedPhone: Phone?

    @State var phoneFilter: Int = 0

    var cordlessPhones: [Phone] {
        return phones.filter { $0.isCordless || $0.isCordedCordless }
    }

    var cordedPhones: [Phone] {
        return phones.filter { $0.numberOfIncludedCordlessHandsets == 0 }
    }

    var filteredPhones: [Phone] {
        switch phoneFilter {
        case 1: return cordlessPhones
        case 2: return cordedPhones
        default: return phones
        }
    }

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
                }
                .accessibilityIdentifier("PhonesList")
            } else if phoneFilter > 0 {
                VStack {
                    Text("No phones of the selected type")
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
        .onChange(of: phoneFilter, { oldValue, newValue in
            selectedPhone = nil
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
#if os(macOS)
        .navigationSplitViewColumnWidth(300)
#endif
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
        ToolbarItem {
            Menu("Filter", systemImage: phoneFilter == 0 ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill") {
                Picker("Phone Type", selection: $phoneFilter) {
                    Text("All").tag(0)
                        .badge(phones.count)
                    Text("Cordless or Corded/Cordless Phones").tag(1)
                        .badge(cordlessPhones.count)
                    Text("Corded Phones").tag(2)
                        .badge(cordedPhones.count)
                }
                .pickerStyle(.inline)
                .toggleStyle(.automatic)
            }
        }
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
                Button("Help…", systemImage: "questionmark.circle") {
                    showHelp()
                }
                #endif
            }
        }
    }
    
    // MARK: - Data Management
    
    private func addItem() {
        withAnimation {
            // 1. Create a new Phone object with a mock brand and model number.
            let newPhone = Phone(brand: "Some Brand", model: "M123")
            // 2. Insert the new phone into the model context.
            modelContext.insert(newPhone)
            // 3. Disable the phone type filter.
            phoneFilter = 0
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
    
    func deletePhone(_ phone: Phone) {
        // 1. Delete the phone.
        dialogManager.phoneToDelete = nil
        modelContext.delete(phone)
        // 2. Clear the phone selection.
        selectedPhone = nil
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
