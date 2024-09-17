//
//  PhonepediaApp.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct PhonepediaApp: App {
    
    @ObservedObject var photoViewModel = PhonePhotoViewModel()

    var body: some Scene {
#if os(iOS) || os(visionOS)
        DocumentGroupLaunchScene {
            NewDocumentButton("New Phone Catalog")
        } background: {
            Color.accentColor
        } backgroundAccessoryView: { geometry in
            DocumentLaunchPhonesAccessoryView()
        }
#endif
        DocumentGroup(editing: .phonepediaDatabase, migrationPlan: PhonepediaMigrationPlan.self) {
            ContentView()
                .environmentObject(photoViewModel)
        }
    }
}
