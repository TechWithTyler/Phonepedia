//
//  ContentView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
	
    @Query private var phones: [Phone]

	var body: some View {
		NavigationSplitView {
			ZStack {
				if !phones.isEmpty {
					List {
						ForEach(phones) { phone in
							NavigationLink {
								Text(phone.model)
							} label: {
								Text(phone.model)
							}
							.contextMenu {
								Button {
									deletePhone(phone)
								} label: {
									Label("Delete", image: "trash")
								}
							}
						}
						.onDelete(perform: deleteItems)
					}
				} else {
					Text("No phones")
						.font(.largeTitle)
						.foregroundStyle(Color.secondary)
				}
			}
			#if os(macOS)
			.touchBar {
				Button(action: addItem) {
					Label("Add Phone", systemImage: "plus")
				}
			}
			#endif
			.toolbar {
#if os(iOS)
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
#endif
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Phone", systemImage: "plus")
					}
				}
			}
		} detail: {
		Text("Select a phone")
        }
    }

    private func addItem() {
        withAnimation {
			modelContext.insert(
				object: Phone(brand: "Panasonic",
							  model: "KX-TGF975S")
			)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
               deletePhone(phones[index])
            }
        }
    }

	func deletePhone(_ phone: Phone) {
		modelContext.delete(phone)
	}
}

#Preview {
    ContentView()
        .modelContainer(for: Phone.self, inMemory: true)
}
