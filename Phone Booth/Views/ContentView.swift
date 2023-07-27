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
				Phone(brand: "Some Brand", model: "M123", photoData: Phone.previewPhotoData, baseColor: String(), baseKeyForegroundColor: String(), baseKeyBackgroundColor: String(), diamondCutKeys: 3, cordedReceiverColor: String(), numberOfIncludedCordlessHandsets: 1, maxCordlessHandsets: 5, cordlessHandsetsIHave: [], chargersIHave: [], baseRingtones: 1, baseMusicRingtones: 0, baseHasSeparateIntercomTone: false, canChangeBaseIntercomTone: true, hasIntercom: true, hasBaseIntercom: false, landlineInUseStatusOnBase: 0, cellLineInUseStatusOnBase: 0, reversibleHandset: false, hasAnsweringSystem: 3, answeringSystemMenuOnBase: 0, greetingRecordingOnBaseOrHandset: 1, hasMessageAlertByCall: false, hasGreetingOnlyMode: true, voicemailIndication: 3, voicemailQuickDial: 2, hasBaseSpeakerphone: false, hasBaseKeypad: false, hasTalkingCallerID: false, baseDisplayType: 0, baseHasDisplayAndMessageCounter: false, baseSoftKeys: 0, baseLEDMessageCounterColor: String(), baseDisplayBacklightColor: String(), baseKeyBacklightColor: String(), baseKeyBacklightAmount: 0, cordedPowerSource: 0, cordlessPowerBackupMode: 1, baseSupportsWiredHeadsets: true, baseBluetoothHeadphonesSupported: 0, baseBluetoothCellPhonesSupported: 0, hasCellPhoneVoiceControl: true, basePhonebookCapacity: 0, baseCallerIDCapacity: 0, baseRedialCapacity: 0, redialNameDisplay: 0, baseSpeedDialCapacity: 0, baseOneTouchDialCapacity: 0, oneTouchDialSupportsHandsetNumbers: false, speedDialPhonebookEntryMode: 0, callBlockCapacity: 0, callBlockSupportsPrefixes: false, blockedCallersHear: 0, hasFirstRingSuppression: false, hasOneTouchCallBlock: false, callBlockPreProgrammedDatabaseEntryCount: 0, callBlockPreScreening: 0, callBlockPreScreeningAllowedNameCapacity: 0, callBlockPreScreeningAllowedNumberCapacity: 0)
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
