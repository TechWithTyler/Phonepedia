//
//  PhonePartInfoView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftData
import SwiftUI
import SheftAppsStylishUI

struct PhonePartInfoView: View {
    
    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Properties - Integers
    
    var handsetCount: Int {
        return phone.cordlessHandsetsIHave.count
    }
    
    var chargerCount: Int {
        return phone.chargersIHave.count
    }
    
    // MARK: - Body

	var body: some View {
        Section(phone.isCordless ? "Base Colors" : "Colors") {
            ColorPicker("Base Main Color", selection: phone.baseMainColorBinding)
            HStack {
                ColorPicker("Base Secondary/Accent Color", selection: phone.baseSecondaryColorBinding)
                Button("Use Main Color") {
                    phone.baseSecondaryColorBinding.wrappedValue = phone.baseMainColorBinding.wrappedValue
                }
            }
            InfoText("The main color is the top color of a base/charger or the front color of a handset. The secondary color is the color for the sides of a base/charger/handset and the back of a handset.\nSometimes, the base/charger/handset is all one color, with the secondary color used as an accent color in various places such as around the edges.")
            ClearSupportedColorPicker("Corded Receiver Main Color", selection: phone.cordedReceiverMainColorBinding) {
                Text("Make Cordless-Only")
            }
                .onChange(of: phone.cordedReceiverMainColorBinding.wrappedValue) { oldValue, newValue in
                    phone.cordedReceiverColorChanged(oldValue: oldValue, newValue: newValue)
                }
            if phone.hasCordedReceiver {
                ColorPicker("Corded Receiver Secondary/Accent Color", selection: phone.cordedReceiverSecondaryColorBinding)
            }
		}
		if phone.isCordless {
            Section("Cordless Handsets/Headsets/Speakerphones/Desksets (\(handsetCount))") {
				if !phone.cordlessHandsetsIHave.isEmpty {
						ForEach($phone.cordlessHandsetsIHave) { handset in
							NavigationLink {
								HandsetInfoDetailView(handset: handset, handsetNumber: (phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue) ?? 0) + 1)
									.navigationTitle("Handset Details")
							} label: {
								VStack {
									Text("\(handset.wrappedValue.brand) \(handset.wrappedValue.model)")
									Text("Handset \((phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue) ?? 0) + 1)")
										.foregroundStyle(.secondary)
								}
							}
							.contextMenu {
								Button(role: .destructive) {
									deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue)!)
								} label: {
									Text("Deregister")
								}
							}
							.swipeActions {
								Button(role: .destructive) {
									deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset.wrappedValue)!)
								} label: {
									Text("Deregister")
								}
							}
						}
				} else {
					Text("No cordless devices")
						.foregroundStyle(.secondary)
				}
                FormTextField("Main Cordless Device Model", text: $phone.mainHandsetModel)
                InfoText("Enter the model number of the main cordless handset or deskset included with the \(phone.brand) \(phone.model) so newly-added cordless devices will default to that model number.\nA cordless phone's main handset/deskset is registered to the base as number 1, and may have some special features, like backing up the time in case of power outage, not available to other devices on the system.")
					Button(action: addHandset) {
						Label("Add", systemImage: "plus")
							.frame(width: 100, alignment: .leading)
					}
					.buttonStyle(.borderless)
					.accessibilityIdentifier("AddHandsetButton")
                    .disabled(phone.cordlessHandsetsIHave.count >= phone.maxCordlessHandsets && phone.maxCordlessHandsets != -1)
				if phone.cordlessHandsetsIHave.count > phone.maxCordlessHandsets {
					WarningText("You have more cordless devices than the base can handle!")
				}
			}
            Section("Chargers (\(chargerCount))") {
				if !phone.chargersIHave.isEmpty {
						ForEach($phone.chargersIHave) { charger in
							NavigationLink {
								ChargerInfoDetailView(charger: charger)
									.navigationTitle("Charger Details")
							} label: {
								VStack {
									Text("Charger \((phone.chargersIHave.firstIndex(of: charger.wrappedValue) ?? 0) + 1)")
								}
							}
								.contextMenu {
									Button(role: .destructive) {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger.wrappedValue)!)
									} label: {
										Text("Delete")
									}
								}
								.swipeActions {
									Button(role: .destructive) {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger.wrappedValue)!)
									} label: {
										Text("Delete")
									}
								}
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
					.accessibilityIdentifier("AddChargerButton")
			}
            Section {
                Button(role: .destructive) {
                    phone.cordlessHandsetsIHave.removeAll()
                    phone.chargersIHave.removeAll()
                } label: {
                    Text("Delete All Handsets/Chargers")
                }
            }
		}
	}
    
    // MARK: - Data Management

	func addHandset() {
		phone.cordlessHandsetsIHave.append(
            // Newly-added handsets default to the phone's brand, the phone's main handset model number, and the phone base's colors.
            CordlessHandset(brand: phone.brand, model: phone.mainHandsetModel, mainColorRed: phone.baseMainColorRed, mainColorGreen: phone.baseMainColorGreen, mainColorBlue: phone.baseMainColorBlue, secondaryColorRed: phone.baseSecondaryColorRed, secondaryColorGreen: phone.baseSecondaryColorGreen, secondaryColorBlue: phone.baseSecondaryColorBlue)
		)
	}

	func addCharger() {
		phone.chargersIHave.append(Charger())
	}

	func deleteHandset(at index: Int) {
		phone.cordlessHandsetsIHave.remove(at: index)
	}

	func deleteCharger(at index: Int) {
		phone.chargersIHave.remove(at: index)
	}

}

#Preview {
    Form {
        PhonePartInfoView(phone: Phone(brand: "Panasonic", model: "KX-TGD892"))
    }.formStyle(.grouped)
}
