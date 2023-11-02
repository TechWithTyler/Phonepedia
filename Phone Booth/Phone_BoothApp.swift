//
//  Phone_BoothApp.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct Phone_BoothApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
				.sheftAppsStylishUIDesign(buttonBorders: .unmodified)
        }
		.modelContainer(for: [Phone.self, CordlessHandset.self, Charger.self])
    }
}
