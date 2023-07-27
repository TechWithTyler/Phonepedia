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
		}
		if phone.isCordless {
			Section("Handsets") {
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
			}
			Section("Chargers") {
				if !phone.chargersIHave.isEmpty {
					List {
						ForEach($phone.chargersIHave) { charger in
							ChargerInfoRowView(color: charger.color, chargerNumber: (phone.chargersIHave.firstIndex(of: charger.wrappedValue) ?? 0) + 1)
								.contextMenu {
									Button {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger.wrappedValue)!)
									} label: {
										Text("Delete")
									}
								}
						}
						.onDelete(perform: deleteItemsFromChargerList(offsets:))
					}
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
			CordlessHandset(phone: phone, brand: phone.brand, model: "MH12", color: phone.baseColor, keyForegroundColor: "White", keyBackgroundColor: "Black", diamondCutKeys: 2, displayType: 2, hasSpeakerphone: true, ringtones: 1, musicRingtones: 0, hasSeparateIntercomTone: false, canChangeIntercomTone: true, oneTouchDialCapacity: 0, speedDialCapacity: 10, redialCapacity: 5, displayBacklightColor: "White", softKeys: 2, keyBacklightColor: "Blue", keyBacklightAmount: 3, supportsWiredHeadsets: false, answeringSystemMenu: 3, phonebookCapacity: 0, usesBasePhonebook: true, usesBaseCallerID: true, usesBaseSpeedDial: true, usesBaseOneTouchDial: true, bluetoothHeadphonesSupported: 0, callerIDCapacity: 0)
		)
	}

	func addCharger() {
		phone.chargersIHave.append(Charger(color: "Black"))
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
