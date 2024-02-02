//
//  ContentView.swift
//  Phone Booth
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
    
    // MARK: - Body

	var body: some View {
		NavigationSplitView {
            PhoneListView(phones: phones, selectedPhone: $selectedPhone)
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
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
        #if os(iOS)
        .pickerStyle(.navigationLink)
        #endif
        .formNumericTextFieldStepperVisibility(true)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, Charger.self], inMemory: true)
}
