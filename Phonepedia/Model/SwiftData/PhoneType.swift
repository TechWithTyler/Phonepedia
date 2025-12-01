//
//  PhoneType.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/22/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

extension Phone {

    enum PhoneType : String {
        
        // MARK: - Phone Types
        
        case cordless = "Cordless"
        
        case corded = "Corded"

        case cordedCordless = "Corded/Cordless"
        
        case cordlessWithTransmitOnlyBase = "Cordless With Transmit-Only Base"

        case wiFiHandset = "Wi-Fi Handset"

        case cellularHandset = "Cellular Handset"

        // MARK: - Phone Type Definitions
        
        struct DictionaryEntry: Identifiable {
            
            let id: UUID = UUID()
            
            let term: String
            
            let definition: String
            
            init(_ term: String, definition: String) {
                self.term = term
                self.definition = definition
            }
            
        }
        
    }

    enum CordlessBaseType : String {

        // MARK: - Cordless Phone Base Types

        case locatorBase = "Locator Base"

        case hiddenBase = "Hidden Base"

        case messagingBase = "Messaging Base"

        case speakerphoneBase = "Speakerphone Base"

        case dialingBase = "Dialing Base"

    }

    enum CordedPhoneStyle : String {

        // MARK: - Corded Phone Styles

        case desk = "Desk"

        case slim = "Slim/Wall"

        case candlestick = "Candlestick"

        case woodenBox = "Wooden Box"

        case baseless = "Baseless"

        case novelty = "Novelty"


    }

}
