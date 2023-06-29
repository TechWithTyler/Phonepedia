//
//  Phone_BoothApp.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//

import SwiftUI
import SwiftData

@main
struct Phone_BoothApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(for: [Phone.self, CordlessHandset.self, Charger.self])
    }
}
