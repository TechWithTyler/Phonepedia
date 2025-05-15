//
//  DocumentTypes.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/24/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import Foundation
import UniformTypeIdentifiers

extension UTType {

    static var phonepediaCatalog: UTType {
        UTType(importedAs: "com.tylersheft.PhonepediaDatabase")
    }

}

