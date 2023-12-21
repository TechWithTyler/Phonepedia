//
//  ContentView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

	#if os(iOS)
	@Environment(\.editMode) private var editMode
	#endif

	@Query private var phones: [Phone]

	@State private var selectedPhone: Phone?

	@State private var phoneToDelete: Phone? = nil

	@State private var showingDeleteOne: Bool = false

	@State private var showingDeleteAll: Bool = false

	var body: some View {
		NavigationSplitView {
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
									Label("Delete…", image: "trash")
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
		} detail: {
			if !phones.isEmpty {
				if let phone = selectedPhone {
					PhoneDetailView(phone: phone)
				} else {
					NoPhoneSelectedView()
				}
			} else {
				EmptyView()
			}
		}
    }

	@ToolbarContentBuilder
	var toolbarContent: some ToolbarContent {
#if os(iOS)
		ToolbarItem(placement: .topBarTrailing) {
			EditButton()
		}
#endif
		ToolbarItem {
			Button(action: addItem) {
				Label("Add Phone", systemImage: "plus")
			}
			.accessibilityIdentifier("AddPhoneButton")
#if os(iOS)
			.disabled((editMode?.wrappedValue.isEditing)!)
#endif
		}
			ToolbarItem {
                Button(role: .destructive) {
					showingDeleteAll = true
				} label: {
					Label("Delete All…", systemImage: "trash.fill")
						.labelStyle(.iconOnly)
				}
#if os(iOS)
				.disabled((editMode?.wrappedValue.isEditing)!)
#endif
		}
	}

    private func addItem() {
        withAnimation {
			modelContext.insert(
				Phone(brand: "Some Brand", model: "M123")
			)
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
    ContentView()
        .modelContainer(for: Phone.self, inMemory: true)
}
