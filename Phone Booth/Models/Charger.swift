//
//  Charger.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/28/23.
//

import Foundation
import SwiftData

@Model
final class Charger {

	var phone: Phone?

	var color: String

	init(color: String) {
		self.color = color
	}
	
}
