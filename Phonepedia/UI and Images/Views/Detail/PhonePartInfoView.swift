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
						ForEach(phone.cordlessHandsetsIHave) { handset in
							NavigationLink {
								HandsetInfoDetailView(handset: handset, handsetNumber: (phone.cordlessHandsetsIHave.firstIndex(of: handset) ?? 0) + 1)
									.navigationTitle("Handset Details")
							} label: {
								VStack {
									Text("\(handset.brand) \(handset.model)")
									Text("Handset \((phone.cordlessHandsetsIHave.firstIndex(of: handset) ?? 0) + 1)")
										.foregroundStyle(.secondary)
								}
							}
							.contextMenu {
                                Button {
                                    duplicateHandset(handset)
                                } label: {
                                    Label("Duplicate", systemImage: "doc.on.doc")
                                }
                                Divider()
								Button(role: .destructive) {
									deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset)!)
								} label: {
                                    Label("Delete", systemImage: "trash")
								}
							}
							.swipeActions {
								Button(role: .destructive) {
									deleteHandset(at: phone.cordlessHandsetsIHave.firstIndex(of: handset)!)
								} label: {
                                    Label("Delete", systemImage: "trash")
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
						ForEach(phone.chargersIHave) { charger in
							NavigationLink {
								ChargerInfoDetailView(charger: charger)
									.navigationTitle("Charger Details")
							} label: {
								VStack {
									Text("Charger \((phone.chargersIHave.firstIndex(of: charger) ?? 0) + 1)")
								}
							}
								.contextMenu {
                                    Button {
                                        duplicateCharger(charger)
                                    } label: {
                                        Label("Duplicate", systemImage: "doc.on.doc")
                                    }
                                    Divider()
									Button(role: .destructive) {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger)!)
									} label: {
                                        Label("Delete", systemImage: "trash")
									}
								}
								.swipeActions {
									Button(role: .destructive) {
										deleteCharger(at: phone.chargersIHave.firstIndex(of: charger)!)
									} label: {
                                        Label("Delete", systemImage: "trash")
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
                    Label("Delete All Handsets/Chargers", systemImage: "trash.fill")
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

    func duplicateHandset(_ handset: CordlessHandset) {
        let newHandset = handset.duplicate()
        if let index = phone.cordlessHandsetsIHave.firstIndex(of: handset) {
            phone.cordlessHandsetsIHave.insert(newHandset, at: index + 1)
        }
    }

	func addCharger() {
		phone.chargersIHave.append(CordlessHandsetCharger())
	}

	func deleteHandset(at index: Int) {
		phone.cordlessHandsetsIHave.remove(at: index)
	}

	func deleteCharger(at index: Int) {
		phone.chargersIHave.remove(at: index)
	}

    func duplicateCharger(_ charger: CordlessHandsetCharger) {
        let newCharger = charger.duplicate()
        if let index = phone.chargersIHave.firstIndex(of: charger) {
            phone.chargersIHave.insert(newCharger, at: index + 1)
        }
    }

}

#Preview {
    Form {
        PhonePartInfoView(phone: Phone(brand: "Panasonic", model: "KX-TGD892"))
    }.formStyle(.grouped)
}
