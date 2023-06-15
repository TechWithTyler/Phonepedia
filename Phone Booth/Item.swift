//
//  Item.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/15/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
