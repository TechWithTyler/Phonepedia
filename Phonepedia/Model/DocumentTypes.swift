//
//  DocumentTypes.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/24/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation
import UniformTypeIdentifiers

extension UTType {

    // MARK: - Properties - Uniform Types

    static var phonepediaCatalog: UTType {
        let typeName = "com.tylersheft.PhonepediaDatabase"
        return UTType(importedAs: typeName)
    }

}

