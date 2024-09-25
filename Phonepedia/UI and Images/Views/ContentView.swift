//
//  ContentView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
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
        .sheet(isPresented: $dialogManager.showingAboutDisplayTypes, content: { AboutDisplayTypesView() })
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
        #if os(iOS)
        .pickerStyle(.navigationLink)
        #endif
        .formNumericTextFieldStepperVisibility(true)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
        .environmentObject(PhonePhotoViewModel())
}
