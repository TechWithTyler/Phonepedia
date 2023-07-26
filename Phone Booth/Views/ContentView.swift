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

	@State private var selectedPhone: Phone?

//	@State private var showingDeleteOne: Bool = false

	@State private var showingDeleteAll: Bool = false

	var body: some View {
		NavigationSplitView {
			ZStack {
				if !phones.isEmpty {
					List(selection: $selectedPhone) {
						ForEach(phones) { phone in
							NavigationLink(value: phone) {
								PhoneRowView(phone: phone)
//									.alert("Delete this phone?", isPresented: $showingDeleteOne, presenting: phone) { phone in
//										Button(role: .destructive) {
//											deletePhone(phone)
//											showingDeleteOne = false
//										} label: {
//											Text("Delete")
//										}
//										Button(role: .cancel) {
//											showingDeleteOne = false
//										} label: {
//											Text("Cancel")
//										}
//									} message: { phone in
//										Text("\(phone.brand) \(phone.model) will be deleted from your database.")
//									}
							}
							.contextMenu {
								Button {
									deletePhone(phone)
//									showingDeleteOne = true
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
				ToolbarItem {
					Button(action: deleteAllPhones) {
						Label("Delete All", systemImage: "trash")
							.labelStyle(.titleAndIcon)
					}
				}
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

    private func addItem() {
        withAnimation {
			modelContext.insert(
				Phone(brand: "Some Brand", model: "M123", photoData: Phone.previewPhotoData, baseColor: "Black", cordedReceiverColor: "Black", numberOfIncludedCordlessHandsets: 2, maxCordlessHandsets: 5, cordlessHandsetsIHave: [CordlessHandset(model: "MH12", color: "Black"), CordlessHandset(model: "MH12", color: "Black")], chargersIHave: [Charger(color: "Black"), Charger(color: "Black")], handsetRingtones: 1, handsetMusicRingtones: 0, handsetHasSeparateIntercomTone: false, canChangeHandsetIntercomTone: false, baseRingtones: 0, baseMusicRingtones: 0, baseHasSeparateIntercomTone: false, canChangeBaseIntercomTone: false, hasIntercom: true, hasBaseIntercom: false, landlineInUseStatusOnBase: 0, cellLineInUseStatusOnBase: 0, reversibleHandset: false, hasAnsweringSystem: 3, answeringSystemMenuOnHandset: 3, answeringSystemMenuOnBase: 0, greetingRecordingOnBaseOrHandset: 1, hasMessageAlertByCall: false, hasGreetingOnlyMode: true, voicemailIndication: 3, voicemailQuickDial: 4, hasHandsetSpeakerphone: true, hasBaseSpeakerphone: false, hasBaseKeypad: false, hasTalkingCallerID: false, handsetDisplayType: 1, baseDisplayType: 1, cordedPowerSource: 0, cordlessPowerBackupMode: 1, baseSupportsWiredHeadsets: false, handsetSupportsWiredHeadsets: false, baseBluetoothHeadphonesSupported: 0, handsetBluetoothHeadphonesSupported: 0, baseBluetoothCellPhonesSupported: 0, hasCellPhoneVoiceControl: false, basePhonebookCapacity: 0, handsetPhonebookCapacity: 10, baseCallerIDCapacity: 0, handsetCallerIDCapacity: 10, baseRedialCapacity: 0, handsetRedialCapacity: 3, redialNameDisplay: 0, baseSpeedDialCapacity: 0, handsetSpeedDialCapacity: 0, hasSharedSpeedDial: false, handsetOneTouchDialCapacity: 0, baseOneTouchDialCapacity: 0, hasSharedOneTouchDial: false, oneTouchDialSupportsHandsetNumbers: false, speedDialPhonebookEntryMode: 0, callBlockCapacity: 0, callBlockSupportsPrefixes: false, blockedCallersHear: 0, hasFirstRingSuppression: false, hasOneTouchCallBlock: false, callBlockPreProgrammedDatabaseEntryCount: 0, callBlockPreScreening: 0, callBlockPreScreeningAllowedNameCapacity: 0, callBlockPreScreeningAllowedNumberCapacity: 0)
			)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
//               showingDeleteOne = true
				deletePhone(phones[index])
            }
        }
    }

	func deletePhone(_ phone: Phone) {
		modelContext.delete(phone)
		selectedPhone = nil
	}

	func deleteAllPhones() {
		for phone in phones {
			modelContext.delete(phone)
		}
	}
}

#Preview {
    ContentView()
        .modelContainer(for: Phone.self, inMemory: true)
}
