//
//  PhoneColorInfoView.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/19/23.
//

import SwiftData
import SwiftUI

struct PhonePartInfoView: View {

	@Bindable var phone: Phone

	var body: some View {
		Section(phone.isCordless ? "Base Colors" : "Colors") {
			TextField("Base Color", text: $phone.baseColor)
			TextField("Corded Receiver Color", text: $phone.cordedReceiverColor)
				.onChange(of: phone.cordedReceiverColor) { oldValue, newValue in
					if !newValue.isEmpty {
						for handset in phone.cordlessHandsetsIHave {
							handset.fitsOnBase = false
						}
						phone.hasTransmitOnlyBase = false
						phone.baseChargingDirection = 0
						phone.baseChargeContactMechanism = 0
						phone.baseChargeContactPlacement = 0
					}
				}
		}
		if phone.isCordless {
			Section("Cordless Handsets/Headsets/Speakerphones/Desksets") {
				if !phone.cordlessHandsetsIHave.isEmpty {
						ForEach($phone.cordlessHandsetsIHave) { handset in
							NavigationLink {
								HandsetInfoDetailView(handset: handset, handsetNumber: (phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue) ?? 0) + 1)
							} label: {
								VStack {
									Text("\(handset.wrappedValue.brand) \(handset.wrappedValue.model)")
									Text("Handset \((phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue) ?? 0) + 1)")
										.foregroundStyle(.secondary)
								}
							}
							.contextMenu {
								Button {
									deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue)!)
								} label: {
									Text("Delete")
								}
							}
						}
						.onDelete(perform: deleteItemsFromHandsetList(offsets:))
				} else {
					Text("No handsets")
						.foregroundStyle(.secondary)
				}
				if phone.cordlessHandsetsIHave.count < phone.maxCordlessHandsets {
					Button(action: addHandset) {
						Label("Add", systemImage: "plus")
							.frame(width: 100, alignment: .leading)
					}
					.buttonStyle(.borderless)
				} else if phone.cordlessHandsetsIHave.count > phone.maxCordlessHandsets {
					HStack {
						Image(systemName: "exclamationmark.triangle")
							.symbolRenderingMode(.multicolor)
						Text("You have more handsets than the base can handle!")
					}
					.font(.callout)
					.foregroundStyle(.secondary)
				}
				Button {
					phone.cordlessHandsetsIHave.removeAll()
					phone.chargersIHave.removeAll()
				} label: {
					Text("Deregister All")
				}
			}
			Section("Chargers") {
				if !phone.chargersIHave.isEmpty {
						ForEach($phone.chargersIHave) { charger in
							NavigationLink {
								ChargerInfoDetailView(charger: charger)
							} label: {
								VStack {
									Text("Charger \((phone.chargersIHave.firstIndex(of: charger.wrappedValue) ?? 0) + 1)")
								}
							}
								.contextMenu {
									Button {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger.wrappedValue)!)
									} label: {
										Text("Delete")
									}
								}
						}
						.onDelete(perform: deleteItemsFromChargerList(offsets:))
				} else {
					Text("No chargers")
						.foregroundStyle(.secondary)
				}
					Button(action: addCharger) {
						Label("Add", systemImage: "plus")
							.frame(width: 100, alignment: .leading)
					}
					.buttonStyle(.borderless)
			}
		}
	}

	func addHandset() {
		phone.cordlessHandsetsIHave.append(
			CordlessHandset(brand: phone.brand, model: "MH12")
		)
	}

	func addCharger() {
		phone.chargersIHave.append(Charger())
	}

	private func deleteItemsFromHandsetList(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				deleteHandset(at: index)
			}
		}
	}

	func deleteHandset(at index: Int) {
		phone.cordlessHandsetsIHave.remove(at: index)
	}

	private func deleteItemsFromChargerList(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				deleteCharger(at: index)
			}
		}
	}

	func deleteCharger(at index: Int) {
		phone.chargersIHave.remove(at: index)
	}

}

//#Preview {
//	PhonePartInfoView(phone: Phone.preview)
//}
