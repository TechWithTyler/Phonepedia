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
    
    var phones: [Phone]
    
    @Binding var selectedPhone: Phone?
    
    @State private var phoneToDelete: Phone? = nil

    // MARK: - Properties - Booleans

    @Binding var showingPhoneTypeDefinitions: Bool

    @State private var showingDeleteOne: Bool = false
    
    @State private var showingDeleteAll: Bool = false

    @State private var showingPhoneCount: Bool = false

    // MARK: - Body
    
    var body: some View {
        ZStack {
            if !phones.isEmpty {
                    List(selection: $selectedPhone) {
                        ForEach(phones) { phone in
                            NavigationLink(value: phone) {
                                PhoneRowView(phone: phone)
                                    .alert("Delete this phone?", isPresented: $showingDeleteOne, presenting: phoneToDelete) { phoneToDelete in
                                        Button(role: .destructive) {
                                            showingDeleteOne = false
                                            deletePhone(phoneToDelete)
                                        } label: {
                                            Text("Delete")
                                        }
                                        Button(role: .cancel) {
                                            showingDeleteOne = false
                                            self.phoneToDelete = nil
                                        } label: {
                                            Text("Cancel")
                                        }
                                    } message: { phone in
                                        Text("\(phone.brand) \(phone.model) will be deleted from this database.")
                                    }
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    phoneToDelete = phone
                                    showingDeleteOne = true
                                } label: {
                                    Label("Delete…", systemImage: "trash")
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .accessibilityIdentifier("PhonesList")
            } else {
                Text("No phones")
                    .font(.largeTitle)
                    .foregroundStyle(Color.secondary)
            }
        }
        .sheet(isPresented: $showingPhoneCount) {
            PhoneCountView(phones: phones)
        }
#if os(macOS)
        .navigationSplitViewColumnWidth(300)
#endif
        .alert("Delete all phones from this database?", isPresented: $showingDeleteAll) {
            Button(role: .destructive) {
                showingDeleteAll = false
                deleteAllPhones()
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                showingDeleteAll = false
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("All phones will be deleted from this database.")
        }
        .toolbar {
            toolbarContent
        }
    }
    
    // MARK: - Toolbar
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem {
            OptionsMenu(title: .menu) {
                Button(action: addItem) {
                    Label("Add Phone", systemImage: "plus")
                }
                .accessibilityIdentifier("AddPhoneButton")
                Button("Phone Count…") {
                    showingPhoneCount = true
                }
                .badge(phones.count)
                Button("Phone Type Definitions…") {
                    showingPhoneTypeDefinitions = true
                }
                Divider()
                Button(role: .destructive) {
                    showingDeleteAll = true
                } label: {
                    Label("Delete All…", systemImage: "trash.fill")
                }
            }
        }
    }
    
    // MARK: - Data Management
    
    private func addItem() {
        withAnimation {
            let newPhone = Phone(brand: "Some Brand", model: "M123")
            modelContext.insert(newPhone)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                phoneToDelete = phones[index]
                showingDeleteOne = true
            }
        }
    }
    
    func deletePhone(_ phone: Phone) {
        phoneToDelete = nil
        modelContext.delete(phone)
        selectedPhone = nil
    }
    
    func deleteAllPhones() {
        selectedPhone = nil
        for phone in phones {
            modelContext.delete(phone)
        }
    }
    
}

#Preview {
    @State @Previewable var selectedPhone: Phone?
    @Previewable @Query var phones: [Phone] = []
    @State @Previewable var showingPhoneTypeDefinitions: Bool = false
    NavigationStack {
        PhoneListView(phones: phones, selectedPhone: $selectedPhone, showingPhoneTypeDefinitions: $showingPhoneTypeDefinitions)
    }
    .modelContainer(for: [Phone.self, CordlessHandset.self, Charger.self], inMemory: true)
    .padding()
    .frame(minWidth: 400, minHeight: 400)
}
