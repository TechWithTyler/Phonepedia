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
									.alert("Delete this phone?", isPresented: $showingDeleteOne, presenting: phone) { phone in
										Button(role: .destructive) {
											deletePhone(phone)
											showingDeleteOne = false
										} label: {
											Text("Delete")
										}
										Button(role: .cancel) {
											showingDeleteOne = false
										} label: {
											Text("Cancel")
										}
									} message: { phone in
										Text("\(phone.brand) \(phone.model) will be deleted from your database.")
									}
							}
							.contextMenu {
								Button {
									showingDeleteOne = true
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
				Phone(
					brand: "Some Brand",
					model: "M123",
					photoData: Phone.previewPhotoData,
					baseColor: "Black",
					cordedReceiverColor: String(),
					numberOfIncludedCordlessHandsets: 2,
					maxCordlessHandsets: 5,
					cordlessHandsetsIHave: [],
					chargersIHave: [],
					handsetRingtones: 5,
					handsetMusicRingtones: 5,
					handsetHasSeparateIntercomTone: false,
					canChangeHandsetIntercomTone: true,
					baseRingtones: 1,
					baseMusicRingtones: 0,
					baseHasSeparateIntercomTone: false,
					canChangeBaseIntercomTone: false,
					hasBaseIntercom: false,
					landlineInUseStatusOnBase: 0,
					landlineInUseStatusOnHandset: 1,
					cellLineInUseStatusOnBase: 1,
					reversibleHandset: false,
					hasAnsweringSystem: 3,
					answeringSystemMenuOnHandset: 2,
					answeringSystemMenuOnBase: 0,
					greetingRecordingOnBaseOrHandset: 2,
					hasMessageAlertByCall: true,
					hasGreetingOnlyMode: true,
					indicatesNewVoicemail: true,
					hasVoicemailQuickDial: true,
					speedDial1IsReservedForVoicemail: false,
					hasHandsetSpeakerphone: true,
					hasBaseSpeakerphone: false,
					hasBaseKeypad: false,
					hasTalkingCallerID: true,
					handsetDisplayType: 1,
					baseDisplayType: 1,
					cordedPowerSource: 0,
					cordlessPowerBackupMode: 1,
					baseSupportsWiredHeadsets: false,
					handsetSupportsWiredHeadsets: true,
					baseSupportsBluetoothHeadphones: true,
					handsetSupportsBluetoothHeadphones: true,
					baseBluetoothCellPhonesSupported: 2,
					hasCellPhoneVoiceControl: true,
					basePhonebookCapacity: 7000,
					handsetPhonebookCapacity: 0,
					baseCallerIDCapacity: 7000,
					handsetCallerIDCapacity: 0,
					baseRedialCapacity: 0,
					handsetRedialCapacity: 5,
					baseSpeedDialCapacity: 0,
					handsetSpeedDialCapacity: 10,
					callBlockCapacity: 7000,
					callBlockSupportsPrefixes: true,
					blockedCallersHear: 3,
					hasOneTouchCallBlock: true,
					callBlockPreProgrammedDatabaseEntryCount: 20000,
					callBlockPreScreening: 2,
					callBlockPreScreeningAllowedNameCapacity: 100,
					callBlockPreScreeningAllowedNumberCapacity: 100
				)
			)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
               showingDeleteOne = true
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
