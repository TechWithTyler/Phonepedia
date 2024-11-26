//
//  ContentView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - Properties - Objects

    @Environment(\.modelContext) private var modelContext

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    @Query private var phones: [Phone]
    
    @State var selectedPhone: Phone?

    // MARK: - Body

	var body: some View {
		NavigationSplitView {
            PhoneListView(phones: phones, selectedPhone: $selectedPhone)
                .environmentObject(dialogManager)
                .navigationTitle("Phone List")
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
		} detail: {
			if !phones.isEmpty {
				if let phone = selectedPhone {
                    PhoneDetailView(phone: phone)
                        .environmentObject(dialogManager)
				} else {
					NoPhoneSelectedView()
				}
			} else {
				EmptyView()
			}
		}
        .sheet(isPresented: $dialogManager.showingPhoneTypeDefinitions) {
            PhoneTypeDefinitionsView()
        }
        .sheet(isPresented: $dialogManager.showingAboutDisplayTypes) {
            AboutDisplayTypesView()
        }
        .sheet(isPresented: $dialogManager.showingFrequenciesExplanation) {
            FrequenciesExplanationView()
        }
        .sheet(isPresented: $dialogManager.showingRegistrationExplanation) {
            RegistrationExplanationView()
        }
        .sheet(isPresented: $dialogManager.showingAboutDialingCodes) {
            AboutDialingCodesView()
        }
        .sheet(isPresented: $dialogManager.showingAboutConnectionTypes) {
            AboutConnectionTypesView()
        }
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
        .formNumericTextFieldStepperVisibility(true)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
