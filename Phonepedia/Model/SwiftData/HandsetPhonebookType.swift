//
//  HandsetPhonebookType.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/26/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import Foundation

extension CordlessHandset {

    // Types of phonebooks available to a cordless handset/deskset.
    enum HandsetPhonebookType : String {

        // MARK: - Handset Phonebook Types

        // The phonebook is stored in each device separately.
        case individual = "Individual"

        // The phonebook is stored in the base and is shared by all devices.
        case shared = "Shared"

        // The device has its own phonebook but can also access the one in the base.
        case sharedAndIndividual = "Shared and Individual"

    }

}
