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
    
    @Query private var phones: [Phone]
    
    @State var selectedPhone: Phone?

    @State private var showingPhoneTypeDefinitions: Bool = false

    // MARK: - Body

	var body: some View {
		NavigationSplitView {
            PhoneListView(phones: phones, selectedPhone: $selectedPhone, showingPhoneTypeDefinitions: $showingPhoneTypeDefinitions)
		} detail: {
			if !phones.isEmpty {
				if let phone = selectedPhone {
                    PhoneDetailView(phone: phone, showingPhoneTypeDefinitions: $showingPhoneTypeDefinitions)
				} else {
					NoPhoneSelectedView()
				}
			} else {
				EmptyView()
			}
		}
        .sheet(isPresented: $showingPhoneTypeDefinitions) {
            PhoneTypeDefinitionsView()
        }
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
