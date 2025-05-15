//
//  PhoneType.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/22/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import Foundation

extension Phone {

    enum PhoneType : String {
        
        // MARK: - Phone Types
        
        case cordless = "Cordless"
        
        case corded = "Corded"
        
        case cordedCordless = "Corded/Cordless"
        
        case cordlessWithTransmitOnlyBase = "Cordless With Transmit-Only Base"

        case wiFiHandset = "Wi-Fi Handset"

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
    
}
